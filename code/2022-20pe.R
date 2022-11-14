library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/2022-20pe")
for(i in seq_along(filenames)){
  message(filenames[i])
  x <- read_excel(paste0("../raw/2022-20pe/",filenames[i]), skip = 8, col_names = FALSE)[,-c(2:3,11,17,20)]
  colnames(x) <- c("secondary_cluster",
                   "Lee Jae-myung (Democratic)",
                   "Yoon Suk-yeol (People Power)",
                   "Sim Sang-jung (Justice)",
                   # "Ahn Cheol-soo (People)",
                   "Oh Jun-ho (Basic Income)",
                   "Huh Kyung-young (National Revolutionary Dividends)",
                   "Lee Baek-yun (Labor)",
                   "Ok Un-ho (Saenuri)",
                   # "Kim Dong-yeon (New Wave)",
                   "Kim Gyeong-jae (New Liberal Democratic Union)",
                   "Cho Won-jin (Our Republican)",
                   "Kim Jae-yeon (Progressive)",
                   "Lee Gyeong-hee (Korean Unification)",
                   "Kim Min-chan (Korean Wave Alliance)",
                   "invalid",
                   "blank")
  x <- x[!is.na(x[,1]),] # remove proportions
  m <- nrow(x)
  # for(j in 2:14){
  #   x[,j] <- sapply(1:m,function(k) substr(x[k,j],0,str_locate(x[k,j],"\n")-1))
  #   x[,j] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,j]))))
  # }
  # x[,15] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,15]))))
  # x[,16] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,16]))))
  for(j in 2:15){
    x[,j] <- sapply(1:m,function(k) as.numeric(gsub(",", "",str_trim(x[k,j]))))
  }

  
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
write.csv(data_real,file="../csv/20pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/19pe.csv")
