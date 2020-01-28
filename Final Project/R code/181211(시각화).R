
#------------------------------시각화------------------------------

# 정리된 택시 변수

1. X : 행 인덱스
2. payment_type : 결제수단
3. total_amount : 총 요금
4. pickup_datetime : 픽업시간
5. ropoff_datetime : 도착시간
6. passenger_count : 승객 수 >>> 0값 삭제 후 '1', '1초과'로 범주화
7. trip_time_in_secs : 주행시간 >>> 14-13 맞는지 확인 
8. trip_distance : 주행거리
9. pickup_longitude : 픽업경도
10. pickup_latitude : 픽업위도
11. dropoff_longitude : 도착경도
12. dropoff_latitude :도착위도

#---------------------------------------------------------------

rm(list=ls())

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(usmap)

#미국 주 데이터
states <- map_data("state")
str(states)
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)

#뉴욕주 데이터
table(states$region) #new york : 495
newyork <- subset(states, region %in% c("new york"))
ggplot(data = newyork) +  
  geom_polygon(aes(x = long, y = lat), fill = "white", color = "black")
str(newyork)
table(newyork$subregion)

#뉴욕시 데이터
ny <- subset(newyork, subregion %in% c("long island", "manhattan"))
max(ny$long); min(ny$long)
max(ny$lat); min(ny$lat)
ny <- ny[ny$long >= -74.05 & ny$long <= -73.7, ]
ny <- ny[ny$lat >= 40.5 & ny$lat <= 40.85, ]
ny1 <- subset(ny, subregion %in% c("long island"))
ny2 <- subset(ny, subregion %in% c("manhattan"))

#택시 데이터
data <- read.csv("sample_process1.csv")

lab <- data.frame(
  long = data$pickup_longitude, lat = data$pickup_latitude,
  longs =  data$dropoff_longitude, lats = data$dropoff_latitude,
  stringsAsFactors = FALSE
) 
lab <- lab[lab$long >= -74.05 & lab$long <= -73.7, ]
lab <- lab[lab$longs >= -74.05 & lab$longs <= -73.7, ]
lab <- lab[lab$lat >= 40.5 & lab$lat <= 40.85, ]
lab <- lab[lab$lats >= 40.5 & lab$lats <= 40.85, ]

#0.5% 데이터 샘플링
tmpnum <- sample(nrow(lab), 5000)
tmpdata <- lab[tmpnum, ]

#주행경로 그래프 
mapcolor <- rgb(0, 0, 0.7, alpha=0.01)
ggplot() +  
  geom_polygon(aes(x = ny1$long, y = ny1$lat), fill = "white", color = "grey") + 
  geom_polygon(aes(x = ny2$long, y = ny2$lat), fill = "white", color = "grey") + 
  geom_segment(data = tmpdata, aes(x = long, y = lat, xend=longs, yend=lats), 
             col= mapcolor, alpha=0.1)

#------------------------------------------------------------------------------

