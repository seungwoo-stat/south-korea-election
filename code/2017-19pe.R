library(tidyverse)
library(readxl)

kor2eng <- read_excel("../kor2eng.xlsx")

## Data generation -------------------------------------------------------------
data_real <- tibble()
filenames <- list.files("../raw/2017-19pe")
for(i in seq_along(filenames)){
  x <- read_excel(paste0("../raw/2017-19pe/",filenames[i]), skip = 6, col_names = FALSE)[,-c(2:3,11,18)]
  colnames(x) <- c("secondary_cluster",
                   "Moon Jae-in (Deomcratic)",
                   "Hong Joon-pyo (Liberty Korea)",
                   "Ahn Cheol-soo (People's)",
                   "Yoo Seong-min (Bareum)",
                   "Sim Sang-jung (Justice)",
                   "Cho Won-jin (Saenuri)",
                   "Oh Young-guk (Economic Patriots)",
                   "Jang Seong-min (Grand National United)",
                   "Lee Jae-oh (Evergreen Korea)",
                   "Kim Seon-dong (People's United)",
                   "Lee Kyung-hee (Korean Nationalist)",
                   "Yoon Hong-sik (Hongik)",
                   "Kim Min-chan (Independent)",
                   "invalid",
                   "blank")
  m <- nrow(x)
  for(j in 2:14){
    x[,j] <- sapply(1:m,function(k) substr(x[k,j],0,str_locate(x[k,j],"\n")-1))
    x[,j] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,j]))))
  }
  x[,15] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,15]))))
  x[,16] <- sapply(1:m,function(k) as.numeric(sub(",", "",str_trim(x[k,16]))))
  
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
write.csv(data_real,file="../csv/19pe.csv", row.names = FALSE, fileEncoding = "UTF-8")

## -----------------------------------------------------------------------------
data_real <- read.csv("../csv/19pe.csv")
