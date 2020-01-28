#10월 16일

#lec 9

aggregate() : 데이터를 서브 데이터로 나누어 연산을 적용, 분산 연산을 할 때 유용

str(state.x77)
aggregate(state.x77, list(Region = state.region), mean)
list(Region = state.region, Cold = state.x77[,"Frost"] > 130)
aggregate(state.x77, list(Region = state.region, Cold = state.x77[,"Frost"] > 130), mean)

aggregate(weight ~ feed, data = chickwts, mean)
aggregate(breaks ~ wool + tension, data = warpbreaks, mean)
aggregate(cbind(Ozone, Temp) ~ Month, data = airquality, mean)
aggregate(cbind(ncases, ncontrols) ~ alcgp + tobgp, data = esoph, sum)
aggregate(. ~ Species, data = iris, mean)
aggregate(len ~ ., data = ToothGrowth, mean)

as.POSIXct() : 문자 변수를 POSIXct 객체로 변환, 시간 관련 정보를 다룰 때 유용
format() 함수: POSIXct 객체를 문자 타입으로 변환

(z <- Sys.time()) 			# 현재 시간, as class "POSIXct"
unclass(z) 					# a large integer, 기준 시간대부터 지금까지의 총 시간
floor(unclass(z)/86400) 		# 1970-01-01부터의 총 시간
(now <- as.POSIXlt(Sys.time())) 	# 현재 시간을 "POSIXlt" 객체로
unlist(unclass(now)) 			# 시간을 하위그룹으로 나눔 
now$year + 1900 				# see ?DateTimeClasses
months(now); weekdays(now) 		# see ?months

as.POSIXlt(x = Sys.time())
as.POSIXlt(x = Sys.time(), tz = "Asia/Seoul") #KST: 대한민국 표준시
as.POSIXlt(x = unclass(Sys.time()), origin = "1970-01-01", tz = "GMT") #GMT 기준으로
as.POSIXlt(x = unclass(Sys.time()), origin = "1970-01-01", tz = "Asia/Seoul")

source() : 파일 안에 저장된 script을 R session에 읽어오는데 사용
getwd()
dir( pattern = "myt") #myt로 시작하는 파일만 검색
source( "myttest.R" )
objects(pattern = "myt")
source("http://statistics.ssu.ac.kr/~SHCHO/myttest.R") # read a file directly using URL

rgb() : RGB(red, green, blue) 값에 해당하는 색상을 만들 수 있음
rgb(128, 0, 0, max = 255)

datcol <- read.csv( "color.csv", header = F, stringsAsFactors = FALSE)
myfavcol <- datcol[[2]]
write.csv( myfavcol, "myfavcol.csv", row.names = F)
cols <- read.csv( "myfavcol.csv") #자주 사용하는 컬러 지정해놓기
#plot(1:13, col=as.character(cols$x), pch=16, cex=1.2)로 확인

#R을 시작할 때 자동적으로 읽어오길 원할 때
1. C:\Program Files\R\R-n.n.n\etc 안에 있는 Rprofile.site에 추가 작성
2. ~.Rprofile file 작성
First( ) will be run at the start of the R session
Last( ) will be run at the end of the session

#1. first.R이라는 파일 안에 다음의 script를 저장
library(utils)
cols <- read.csv( "myfavcol.csv")
#2. 현재 작업 directory 안에 .Rprofile 함수를 생성해서 다음의 script를 저장
.First <- function(){
  source("first.R")
  cat("\nWelcome at", date(), "\n")
}
.Last <- function(){
  cat("\nGoodbye at ", date(), "\n")
}

# New York Taxi 자료 분석하기
Q1. 택시 운행이 가장 빈번했던 시간대는?
Q2. 택시 운행이 가장 빈번했던 요일은?
Q3. 각 시간대에서 가장 빈번했던 요금 코드는?
Q4. 위 질문에 가장 적합한 시각적 요약은?

#실습코드

filein <- "trip_data_1_sample.csv"
dat <- read.csv(file = filein, nrow = 10, stringsAsFactors = FALSE)
dat
headerInfo <- read.csv("dictionary_trip_data.csv", stringsAsFactors=FALSE)
colClasses <- as.character(as.vector(headerInfo[1, ]))
colClasses[1:2] <- "character"
dat <- read.csv(file = filein, nrow = 10, col.names = names(headerInfo), colClasses = colClasses )
dat <- read.csv(file = filein, col.names = names(headerInfo), colClasses = colClasses )
head(dat)
str(dat)

dat[[6]]
original <- dat[[6]]
date <- as.Date(original, origin = "1970-01-01"); date
wkday <- weekdays(date); wkday
hour <- format(as.POSIXct(original), "%H"); hour
table(dat$rate_code, as.factor(hour))

palette <- colorRampPalette(c('#f0f3ff','#0033BB'))(256)
#install.packages("fields")
library(fields)
tmp <- table(dat$rate_code, as.factor(hour))
attributes(tmp)
str(tmp)
image.plot(tmp, col = palette, axes=FALSE, lab.breaks=NULL)
# axis labels
image(tmp, col = palette, axes=FALSE, add=TRUE)
axis(3, at=seq(0,1, length=6), labels=attributes(tmp)$dimnames[[1]], lwd=0, pos=1)
axis(2, at=seq(1,0, length=24), labels=attributes(tmp)$dimnames[[2]], lwd=0, pos=-0.1)
# add values
e <- expand.grid(seq(0,1, length=6), seq(1,0, length=24))
text(e, labels=tmp )

mydat <- data.frame(date, hour)
mydat
date
z <- aggregate(date ~ hour, mydat, FUN = length)  #시간대별로 몇번 발생했는지, frequence 계산
str(z)
table(date, hour)
apply(table(date, hour),2,sum)
par( mar = c(5,5,1,1))
plot( date ~ as.numeric(hour), data = z, type ="n", xlab = "hour", ylab = "freq")
lines( as.numeric(z$hour), z$date, col = "lightblue")
ind <- which( z$date == max(z$date))
abline( v = ind, col = "grey80")
text( as.numeric(z$hour), z$date, z$date, cex = 0.7, col = 4)
box()


