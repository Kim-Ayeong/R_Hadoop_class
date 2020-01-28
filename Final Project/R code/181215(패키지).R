
#----------------------------------------------------------------------

# 정리된 totaldata 변수

1. X : 행 인덱스
2. DATE : 년-월-일
3. TIME : 픽업시간(24시 기준)
4. payment_type : 결제수단
5. total_amount : 총 요금
6. passenger_count : 승객 수
7. trip_time_in_secs : 주행시간
8. trip_distance : 주행거리
9. pickup_longitude : 픽업경도
10. pickup_latitude : 픽업위도
11. dropoff_longitude : 도착경도
12. dropoff_latitude :도착위도
13. AWND : 평균풍속
14. PRCP : 강수량

#----------------------------------------------------------------------

rawdata <- read.csv("sample_total1.csv")

#-----------------------------함수1-------------------------------
#① 특정 기간 동안의 교통체증 시각화 함수 (시작월, 끝월)

trafficMAP <- function(data) {
  #미국 주 데이터
  states <- map_data("state")
  
  #뉴욕주 데이터
  newyork <- subset(states, region %in% c("new york"))
  
  #뉴욕시 데이터
  ny <- subset(newyork, subregion %in% c("long island", "manhattan"))
  ny <- ny[ny$long >= -74.05 & ny$long <= -73.7, ]
  ny <- ny[ny$lat >= 40.5 & ny$lat <= 40.85, ]
  ny1 <- subset(ny, subregion %in% c("long island"))
  ny2 <- subset(ny, subregion %in% c("manhattan"))
  
  #택시 데이터
  data <- rawdata
  
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
}

#확인
trafficMAP(rawdata)

#-----------------------------함수2--------------------------------------
#② 총 요금 예측 함수 (출발시간, 결제수단, 출발지, 목적지)

tripAMOUNT <- function (departTime, payType, pick_lon, pick_lat, drop_lon, drop_lat) {
  library(geosphere)
  pick <- c(pick_lon, pick_lat)
  drop <- c(drop_lon, drop_lat)
  dist <- distGeo(pick, drop)/1000 #단위 : m
  velo <- tapply(rawdata$trip_distance/rawdata$trip_time_in_secs, rawdata$TIME, mean)
  velo <- velo/0.621371*1000 #단위 : m/s

  if (departTime == 24) departTime <- 0
  triptime <- dist/velo[departTime+1]
  result <- predict(fit1, newdata = data.frame(payment_type = payType, 
                                               trip_time_in_secs = triptime, 
                                               trip_distance = dist))
  cat(round(result, digits=2), "달러가 예상됩니다.")
}

#확인
tripAMOUNT(departTime=8, payType="CRD", pick_lon=-74.005 , pick_lat=40.736, drop_lon=-73.979 , drop_lat=40.734)

#-----------------------------함수3-----------------------------------
#③ 세계무역센터-센트럴파크 간 소요시간 예측 함수 (출발시간, 강수량)

tripTIME <- function (departTime, rainForecast) {
  result <- predict(fit2, newdata = data.frame(TIME=factor(departTime), 
                                               PRCP=as.numeric(rainForecast)))
  cat("세계무역센터-센트럴파크 : ", as.integer(result/60), "분이 예상됩니다.")
}

#확인
tripTIME(departTime=8, rainForecast=0.7)

#-----------------------------함수4-----------------------------------
#④ 교통체증 정도 예측 함수 (출발시간, 출발지, 목적지, 풍량, 강수량)

trafficLEVEL <- function (departTime, pick_lon, pick_lat, drop_lon, drop_lat, AWND, PRCP) {
  log <- glmm$coefficients[1] + 
    glmm$coefficients[2] * departTime + 
    glmm$coefficients[3] * pick_lon + 
    glmm$coefficients[4] * pick_lat + 
    glmm$coefficients[5] * drop_lon + 
    glmm$coefficients[6] * drop_lat +
    glmm$coefficients[7] * AWND + 
    glmm$coefficients[8] * PRCP
  
  pi <- exp(log)
  traffic <- pi/(1+pi)
  cat(round(traffic*100, digits=1) , "% 교통체증이 예상됩니다.")
}

#확인
trafficLEVEL(departTime=8, pick_lon=-74.005 , pick_lat=40.736, drop_lon=-73.979 , drop_lat=40.734,
         AWND=6.93, PRCP=0.1)
trafficLEVEL(departTime=11, pick_lon=-74.005 , pick_lat=40.736, drop_lon=-73.979 , drop_lat=40.734,
         AWND=6.93, PRCP=1.0)
trafficLEVEL(departTime=9, pick_lon=-73.98 , pick_lat=40.75, drop_lon=-73.97 , drop_lat=40.753,
         AWND=6.93, PRCP=2.5)


#-----------------------------함수5------------------------------------------
#⑤ 합승 가능성 예측 함수 (출발시간, 출발지, 목적지)

carSHARE <- function (departTime, pick_lon, pick_lat, drop_lon, drop_lat, AWND, PRCP) {
    log <- glmm$coefficients[1] + 
    glmm$coefficients[2] * departTime + 
    glmm$coefficients[3] * pick_lon + 
    glmm$coefficients[4] * pick_lat + 
    glmm$coefficients[5] * drop_lon + 
    glmm$coefficients[6] * drop_lat +
    glmm$coefficients[7] * AWND + 
    glmm$coefficients[8] * PRCP
  
  pi <- exp(log)
  traffic <- pi/(1+pi)
  traffic <- round(traffic*100, digits=0) 
  
  #-37:원활, 37-42:보통, 42-:혼잡
  result <- ""
  if (traffic < 37) result <- "교통이 원활합니다. 합승을 하지 않으셔도 괜찮습니다."
  else if(traffic < 42) result <- "교통이 보통 수준입니다. 합승을 하지 않으셔도 괜찮습니다."
  else result <- "교통이 혼잡합니다. 합승을 권장합니다." 
  cat(result)
  
}

#확인
carSHARE(departTime=8, pick_lon=-74.005 , pick_lat=40.736, drop_lon=-73.979 , drop_lat=40.734,
                AWND=6.93, PRCP=0.1)
carSHARE(departTime=11, pick_lon=-74.005 , pick_lat=40.736, drop_lon=-73.979 , drop_lat=40.734,
             AWND=6.93, PRCP=1.0)
carSHARE(departTime=9, pick_lon=-73.98 , pick_lat=40.75, drop_lon=-73.97 , drop_lat=40.753,
             AWND=6.93, PRCP=2.5)
