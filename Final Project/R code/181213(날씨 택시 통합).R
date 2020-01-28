
#-----------------------------------------------------------------------

# 정리된 날씨 변수

1. X : 행 인덱스
2. DATE : 날짜
3. AWND : 평균 풍속
4. PRCP : 강수량
5. TMAX : 최고 기온
6. TMIN : 최저 기온

#-----------------------------------------------------------------------

# 정리된 택시 변수

1. X : 행 인덱스
2. payment_type : 결제수단 >>> 범주형
3. total_amount : 총 요금 >>> 종속변수
4. pickup_datetime : 픽업시간
5. ropoff_datetime : 도착시간
6. passenger_count : 승객 수
7. trip_time_in_secs : 주행시간 >>> 연속형
8. trip_distance : 주행거리 >>> 연속형
9. pickup_longitude : 픽업경도
10. pickup_latitude : 픽업위도
11. dropoff_longitude : 도착경도
12. dropoff_latitude :도착위도

#-------------------------------날씨 데이터 합치기-------------------------------

rm(list=ls())

rawdata <- read.csv("sample_process1.csv")
#rawdata <- read.csv("sample_process2.csv")
#rawdata <- read.csv("sample_process3.csv")
#rawdata <- read.csv("sample_process4.csv")
#rawdata <- read.csv("sample_process5.csv")
#rawdata <- read.csv("sample_process6.csv")
#rawdata <- read.csv("sample_process7.csv")
#rawdata <- read.csv("sample_process8.csv")
#rawdata <- read.csv("sample_process9.csv")
#rawdata <- read.csv("sample_process10.csv")
#rawdata <- read.csv("sample_process11.csv")
#rawdata <- read.csv("sample_process12.csv")

dim(rawdata)
str(rawdata)
n <- nrow(rawdata) #687687

#data <- rawdata[sort(sample(n, 10000)), ] #우선 10000개만 합쳐봄
data <- rawdata

data$pickup_datetime <- as.POSIXlt(data$pickup_datetime)
DATE <- as.Date(data$pickup_datetime) #년월일 변수 생성
TIME <- data$pickup_datetime$hour #시간 변수 생성
data <- cbind(TIME, data)
data$TIME <- factor(data$TIME)
data <- cbind(DATE, data)
data <- data[, -c(3,4,7,8)] #X, X.1, pickup_datetime, dropoff_datetime 변수 제거
head(data)
dim(data) #687687, 11

weather_data <- read.csv("weather_process.csv")
head(weather_data,100)
sum(is.na(weather_data)) #0
summary(weather_data[1:31,]) #1월 날씨

startDate <- as.Date("2013-01-01")
data <- data[order(data$DATE, data$TIME), ]  #DATE, TIME 순으로 재정렬
head(data)

totaldata <- data.frame(data, AWND=rep(0, n), PRCP=rep(0, n))
sum(is.na(totaldata)) #0
head(totaldata)

indexlist <- as.vector(table(data$DATE))
indexlist <- c(0, indexlist)
indexlist <- cumsum(indexlist)
length(indexlist) #32

#for문보다 빠르게 해결
wdata <- weather_data[1, 3:4]; wdata
totaldata[indexlist[1]+1:indexlist[2], 12:13] <- wdata
wdata <- weather_data[2, 3:4]; wdata
totaldata[indexlist[2]+1:indexlist[3], 12:13] <- wdata
wdata <- weather_data[3, 3:4]; wdata
totaldata[indexlist[3]+1:indexlist[4], 12:13] <- wdata
wdata <- weather_data[4, 3:4]; wdata
totaldata[indexlist[4]+1:indexlist[5], 12:13] <- wdata
wdata <- weather_data[5, 3:4]; wdata
totaldata[indexlist[5]+1:indexlist[6], 12:13] <- wdata
wdata <- weather_data[6, 3:4]; wdata
totaldata[indexlist[6]+1:indexlist[7], 12:13] <- wdata
wdata <- weather_data[7, 3:4]; wdata
totaldata[indexlist[7]+1:indexlist[8], 12:13] <- wdata
wdata <- weather_data[8, 3:4]; wdata
totaldata[indexlist[8]+1:indexlist[9], 12:13] <- wdata
wdata <- weather_data[9, 3:4]; wdata
totaldata[indexlist[9]+1:indexlist[10], 12:13] <- wdata
wdata <- weather_data[10, 3:4]; wdata
totaldata[indexlist[10]+1:indexlist[11], 12:13] <- wdata
wdata <- weather_data[11, 3:4]; wdata
totaldata[indexlist[11]+1:indexlist[12], 12:13] <- wdata
wdata <- weather_data[12, 3:4]; wdata
totaldata[indexlist[12]+1:indexlist[13], 12:13] <- wdata
wdata <- weather_data[13, 3:4]; wdata
totaldata[indexlist[13]+1:indexlist[14], 12:13] <- wdata
wdata <- weather_data[14, 3:4]; wdata
totaldata[indexlist[14]+1:indexlist[15], 12:13] <- wdata
wdata <- weather_data[15, 3:4]; wdata
totaldata[indexlist[15]+1:indexlist[16], 12:13] <- wdata
wdata <- weather_data[16, 3:4]; wdata
totaldata[indexlist[16]+1:indexlist[17], 12:13] <- wdata

#결측값 생김 > 통합에는 문제가 없으므로 마지막에 삭제
wdata <- weather_data[17, 3:4]; wdata
totaldata[indexlist[17]+1:indexlist[18], 12:13] <- wdata
wdata <- weather_data[18, 3:4]; wdata
totaldata[indexlist[18]+1:indexlist[19], 12:13] <- wdata
wdata <- weather_data[19, 3:4]; wdata
totaldata[indexlist[19]+1:indexlist[20], 12:13] <- wdata
wdata <- weather_data[20, 3:4]; wdata
totaldata[indexlist[20]+1:indexlist[21], 12:13] <- wdata
wdata <- weather_data[21, 3:4]; wdata
totaldata[indexlist[21]+1:indexlist[22], 12:13] <- wdata
wdata <- weather_data[22, 3:4]; wdata
totaldata[indexlist[22]+1:indexlist[23], 12:13] <- wdata
wdata <- weather_data[23, 3:4]; wdata
totaldata[indexlist[23]+1:indexlist[24], 12:13] <- wdata
wdata <- weather_data[24, 3:4]; wdata
totaldata[indexlist[24]+1:indexlist[25], 12:13] <- wdata
wdata <- weather_data[25, 3:4]; wdata
totaldata[indexlist[25]+1:indexlist[26], 12:13] <- wdata
wdata <- weather_data[26, 3:4]; wdata
totaldata[indexlist[26]+1:indexlist[27], 12:13] <- wdata
wdata <- weather_data[27, 3:4]; wdata
totaldata[indexlist[27]+1:indexlist[28], 12:13] <- wdata
wdata <- weather_data[28, 3:4]; wdata
totaldata[indexlist[28]+1:indexlist[29], 12:13] <- wdata
wdata <- weather_data[29, 3:4]; wdata
totaldata[indexlist[29]+1:indexlist[30], 12:13] <- wdata
wdata <- weather_data[30, 3:4]; wdata
totaldata[indexlist[30]+1:indexlist[31], 12:13] <- wdata
wdata <- weather_data[31, 3:4]; wdata
totaldata[indexlist[31]+1:indexlist[32], 12:13] <- wdata

totaldata <- na.omit(totaldata)
head(totaldata) #확인
dim(totaldata) #687687, 13
sapply(totaldata, class)
summary(totaldata)

write.csv(totaldata, "sample_total1.csv")
#write.csv(totaldata, "sample_total2.csv")
#write.csv(totaldata, "sample_total3.csv")
#write.csv(totaldata, "sample_total4.csv")
#write.csv(totaldata, "sample_total5.csv")
#write.csv(totaldata, "sample_total6.csv")
#write.csv(totaldata, "sample_total7.csv")
#write.csv(totaldata, "sample_total8.csv")
#write.csv(totaldata, "sample_total9.csv")
#write.csv(totaldata, "sample_total10.csv")
#write.csv(totaldata, "sample_total11.csv")
#write.csv(totaldata, "sample_total12.csv")

#--------------------------------------------------------------------

# 정리된 totaldata 변수

1. DATE : 년-월-일
2. TIME : 픽업시간(24시 기준)
3. payment_type : 결제수단
4. total_amount : 총 요금
5. passenger_count : 승객 수
6. trip_time_in_secs : 주행시간
7. trip_distance : 주행거리
8. pickup_longitude : 픽업경도
9. pickup_latitude : 픽업위도
10. dropoff_longitude : 도착경도
11. dropoff_latitude :도착위도
12. AWND : 평균풍속
13. PRCP : 강수량

#-------------------------------------------------------------------

