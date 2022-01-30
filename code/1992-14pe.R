library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/1992-14pe")
for(i in seq_along(filenames)){
  print(i)
  print(filenames[i])
  x <- read_excel(paste0("../raw/1992-14pe/",filenames[i]), skip = 6, col_names = FALSE)[,-c(2:3,8,12)]
  colnames(x) <- c("secondary_cluster",
                   "Kim Young-sam	(Democratic Liberal)",
                   "Kim Dae-jung (Democratic)",
                   "Chung Ju-yung	(Unification National)",
                   "Park Chan-jong (New Political Reform)",
                   "Lee Byeong-ho	(Korean Justice)",
                   "Kim Ok-sun (Independent)",
                   "Baek Gi-Wan	(Independent)",
                   "invalid",
                   "blank")
  m <- nrow(x)
  for(j in 2:8){
    x[,j] <- sapply(1:m,function(k) substr(x[k,j],0,str_locate(x[k,j],"\n")-1))
    x[,j] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,j]))))
  }
  x[,9] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,9]))))
  x[,10] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,10]))))
  
  province <- substring(filenames[i],1,nchar(filenames[i])-5)
  name_match = kor2eng[kor2eng$city_province_eng == province,]
  x <- cbind(primary_cluster=rep(province,m),x)
  # remove parenthesis
  paren <- str_locate(x$secondary_cluster,"\\(")[,1]
  x$secondary_cluster[!is.na(paren)] <- substr(x$secondary_cluster[!is.na(paren)], 1, paren[!is.na(paren)]-1)
  # gap, eul, byeong
  gap <- endsWith(x$secondary_cluster,"갑")
  eul <- endsWith(x$secondary_cluster,"을")
  byeong <- endsWith(x$secondary_cluster,"병")
  geb <- gap | eul | byeong
  x$secondary_cluster <- name_match$gu_eng[sapply(1:m, \(ii) which(ifelse(geb[ii],substr(x$secondary_cluster[ii],1,str_length(x$secondary_cluster[ii])-1),x$secondary_cluster[ii])==name_match$gu_kor))]
  x$secondary_cluster[gap] <- paste0(x$secondary_cluster[gap],"-A")
  x$secondary_cluster[eul] <- paste0(x$secondary_cluster[eul],"-B")
  x$secondary_cluster[byeong] <- paste0(x$secondary_cluster[byeong],"-C")
  data_real <- bind_rows(data_real,x)
}

# validations
data_real[data_real$primary_cluster=="Busan",-(1:2)] |> colSums()
data_real[data_real$primary_cluster=="Gyeonggi-do",-(1:2)] |> colSums()

# save as csv
write.csv(data_real,file="../csv/14pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/14pe.csv")
