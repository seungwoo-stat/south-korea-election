# South Korea Election

Election results in South Korea (Republic of Korea), for compositional data analysis. 



### List of Data Sets

- 2017.05.09., 19th presidential election (n = 250)

- 2012.12.19., 18th presidential election (n = 251)



### Data Description

```R
> nine <- read.csv("csv/19pe.csv", check.names = FALSE) # keep original column names
> head(nine, 3)
  primary_cluster secondary_cluster Moon Jae-in (Democratic) Hong Joon-pyo (Liberty Korea)
1           Busan           Jung-gu                     9918                         10684
2           Busan            Seo-gu                    24522                         26360
3           Busan           Dong-gu                    19606                         22188
  Ahn Cheol-soo (People's) Yoo Seong-min (Bareum) Sim Sang-jung (Justice) Cho Won-jin (Saenuri)
1                     4675                   1845                    1274                    47
2                    11868                   4913                    3131                    77
3                     9815                   3606                    2589                    65
  Oh Young-guk (Economic Patriots) Jang Seong-min (Grand National United) Lee Jae-oh (Evergreen Korea)
1                                4                                     11                            3
2                                8                                     70                           14
3                               14                                     47                           19
  Kim Seon-dong (People's United) Lee Kyung-hee (Korean Nationalist) Yoon Hong-sik (Hongik)
1                              14                                  7                      9
2                              32                                 25                     51
3                              21                                 19                     31
  Kim Min-chan (Independent) invalid blank
1                         18      95 11844
2                         77     298 27090
3                         62     222 21416
```

- First two columns denote primary and secondary clusters.
- Secondary clusters are **not** identical for two data sets. See [Misc.](#misc) for details.

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
- From the third column, number of votes for each candidate is given. Column names denote the name of the candidate, followed by the name of the party in the parenthesis. Note that the last name comes before the first name.
- Last two columns are the invalid and blank vote counts.
- Number of blank ballots refers to the number of voters who did not vote, even though they have voting rights.
  - e.g. those who did not come to the polling station — blank ballot count
  - e.g. those who came to the polling station but did not put their ballot to the box, for some reason — blank ballot count
- Thus, sum of each row indicates number of people who have voting rights in that cluster. It would be preferable to delete the last column, or last two columns for analysis.




### Sources

- National Election Commission of South Korea: [http://info.nec.go.kr](http://info.nec.go.kr)
- Address in English: [Naver](https://s.search.naver.com/n/csearch/content/eprender.nhn?where=nexearch&pkid=252&q=관악구%20영문주소&key=address_eng)



### Misc.

- Gyeonggi-do *Yeoju-gun* became *Yeoju-si* on 2013.09.23.
- Chungcheongbuk-do *Cheongwon-gun* became *Cheongwon-gu* on 2014.07.01. 
- Bucheon-si *Wonmi-gu*, *Sosa-gu*, *Ojeong-gu* disappeared on 2016.07.04.
- Incheon *Nam-gu* changed their name to *Michuhol-gu* on 2018.07.01.

