# South Korea Election

Election results in South Korea (Republic of Korea), for compositional data analysis. 

Invalid and blank ballots (무효표, 기권표) are omitted from the data.

Number of blank ballots refers to the number of voters who did not vote, even though they have voting rights.

- e.g. those who did not come to the polling station — blank ballot count
- e.g. those who came to the polling station but did not put their ballot to the box, for some reason — blank ballot count



### List of Data Sets

- 2017.05.09., 19th presidential election
  - n = 250

- 2012.12.19., 18th presidential election
  - n = 251

- Difference between two pe data sets. See [Misc.](#misc) for details.

```R
> eight <- read.csv("csv/18pe.csv")
> nine <- read.csv("csv/19pe.csv")
> setdiff(eight$secondary_cluster, nine$secondary_cluster)
[1] "Cheongwon-gun"         "Wonmi-gu, Bucheon-si"  "Sosa-gu, Bucheon-si"  
[4] "Ojeong-gu, Bucheon-si" "Yeoju-gun"            
> setdiff(nine$secondary_cluster, eight$secondary_cluster)
[1] "Seowon-gu, Cheongju-si"    "Cheongwon-gu, Cheongju-si"
[3] "Bucheon-si"                "Yeoju-si"     
```



### Sources

- National Election Commission of South Korea: [http://info.nec.go.kr](http://info.nec.go.kr)
- Address in English: [Naver](https://s.search.naver.com/n/csearch/content/eprender.nhn?where=nexearch&pkid=252&q=관악구%20영문주소&key=address_eng)



### Misc.

- Gyeonggi-do *Yeoju-gun* became *Yeoju-si* on 2013.09.23.
- Chungcheongbuk-do *Cheongwon-gun* became *Cheongwon-gu* on 2014.07.01. 
- Bucheon-si *Wonmi-gu*, *Sosa-gu*, *Ojeong-gu* disapperaed on 2016.07.04.
- Incheon *Nam-gu* changed their name to *Michuhol-gu* on 2018.07.01.

