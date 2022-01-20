library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/2007-17pe")
for(i in seq_along(filenames)){
  print(i)
  print(filenames[i])
  x <- read_excel(paste0("../raw/2007-17pe/",filenames[i]), skip = 6, col_names = FALSE)[,-c(2:3,9,15)]
  colnames(x) <- c("secondary_cluster",
                   "Chung Dong-young (Grand Unified Democratic New)",
                   "Lee Myung-bak 	(Grand National)",
                   "Kwon Young-ghil	(Democratic Labor)",
                   "Lee In-je	(Democratic)",
                   "Moon Kook-hyun (Creative Korea)",
                   "Chung Kun-mo (True Owner Coalition)",
                   "Huh Kyung-young	(Economic Republican)",
                   "Chun Kwan	(Chamsaram Society Full True Act)",
                   "Geum Min (Socialist)",
                   "Lee Hoi-chang	(Independent)",
                   "invalid",
                   "blank")
  m <- nrow(x)
  for(j in 2:11){
    x[,j] <- sapply(1:m,function(k) substr(x[k,j],0,str_locate(x[k,j],"\n")-1))
    x[,j] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,j]))))
  }
  x[,12] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,12]))))
  x[,13] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,13]))))
  
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
write.csv(data_real,file="../csv/17pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/17pe.csv")
