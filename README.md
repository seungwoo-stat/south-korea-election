# South Korea Election

Presidential election results in South Korea (Republic of Korea) held in the Sixth Republic (1988~), for compositional data analysis. 



### Repo Description

- [`code`](code): R codes for converting raw excel files to a single csv file per election.
- [`csv`](csv): data set generated for use.
- [`raw`](raw): raw data files fetched from National Election Commission (NEC) of Korea.
- [`kor2eng.xlsx`](kor2eng.xlsx): list of Korean district names in English.



### List of Data Sets

- 2022.03.09., 20th presidential election (to be updated) 
- 2017.05.09., 19th presidential election (n = 250)
- 2012.12.19., 18th presidential election (n = 251)
- 2007.12.19., 17th presidential election (n = 248)
- 2002.12.19., 16th presidential election (n = 244)
- 1997.12.18., 15th presidential election (n = 303)
  - From this election and previously held ones, some secondary clusters are separated into "gap", "eul", "byeong" regions (indicate orderings in Korea). These characters are replaced to -A, -B, -C, respectively. 
- 1992.12.18., 14th presidential election (n = 308)



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
- Secondary clusters are **not** identical for all data sets. See [Misc.](#misc) for details.

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
- *Cheonan-si* separated to two regions (*Seobuk-gu, Cheonan-si* and *Dongnam-gu, Cheonan-si*) from the 18th pe.
- Chungcheongnam-do *Yeongi-gun* incorporated into *Sejong-si* as of 2012.07.01.
- Chungcheongnam-do *Dangjin-gun* became *Dangjin-si* on 2012.01.01. 
- Gyeongsangnam-do *Changwon-si* separated to five regions from the 18th pe. This is due to incorporation of *Masan-si* and *Jinhae-si*  into *Changwon-si*.
- Gyeonggi-do *Yangju-gun* became *Yangju-si* on 2003.
- Gyeonggi-do *Ilsan-si* separated to *Ilsandong-gu* and *Ilsanseo-gu* on 2005.
- Gyeonggi-do *Yongin-si* separated to three regions from 17th pe.
- Gyeonggi-do *Pocheon-gun* became *Pocheon-si* on 2003.
- Jeju-do *Bukjeju-gun* got incorporated into *Jeju-si* on 2006.
- Jeju-do *Namjeju-gun* got incorporated into *Seogwipo-si* on 2006.
- Gyeonggi-do *Hwaseong-gun* became *Hwaseong-si* on 2001.03.21.
- Gyeonggi-do *Gwangju-gun* became *Gwangju-si* on 2001.03.21.
- Gyeonggi-do *Gimpo-gun* became *Gimpo-si* on 1998.04.01.
- Gyeonggi-do *Anseong-gun* became *Anseong-si* on 1998.04.01.
- Gyeongsangnam-do *Hoewon-gu, Masan-si* and *Happo-gu, Masan-si* disappeared from the 16th pe.
- Jeollanam-do *Yeocheon-si* and *Yeocheon-gun* got incorporated into *Yeosu-si* on 1998.04.01.
- *Ulsan* separated from *Gyeongsangnam-do* from 1997 election.
- Chungcheongbuk-do *Jecheon-gun* got incorporated into *Jecheon-si* on 1995.
- Chungcheongbuk-do *Jungwon-gun* got incorporated into *Chungju-si* on 1995.
- Chungcheongnam-do *Gongju-gun* got incorporated into *Gongju-si* on 1995.
- Chungcheongnam-do *Daecheon-si* and *Boryeong-gun* became *Boryeong-si* on 1995.
- Chungcheongnam-do *Onyang-si* and *Asan-gun* became *Asan-si* on 1995.
- Chungcheongnam-do *Nonsan-gun* became *Nonsan-si* on 1996.
- Chungcheongnam-do *Seosan-gun* became *Seosan-si* on 1995.
- Chungcheongnam-do *Cheonan-gun* got incorporated into*Cheonan-si* on 1995.
- Gangwon-do *Myungju-gun* got incorporated into *Gangneung-si* on 1995.
- Gangwon-do *Samcheok-gun* became *Samcheok-si* on 1995.
- Gangwon-do *Chuncheon-gun* became *Chuncheon-si* on 1995.
- Gangwon-do *Wonju-gun* got incorporated into *Wonju-si* on 1995.
- Gyeonggi-do *Jung-gu, Bucheon-si* and *Nam-gu, Bucheon-si* got separated or changed their names on 1993.
- Gyeonggi-do *Songtan-si* and *Pyeongtaek-gun* got incorporated into *Pyeongtaek-si* on 1995.
- Incheon *Ongjin-gun* became Gyeonggi-do on 1995.
- Gyeonggi-do *Migeum-si* and *Namyangju-gun* got incorporated into *Namyangju-si* on 1995.
- Gyeonggi-do *Paju-gun* became *Paju-si* on 1996.
- Gyeonggi-do *Icheon-gun* became *Icheon-si* on 1996.
- Gyeonggi-do *Yongin-gun* became *Yongin-si* on 1996.
- Gyeonggi-do *Ganghwa-gun* became Incheon on 1995.
- Gyeongsangbuk-do *Pohang-si* separated into *Nam-gu* and *Buk-gu* on 1995.
- Gyeongsangbuk-do *Youngil-gun* got incorporated into *Pohang-si* on 1995.
- Gyeongsangbuk-do *Geumreung-gun* got incorporated into *Gimcheon-si* on 1995.
- Gyeongsangbuk-do *Yeongpung-gun* goe incorporated into *Yeongju-si* on 1995.
- Gyeongsangbuk-do *Yeongcheon-gun* became *Yeongcheon-si* on 1995.
- Gyeongsangbuk-do *Sangju-gun* became *Sangju-si* on 1995.
- Gyeongsangbuk-do *Jeomchon-si* and *Mungyeong-gun* got incorporated into *Mungyeong-si* on 1995.
- Gyeongsangbuk-do *Dalseong-gun* became Daegu on 1995.
- Gyeongsangbuk-do *Seonsan-gun* became *Gumi-si* on 1995.
- Gyeongsangbuk-do *Andong-gun* became *Andong-si* on 1995.
- Gyeongsangbuk-do *Gyeongju-gun* became *Gyeongju-si* on 1995.
- Gyeongsangbuk-do *Gyeongsan-gun* became *Gyeongsan-si* on 1995.
- Ulsan got separated from Gyeongsangnam-do on 1997.
- Gyeongsangnam-do *Changwon-gun* became *Changwon-si* and *Masan-si* on 1995.
- Gyeongsangnam-do *Tongyeong-gun* and *Chungmu-si* became *Tongyeong-si* on 2995.
- Gyeongsangnam-do *Samcheonpo-si* and *Sacheon-gun* became *Sacheon-si* on 1995.
- Gyeongsangnam-do *Gimhae-gun* became *Gimhae-si* on 1995.
- Gyeongsangnam-do *Jinyang-gun* became *Jinju-si* on 1995.
- Gyeongsangnam-do *Miryang-gun* became *Miryang-si* on 1995.
- Gyeongsangnam-do *Yangsan-gun* became *Yangsan-si* on 1996.
- Gyeongsangnam-do *Ulsan-gun* became *Ulsan-si* on 1995.
- Gyeongsangnam-do *Jangseungpo-si* and *Geoje-gun* became *Geoje-si* on 1995.
- Incheon *Buk-gu* got separated into *Gyeyang-gu* and *Bupyeong-gu* on 1995.
- Jeollabuk-do *Iri-si* and *Iksan-gun* became *Iksan-si* on 1995.
- Jeollabuk-do *Jeongeup-gun* and *Jungju-si* became *Jeongeup-si* on 1995.
- Jeollabuk-do *Namwon-gun* became *Namwon-si* on 1995.
- Jeollabuk-do *Gimje-gun* became *Gimje-si* on 1995.
- Jeollabuk-do *Okgu-gun* became *Gunsan-si* on 1995.
- Jeollanam-do *Naju-gun* became *Naju-si* on 1995.
- Jeollanam-do *Seungju-gun* became *Suncheon-si* on 1995.
- Jeollanam-do *Gwangyang-gun* and *Donggwangyang-si* became *Gwangyang-si* on 1995.
