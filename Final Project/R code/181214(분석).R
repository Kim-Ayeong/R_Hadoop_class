#--------------------------------------------------------------------

# 정리된 totaldata 변수

1. X : 행 인덱스 
2. DATE : 년-월-일
3. TIME : 픽업시간 > 범주형(0~23)
4. payment_type : 결제수단 > 범주형(CRD, CSH)
5. total_amount : 총 요금
6. passenger_count : 승객 수 > 범주형(1, 2)
7. trip_time_in_secs : 주행시간
8. trip_distance : 주행거리
9. pickup_longitude : 픽업경도
10. pickup_latitude : 픽업위도
11. dropoff_longitude : 도착경도
12. dropoff_latitude :도착위도
13. AWND : 평균풍속
14. PRCP : 강수량

#---------------------------------------------------------------------------

rm(list=ls())

rawdata <- read.csv("sample_total1.csv")
head(rawdata)
dim(rawdata)
str(rawdata)
summary(rawdata)

rawdata$TIME <- factor(rawdata$TIME)
rawdata$passenger_count <- factor(rawdata$passenger_count)
sapply(rawdata, class)

#----------------------------------기초 분석-----------------------------------

n <- nrow(rawdata)
data <- rawdata[sort(sample(n, 4000)), ] #0.5% 샘플링
data <- data[, c(3,4,5,6,7,8,13,14)]
head(data)

#연속형 변수 분석
sapply(data, class)
pairs(data[, -c(1,2,4)], main="변수 간 상관관계", pch=21)
cor(data[, -c(1,2,4)]) #total_amount, trip_time_in_secs, trip_distance 상관관계 높음

#범주형 변수 분석
#시간별 평균 속력 차이 O
data$trip_distance <- data$trip_distance*0.621371 #단위 : m/s
data$trip_time_in_secs <- data$trip_time_in_secs/3600
tapply(data$trip_distance/data$trip_time_in_secs, data$TIME, mean)
anova(lm(data$trip_distance/data$trip_time_in_secs ~ data$TIME))


#결제수단에 따른 요금 차이 O
tapply(data$total_amount, data$payment_type, mean)
anova(lm(data$total_amount ~ data$payment_type))

#승객 수에 따른 요금 차이 X
tapply(data$total_amount, data$passenger_count, mean)
anova(lm(data$total_amount ~ data$passenger_count))

#----------------------------------분석1--------------------------------------

#1) 다중 회귀분석

#총 요금 = B0 + B1*결제수단 + B2*주행시간 + B3*주행거리

head(rawdata)
data1 <- rawdata[, c(4,5,7,8)]
head(data1)

#분산분석
anova(lm(total_amount ~ payment_type, data1)) #p-value = 2.2e-16 > 상관 O
#상관분석
cor.test(data1$total_amount, data1$trip_time_in_secs) #p-value = 2.2e-16 > 상관 O
cor.test(data1$total_amount, data1$trip_distance) #p-value = 2.2e-16 > 상관 O

#상관관계가 있는 변수만 적용
fit1 <- lm(total_amount ~ payment_type + trip_time_in_secs + trip_distance, data1)
summary(fit1) 
anova(fit1)   

predict(fit1, newdata = data.frame(payment_type = "CRD", trip_time_in_secs = 300, trip_distance = 3))
predict(fit1, newdata = data.frame(payment_type = "CSH", trip_time_in_secs = 300, trip_distance = 3))
predict(fit1, newdata = data.frame(payment_type = "CSH", trip_time_in_secs = 900, trip_distance = 3))


#--------------------------------------분석2----------------------------------

#2) 다중 회귀분석

#세계무역센터(WTD)-센트럴파크(CP) 소요시간 = B0 + B1*시간 + B2*풍속 + B3*강수량

#WTC.long <- c(-74.02, -74.00)
#WTC.lat <- c(40.70, 40.72)
#CP.long <- c(-73.97, -73.95)
#CP.lat <- c(40.77, 40.79)

head(rawdata)
data2 <- rawdata[, c(3,7,8,9,10,11,12,13,14)]
head(data2)

#WTC 출발 > CP 도착
tmp1 <- which((data2$pickup_longitude > -74.02 & data2$pickup_longitude < -74.00) &
                (data2$pickup_latitude > 40.70 & data2$pickup_latitude < 40.72))
tmp2 <- which((data2$dropoff_longitude > -73.97 & data2$dropoff_longitude < -73.95) &
                (data2$dropoff_latitude > 40.77 & data2$dropoff_latitude < 40.79))

#CP 출발 > WTC 도착
tmp3 <- which((data2$pickup_longitude > -73.97 & data2$pickup_longitude < -73.95) &
                (data2$pickup_latitude > 40.77 & data2$pickup_latitude < 40.79))
tmp4 <- which((data2$dropoff_longitude > -74.02 & data2$dropoff_longitude < -74.00) &
                (data2$dropoff_latitude > 40.70 & data2$dropoff_latitude < 40.72))

length(tmp1); length(tmp2); length(tmp3); length(tmp4)
tmpnum <- union(union(tmp1, tmp2), union(tmp3, tmp4))
length(tmpnum) #152750

data22 <- data2[tmpnum, ]
head(data22)
summary(data22) #실제:25분, 6마일(9.6km)

#사분위수 내 주행거리 자료 추출 후 동일하다고 가정
cor.test(data22$trip_time_in_secs, data22$trip_distance)
q1 <- quantile(data22$trip_distance)[2]
q3 <- quantile(data22$trip_distance)[4]
tmp <- which(data22$trip_distance >= q1 & data22$trip_distance <= q3)
length(tmp) #77000
data22 <- data22[tmp, ]

data22 <- data22[, -c(3,4,5,6,7)]
head(data22)

anova(lm(trip_time_in_secs ~ TIME, data22)) #p-value < 2.2e-16 > 상관 O
tapply(data22$trip_time_in_secs, data22$TIME, mean) #8,9시가 특히 높게 나타남
cor.test(data22$trip_time_in_secs, data22$AWND) #p-value = 0.3115 > 상관 X
cor.test(data22$trip_time_in_secs, data22$PRCP) #p-value < 2.2e-16 > 상관 O

#상관관계가 있는 변수만 적용
fit2 <- lm(trip_time_in_secs ~ TIME + PRCP, data22)
summary(fit2) 
anova(fit2)   

predict(fit2, newdata = data.frame(TIME="8", PRCP=0.1))
predict(fit2, newdata = data.frame(TIME="12", PRCP=0.1))
predict(fit2, newdata = data.frame(TIME="12", PRCP=0.5))

#-----------------------------분석3--------------------------------------

#3) 로지스틱 회귀

#교통체증 정도(0 or 1) = 출발시간 + 출발지 + 목적지 + 풍속 + 강수량

#rv 변수 생성
data3 <- mutate(rawdata, rv = total_amount / trip_distance)
mu <- mean(data3$rv) #7.04707
data3$rv = cut(data3$rv, breaks = c(0, mu, 9999), labels = c(0, 1)) #rv 범주화(0-평균 이하, 1-평균 이상)
table(data3$rv) #0:456912, 1:230775
head(data3)
summary(data3)

glmm <- glm(rv ~ TIME + pickup_longitude + pickup_latitude + 
            + dropoff_longitude + dropoff_latitude + AWND + PRCP, 
            family=binomial(link=logit), data3, trace=F)
summary(glmm)

log <- predict(glmm, newdata = data.frame(TIME="8", pickup_longitude=-74.005 , pickup_latitude=40.736, 
                                   dropoff_longitude=-73.979 , dropoff_latitude=40.734, 
                                   AWND=6.93, PRCP=0.1))
pi <- exp(log); traffic <- pi/(1+pi); traffic

#--------------------------------------------------------------------------------------
