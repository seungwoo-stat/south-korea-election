library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/2002-16pe")
for(i in seq_along(filenames)){
  print(i)
  print(filenames[i])
  x <- read_excel(paste0("../raw/2002-16pe/",filenames[i]), skip = 6, col_names = FALSE)[,-c(2:3,7,11)]
  colnames(x) <- c("secondary_cluster",
                   "Lee Hoi-chang	(Grand National)",
                   "Roh Moo-hyun (Millennium Democratic)",
                   "Lee Han-dong (One National People Unite)",
                   "Kwon Young-ghil	(Democratic Labor)",
                   "Kim Yeong-Gyu	(Socialist)",
                   "Kim Gil-soo	(Fatherland Defenders)",
                   "invalid",
                   "blank")
  m <- nrow(x)
  for(j in 2:7){
    x[,j] <- sapply(1:m,function(k) substr(x[k,j],0,str_locate(x[k,j],"\n")-1))
    x[,j] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,j]))))
  }
  x[,8] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,8]))))
  x[,9] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,9]))))
  
  province <- substring(filenames[i],1,nchar(filenames[i])-5)
  name_match = kor2eng[kor2eng$city_province_eng == province,]
  x <- cbind(primary_cluster=rep(province,m),x)
  # remove parenthesis
  paren <- str_locate(x$secondary_cluster,"\\(")[,1]
  x$secondary_cluster[!is.na(paren)] <- substr(x$secondary_cluster[!is.na(paren)], 1, paren[!is.na(paren)]-1)
  x$secondary_cluster <- name_match$gu_eng[sapply(1:m, \(ii) which(name_match$gu_kor == x$secondary_cluster[ii]))]
  data_real <- bind_rows(data_real,x)
}

# validations
data_real[data_real$primary_cluster=="Busan",-(1:2)] |> colSums()
data_real[data_real$primary_cluster=="Gyeonggi-do",-(1:2)] |> colSums()

# save as csv
write.csv(data_real,file="../csv/16pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/16pe.csv")
