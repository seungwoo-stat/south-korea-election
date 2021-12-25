library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/2012-18pe")
for(i in seq_along(filenames)){
  print(filenames[i])
  x <- read_excel(paste0("../raw/2012-18pe/",filenames[i]), skip = 6, col_names = FALSE)[,-c(2:3,7,11)]
  colnames(x) <- c("secondary_cluster",
                   "Park Geun-hye (Saenuri)",
                   "Moon Jae-in (Democratic United)",
                   "Park Jong-sun (Independent)",
                   "Kim So-yeon (Independent)",
                   "Kang Ji-won (Independent)",
                   "Kim Soon-ja (Independent)",
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
  x$secondary_cluster <- name_match$gu_eng[sapply(1:m, \(ii) which(name_match$gu_kor == x$secondary_cluster[ii]))]
  
  data_real <- bind_rows(data_real,x)
}

# validations
data_real[data_real$primary_cluster=="Busan",-(1:2)] |> colSums()
data_real[data_real$primary_cluster=="Gyeonggi-do",-(1:2)] |> colSums()

# save as csv
write.csv(data_real,file="../csv/18pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/18pe.csv")
