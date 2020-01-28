
#------------------------택시 데이터 불러오기-----------------------------

#########################################################

# 하둡관련 패키지 로딩
library(rhdfs) 
hdfs.init()     
library(rmr2) 
rm(list=ls())

#########################################################

files <- hdfs.ls("/user/shcho/data/taxi/combined")$file

#files[1] = 변수 정보
mr <- mapreduce(input = files[1], 
                input.format = make.input.format(
                  format = "csv", sep=",", stringsAsFactors=F))
res <- from.dfs(mr)
ress <- values(res)

colnames.tmp <- as.character(ress[,1]); colnames.tmp
class.tmp <- as.character(ress[,2]); class.tmp

colnames <- colnames.tmp[-1]; colnames
class <- class.tmp[-1]; class
class[c(6,8,9,10)] <- "numeric"
cbind(colnames, class)

input.format <- make.input.format(
  format = "csv", sep = ",", stringsAsFactors = F, 
  col.names = colnames, colClasses = class)
#input.format <- make.input.format( format = "csv", sep = ",", stringsAsFactors = F, col.names = colnames)

files <- files[-1] # 파일목록에서 변수 정보 삭제

#아래로만 반복
files[1]
#files[1] : "sample_combined1.csv")
#files[2] : "sample_combined10.csv")
#files[3] : "sample_combined11.csv")
#files[4] : "sample_combined12.csv")
#files[5] : "sample_combined2.csv")
#files[6] : "sample_combined3.csv")
#files[7] : "sample_combined4.csv")
#files[8] : "sample_combined5.csv")
#files[9] : "sample_combined6.csv")
#files[10] : "sample_combined7.csv")
#files[11] : "sample_combined8.csv")
#files[12] : "sample_combined9.csv")


#read only one csv file, 하나씩 저장
mr <- mapreduce( input = files[1], input.format = input.format )
tmp <- values(from.dfs(mr))
str(tmp)

write.csv(tmp, "sample_combined1.csv")
#write.csv(tmp, "sample_combined10.csv")
#write.csv(tmp, "sample_combined11.csv")
#write.csv(tmp, "sample_combined12.csv")
#write.csv(tmp, "sample_combined2.csv")
#write.csv(tmp, "sample_combined3.csv")
#write.csv(tmp, "sample_combined4.csv")
#write.csv(tmp, "sample_combined5.csv")
#write.csv(tmp, "sample_combined6.csv")
#write.csv(tmp, "sample_combined7.csv")
#write.csv(tmp, "sample_combined8.csv")
#write.csv(tmp, "sample_combined9.csv")

#read only all csv files
#mr <- mapreduce( input = files, input.format = input.format )
#tmp <- values(from.dfs(mr))
#str(tmp)

#------------------------------택시 전처리------------------------------

# 변수 정리
1. X : 행 인덱스
2. medallion : 면허 허가번호 >>> 삭제
3. hack_license : 면허증 ID >>> 삭제
4. vendor_id : 택시회사 >>> 삭제
5. ~ payment_type : 결제수단 >>> CRD, CSH 이외 3가지 제거
6. fare_amount : 주행 요금 >>> 11으로 통합
7. surcharge :추가 러시아워 요금 >>> 11으로 통합
8. mta_tax : 자동부과 요금(0.5달러) >>> 0.5이외의 값 삭제 후 11으로 통합
9. tip_amount : 팁비 >>> 11으로 통합
10. tolls_amount : 톨비 >>> 11으로 통합
11. ~ total_amount : 총 요금
12. rate_code : 요금코드 >>> 표준율(1)만 추출 후 삭제
13. store_and_fwd_flag : 택시, 회사 연결 여부(Y,N) >>> 삭제
14. ~ pickup_datetime : 픽업시간
15. ~ dropoff_datetime : 도착시간
16. ~ passenger_count : 승객 수 >>> 0값 삭제 후 '1', '1초과=2'로 범주화
17. ~ trip_time_in_secs : 주행시간 >>> 14-13 맞는지 확인 후 0값 삭제
18. ~ trip_distance : 주행거리 >>> 0값 삭제
19. ~ pickup_longitude : 픽업경도
20. ~ pickup_latitude : 픽업위도
21. ~ dropoff_longitude : 도착경도
22. ~ dropoff_latitude :도착위도

#---------------------------------------------

rm(list=ls())

rawdata <- read.csv("sample_combined1.csv")

head(rawdata)
sapply(rawdata, class) #변수 유형 확인
str(rawdata) #데이터셋 확인
dim(rawdata) #738831, 22

#의미 없는 변수(2,3,4,13) 삭제
data <- subset(rawdata, select = -c(medallion, hack_license, vendor_id, store_and_fwd_flag))
head(data)
dim(data) #738831, 18

#결측값 제거
library(dplyr)
sum(is.na(data)) #8
summary(data) #4행
data <- data[!is.na(data$dropoff_longitude), ] #또는 data <- na.omit(data)
sum(is.na(data)) #0
summary(data) #NA 없음
dim(data) #738827, 18

#5. payment_type 데이터 중 CRD, CSH 이외 3가지 제거
table(data$payment_type) #5가지
tmp <- which(data$payment_type == "DIS" | data$payment_type == "NOC" | data$payment_type == "UNK")
length(tmp) #2436
data <- data[-tmp, ]
data$payment_type <- factor(data$payment_type) #다시 범주화
table(data$payment_type)

#요금 관련 변수 정리

#12. rate_code 데이터 중 표준율(1) 이외의 값 제거
table(data$rate_code) #1:720599개
tmp <- which(data$rate_code == 1)
length(tmp) #720599
data <- data[tmp, ]
summary(data) #완료
data <- data[, -9]
dim(data) #720599, 17

#8. mta_tax 데이터 중 0.5 이외의 값 제거
table(data$mta_tax) #0:30 제거
data <- data[data$mta_tax == 0.5, ]
summary(data) #완료
dim(data) #720569, 17

#'6+7+8+9+10. = 11.'이 아닌 값 제거
table((data$mta_tax + data$fare_amount + data$surcharge + data$tip_amount + data$tolls_amount) != data$total_amount) #T:13323 제거
tmp <- which((data$mta_tax + data$fare_amount + data$surcharge + data$tip_amount + data$tolls_amount) != data$total_amount)
length(tmp) #13323
data <- data[-tmp, ]
dim(data) #707246, 17

#11. total_amount만 사용, 6,7,8,9,10. 제거
data <- data[, -c(3,4,5,6,7)]
summary(data) #완료
dim(data) #707246, 12

#'14.픽업시간-15.도착시간 = 17.주행시간'이 아닌 값 제거
data$dropoff_datetime <- as.POSIXlt(data$dropoff_datetime)
data$pickup_datetime <- as.POSIXlt(data$pickup_datetime)
timegap <- as.numeric(data$dropoff_datetime - data$pickup_datetime, units='secs')
table(timegap == data$trip_time_in_secs) #F:189531, T:517715
quantile(timegap - data$trip_time_in_secs)
#1~3사분위수, 초단위를 고려해 시간차이가 1보다 큰 데이터만 제거
table(abs(timegap - data$trip_time_in_secs) > 1) #T:948 제거
tmp <- which(abs(timegap - data$trip_time_in_secs) > 1)
length(tmp) #948
data <- data[-tmp, ]
dim(data) #706298, 12

#16. passenger_count 승객 수 중 0값 제거
table(data$passenger_count) #0:없음
max(data$passenger_count) #6
#'1', '2이상=2'로 범주화
tmp <- which(data$passenger_count == 3 | data$passenger_count == 4 | 
              data$passenger_count == 5 | data$passenger_count == 6)
length(tmp) #111478
data$passenger_count[tmp] <- 2
table(data$passenger_count) #완료 

#17. trip_time_in_secs 주행시간 중 60초 미만값 제거
#boxplot(data$trip_time_in_secs)
tmp <- which(data$trip_time_in_secs < 60)
length(tmp) #2219
data <- data[-tmp, ]
summary(data) #완료
dim(data) #704079, 12

#18. trip_distance 주행거리 중 0값 제거
#boxplot(trip_distance)
tmp <- which(data$trip_distance == 0)
length(tmp) #718
data <- data[-tmp, ]
summary(data) #완료
dim(data) #703361, 12

#19. pickup_longitude : 픽업경도
#21. dropoff_longitude : 도착경도 (-74.05 ~ -73.7)이외 값 제거
tmp <- which(data$pickup_longitude < -74.05 | data$pickup_longitude > -73.7 |
              data$dropoff_longitude < -74.5 | data$dropoff_longitude > -73.7)
length(tmp) #12526
data <- data[-tmp, ]
dim(data) #690835, 12

#20. pickup_latitude : 픽업위도
#22. dropoff_latitude :도착위도 (40.5 ~ 40.85)이외 값 제거
tmp <- which(data$pickup_latitude < 40.5 | data$pickup_latitude > 40.85 |
              data$dropoff_latitude < 40.5 | data$dropoff_latitude > 40.85)
length(tmp) #3148
data <- data[-tmp, ]
dim(data) #687687, 12
summary(data) #완료

write.csv(data, "sample_process1.csv")

#-------------------------------------------------------------------

# 정리된 택시 변수

1. X : 행 인덱스
2. payment_type : 결제수단
3. total_amount : 총 요금
4. pickup_datetime : 픽업시간
5. dropoff_datetime : 도착시간
6. passenger_count : 승객 수
7. trip_time_in_secs : 주행시간
8. trip_distance : 주행거리
9. pickup_longitude : 픽업경도
10. pickup_latitude : 픽업위도
11. dropoff_longitude : 도착경도
12. dropoff_latitude :도착위도

#--------------------------------------------------------------------

