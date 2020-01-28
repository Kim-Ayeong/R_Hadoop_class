
# RHadoop 기말 프로젝트

#----------------------------날씨 데이터 전처리--------------------------------
  
# STATION, NAME : 모두 동일 > 삭제
# AWND : Average wind speed data, 평균 풍속(m/s)
# PRCP : Precipitation, 강우량 (mm) > 강수량으로 통합 
# SNOW : Snowfall, 강설량 (mm) > 강수량으로 통합
# SNWD : Snow depth, 적설량 (mm) > 삭제
# TMAX : Maximum temperature, 최고 기온(화씨 기준)
# TMIN : Minimum temperature, 최저 기온(화씨 기준)

#-----------------------------------------------------------------------------
  
rm(list=ls())

filename <- "central_park_weather.csv"
data <- read.csv(filename)
head(data) #데이터셋 확인
dim(data) #3468, 9

data <- data[,c(3,4,5,6,8,9)] #필요없는 변수 삭제
data$PRCP <- data$PRCP + data$SNOW #강우량, 강설량 > 강수량으로 통합
data <- data[,-4] #강설량 삭제

chngtmp <- function(tmp) { #화씨 > 섭씨 변환
  tmp <- tmp-32
  tmp <- tmp*5/9
}
data$TMAX <- round(sapply(data$TMAX , chngtmp), digits=1)
data$TMIN <- round(sapply(data$TMIN , chngtmp), digits=1)

library(lubridate)
data$DATE <- as.Date(data$DATE, "%Y-%m-%d") #2013 데이터 추출
tmp <- which(year(data$DATE) == '2013')
data <- data[tmp[1]:tmp[length(tmp)],]
head(data)
dim(data) #365, 5

attach(data) #변수 정리 완료
class(DATE); class(AWND); class(PRCP); class(TMAX); class(TMIN) #변수 유형 확인
sum(is.na(data)) #결측치 확인 > 없음
par(mfrow = c(2, 2)) #이상값 확인
plot(DATE , AWND); plot(DATE , PRCP); plot(DATE , TMAX); plot(DATE , TMIN)
sum(AWND < 0); sum(PRCP < 0) #풍속 또는 강수량이 0 이하인 값 확인 > 없음
par(mfrow = c(1, 2))
boxplot(TMAX); boxplot(TMIN) #최고&최저기온 특이값 확인 > 없음
detach(data)

write.csv(data, "weather_process.csv")

#----------------------------------------------------------------------------------
 

  