#RHadoop 과제

#Self-Checking Exercises

#1번
data(mtcars)
mode(mtcars) # memory 저장되는 유형
class(mtcars) # R에서의 자료 유형
# 위의 차이를 이해하기 위해서 링크되어 있는 글을 읽어볼 것
names(mtcars)
str(mtcars)
help(mtcars)

#2번
#고차원 함수들(high-level functions): 완전한 그림을 생성해 줌
?hist()  #histograms
?plot()  #xy plots
?dotchart()  #dot plots
?barplot()  #bar plots
?pie()  #pie charts
?boxplot()  #boxplots

#3번
Q. 엔진의 실린더 수에 따라 자동차 연료 소비량과의 관계를 탐색하고 싶다면 어떤 그림을 사용하는 것이 적절할까요?
Q. 자동차의 무게와 연료 소비량과의 관계를 알아보고 싶다면 어떻게 그림을 그려보면 좋을까요?
Q. 자동차의 엔진 마력과 엔진의 실린더 수와의 관계를 눈으로 확인해 보고 싶다면 어떤 그림을 사용하는 것이 좋을까요?
Q. 엔진의 실린더의 수에 따른 자동차의 carburetor의 수를 그림으로 표현하고 싶다면?
Q. 자동차의 무게와 연료 소비량의 관계를 엔진의 실린더에 따라 알아보고 싶다면 어떤 그림을 사용하는 것이 좋을까요?

#4번
#GP 기본값 익히기
par()
help(par) # par의 help document를 시간을 두고 반복해서 여러 번 읽어보세요.
# if you use mac,
par("bg") # default background color

#GP 익히기
?par()
?plot()
- col
? pch
? cex
? xlim, ylim
? lty, lwd
? axes, xaxt, yaxt
? main, xlab, ylab
? type: 그림의 종류 - “l”: lines, “p”: points, “b”: lines and points, ”n”: no plotting

#GP에 따른 결과 비교
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", main = "mpg vs. Weight")
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", cex =1.2, main = "mpg vs. Weight")
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight")
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight", xlim = c(10,35), ylim = c(0,6))
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight", axes = F)
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight", xaxt = "n")
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight", type ="n")
plot( wt ? mpg, data = mtcars, xlab = "", ylab = "", col = cyl, pch = cyl, main = "", type ="n")
avr <- aggregate( wt ? cyl, FUN = mean, data = mtcars)
plot( avr[,1:2], type = "b", col = 4, lty = 2, lwd = 2 )

#5번
#저차원 함수들(low-level functions)
? text()
? abline()
? points()
? polygon()
? lines()
? axis()
? box()
? title()
? legend()

#그림에 추가되는 사항 확인
xx <- yy <- 1:10
cols <- 1:10
plot(x = xx, y = yy, xlab ="xlab", ylab = "ylab", main = "", xlim = c(0,11), ylim = c(0,11), type= "n" )
points(x = xx, y = yy, pch = 16, col = cols, cex = 1.2 )
text(x = xx, y = yy + 0.5, labels = as.character(cols))
title( "Here you can write title!", col.main = 4)
abline( v = mean(xx), col = "grey50", lty = 2)
abline( h = mean(yy), col = "grey30", lty = 3)
box( col = 6 )
plot( wt ? mpg, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Weight(1000 lbs)", col = cyl, pch = cyl, main = "mpg vs. Weight")
legend( 30, 5, legend = c(4,6,8), text.col = c(4,6,8), pch = c(4,6,8),col = c(4,6,8))
text( 30, 5.2, "# of cylinders", adj = 0)
n.lev <- length(levels(chickwts$feed)); n.lev
boxplot(chickwts$weight ? chickwts$feed, col = colors()[c(1:n.lev)*10], xaxt = "n")
axis(side = 1, at = 1:6, labels = levels(chickwts$feed), col.axis = 4, las = 2)
plot( 1:10, type = "n", axes = F, xlab = "", ylab = "")
cols <- colorRampPalette( c( "red", "green", "blue") )
xx <- seq(-1, 10, by = 0.01)
y <- c(1,10)
for(i in seq_along(xx)) lines( x = rep(xx[i],2), y = y, col = cols(length(xx))[i] )
polygon(1:9, c(2,1,2,1,NA,2,1,2,1),col = c("red", "blue"), border = c("green", "yellow"), lwd = 3, lty = c("dashed", "solid"))

#6번
#mar 사용하여 여백 조정하기
boxplot( mpg ? cyl, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Number of cylinders", 
col = c(3,4,6), border = c(3,4,6), pars = list(boxwex = 0.3), main = "mpg vs. cyl", horizontal= T)

#7번
#R Graphics 1.3절 참고해 graphics device 사용해보기
#예) pdf() 그림 저장 시작 > dev.off() 저장 종료

#8번
#mfcol, mfrow 사용해 2번을 2X3 형태로 출력해보기


#------------------------------------------------------------------------


#Exercise 1: 투명 색상 만들기

?rgb #rgb(red, green, blue, alpha, names = NULL, maxColorValue = 1)
?adjustcolor #adjustcolor(col, alpha.f = 1, red.f = 1, green.f = 1, blue.f = 1)

x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )

?colorRamp #두가지 색을 보간해 리턴해주는 함수
ramp <- colorRamp(c("red", "white"))
cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 200)

plot( y ~ x, col = cols.rgb, pch = 16 )
plot( y ~ x, col = adjustcolor( "blue", alpha.f = 0.2), pch = 16 )

?col2rgb #색상을 rgb로 변환
trans.col <- function(col, alpha.f) {
  rgb.code <- col2rgb(col)
  col.res <- rgb(t(rgb.code), max = 255, alpha = alpha.f * 255)
  return(col.res)
}

adjustcolor( "red", alpha.f = 0.2)
trans.col( "red", alpha.f = 0.2 )

#Exercise 2: 자신만의 컬러 팔레트 만들기

?.First()

myFall.palette <- function() {
  ramp <- colorRamp(c("red4", "gold2"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}

x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )
plot( y ~ x, col = myFall.palette(), pch = 16 )

#.Rprofile, Rprofile.site 파일에 삽입
.First <- function(){
  myFall.palette <- function() {
    ramp <- colorRamp(c("red4", "gold2"))
    cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
    return(cols.rgb)
  }
}

#Exercise 3: 자신만의 컬러 팔레트 패키지 만들기

mySpring <- function() {
  ramp <- colorRamp(c("Green1", "Yellow1"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}
mySummer <- function() {
  ramp <- colorRamp(c("Chartreuse1", "Steel Blue1"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}
myFall <- function() {
  ramp <- colorRamp(c("Red4", "Gold2"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}
myWinter <- function() {
  ramp <- colorRamp(c("Black", "White"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}

#확인
library(devtools)
library(roxygen2)
library(myPalette)
x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )
plot( y ~ x, col = mySpring(), pch = 16 )
plot( y ~ x, col = mySummer(), pch = 16 )
plot( y ~ x, col = myFall(), pch = 16 )
plot( y ~ x, col = myWinter(), pch = 16 )

#http://r-bong.blogspot.com/2016/03/rstudio.html 참고

#Exercise 4: 뉴욕 택시 자료

#“Using coarse GPS data to quantify city-scale transportation system resilience to extreme events.”
#Abstract, Introduction(Motivation,
Application To Hurricane SandyWith New York City Taxi, the dataset), Conclusion

Q1. 연구의 목적
  : 이 연구는 택시의 GPS 데이터를 활용하여 특정 지역 사이의 속도 분포, 특정 사건 동안의 속도 편차 등 
교통시스템의 회복력을 정량적으로 측정하는 방법을 제안하고자 한다.
Q2. 연구의 동기
  : 재난 재해 상황에서 교통시설 능력을 정량적으로 평가할 수 있는 방법은 반드시 필요하다.
기존 교통 성능 측정 방법은 비용이 비싸나 이 연구는 택시 데이터만으로도 교통성능을 측정할 수 있는 방법을 제시한다.
  1. 도시 또는 그 이상 규모에 적용할 수 있음.
  2. 회복 시간, 최고 속도 편차 등의 관점에서 네트워크 성능을 정량적으로 측정함. 
  3. 교통 상황 및 데이터의 고유한 변동을 수용함.
  4. 계산적으로 쉬움.
Q3. 자료 정리 방법(특별히 자료의 이상한 관측값들을 어떻게 처리했나를 생각해 볼 것)
  : 이 연구는 4년간 7억 건의 운행 기록을 보유한 뉴욕 택시 데이터를 가지고 분석하였다.
표의 각 행은 승객이 탔을 때 한 택시의 운행 데이터이고, 
각 열(pickup datetime, dropoff datetime, duration 등)은 분석에 필요한 항목들로 이루어져있다.
또한, 미터거리가 직선거리보다 상당히 짧은 경우, 불가능한 거리, 속도, 시간을 포함하는 경우 등
자료의 7.5%를 차지하는 명확한 오류 데이터들은 모두 제거되었다.
Q4. 결론
: 이 분석은 택시 GPS 데이터만을 사용하여 교통시설에 대한 특이사건의 영향을 예측하고 측정할 수 있음을 보여준다. 
이 분석에서 가장 중요한 점은 추가 센서를 설치할 필요가 없기 때문에 비용이 매우 저렴하다는 점이다. 
또한, 여러 도시 사이의 마일당 평균 이동 시간 , 도착 시간을 계산하고 
일반적인 값으로부터의 특이사건의 영향을 받은 속도 편차의 크기와 기간을 정량화한다. 
이 측정은 일반적인 교통 통계와 비교해 중요한 사건을 임의의 일일 변동과 구별할 수 있다.
  분석 결과 허리케인 샌디는 4년 데이터 집합에서 가장 긴 사건이며 속도 편차 측면에서 가장 심각한 사건 중 하나였으며 
우리는 분석을 통해 사건 후 더 많은 교통 관리가 필요하다는 사실을 알 수 있었다. 
허리케인 샌디와 같은 특이사건 분석은 도시의 비정형적인 특성을 파악하고 도시의 새로운 교통 네트워크 제안하는데 도움을 줄 수 있다.

# 자료 분석하기
Q1. 택시 운행이 가장 빈번했던 시간대는? > 20시
Q2. 택시 운행이 가장 빈번했던 요일은? > 목요일
Q3. 각 시간대에서 가장 빈번했던 요금 코드는? : rate-code=1

filein <- "trip_data_1_sample.csv" 
dat <- read.csv(file = filein, nrow = 10, stringsAsFactors = FALSE) #파일 읽기
headerInfo <- read.csv("dictionary_trip_data.csv", stringsAsFactors=FALSE) #파일 읽기
colClasses <- as.character(as.vector(headerInfo[1, ]))
colClasses[1:2] <- "character"
dat <- read.csv(file = filein, nrow = 10, col.names = names(headerInfo), colClasses = colClasses )
dat <- read.csv(file = filein, col.names = names(headerInfo), colClasses = colClasses ) #열 이름 지정
head(dat) #확인
str(dat) #확인

original <- dat[[6]]
date <- as.Date(original, origin = "1970-01-01")
wkday <- weekdays(date)
hour <- format(as.POSIXct(original), "%H")
head(original)
head(date)
head(wkday)
head(hour)

mydat <- data.frame(date, hour)
head(mydat)

z <- aggregate(date ~ hour, mydat, FUN = length)  #시간대별로 몇번 발생했는지
str(z)
apply(table(date, hour),2,sum)
par( mar = c(5,5,1,1))
plot( date ~ as.numeric(hour), data = z, type ="n", xlab = "hour", ylab = "freq")
lines( as.numeric(z$hour), z$date, col = "black")
ind <- which( z$date == max(z$date))
abline( v = ind, col = "red")
text( as.numeric(z$hour), z$date, z$date, cex = 0.8, col = "red")
box()

zz <- aggregate(date ~ wkday, mydat, FUN = length)  #요일별로 몇번 발생했는지
str(zz)
apply(table(date, wkday),2,sum)
wresult <- apply(table(date, wkday),2,sum)
str(wresult)
par( mar = c(5,5,5,3))
b_chart <- barplot(wresult, xlab = "wkday", ylab = "freq", col="grey85")
ind <- which( wresult == max(wresult))
abline( h=max(wresult), col = "red")
text(b_chart, wresult-50, wresult, cex = 0.8, col = "red" )
#box()

table(dat$rate_code, as.factor(hour)) #시간대별 가장 빈번한 요금 코드
zzz <- table(dat$rate_code, as.factor(hour))
str(zzz)
par(mar = c(5,5,3,3))
plot(zzz[2,], type="o", lty=3, ylim=c(0,1000), xlab = "hour", ylab = "frequency", col = "red")
title("rate-code 1")
par(new=TRUE)
plot(zzz[3,], type="l", lty=3, ylim=c(0,1000), xlab = "", ylab = "", col = "grey10")
par(new=TRUE)
plot(zzz[4,], type="l", lty=3, ylim=c(0,1000), xlab = "", ylab = "", col = "grey30")
par(new=TRUE)
plot(zzz[5,], type="l", lty=3, ylim=c(0,1000), xlab = "", ylab = "", col = "grey50")
par(new=TRUE)
plot(zzz[6,], type="l", lty=3, ylim=c(0,1000), xlab = "", ylab = "", col = "grey70")
box()

#Exercise 5: RDBM and R

library(DBI)
library(RMySQL)
con <- dbConnect(dbDriver("MySQL"), host = "statistics.ssu.ac.kr", dbname = "TEST2010DB", user = "tester", password = "tester")
dbGetQuery(con, "show tables;") # connect DB
sql <- "select * from gj limit 10;"
res <- dbGetQuery(con, sql) # save query result to an object named as dat.jk.gj
#res
dbDisconnect(con) # disconnet DB

Q. SQL 검색 쿼리 작성
예제1 : 2010년도 30,40대 직장인의 허리둘레, 혈압, 혈당, 총 콜레스테롤 자료 추출

SELECT `jk`.`STND_Y_JK`, `jk`.`PERSON_ID_JK`, `jk`.`AGE_GROUP_JK`, `jk`.`IPSN_TYPE_CD_JK`, `gj`.`HCHK_YEAR_GJ`, `gj`.`YKIHO_GUBUN_CD_GJ`, `gj`.`HEIGHT_GJ`, `gj`.`WEIGHT_GJ`, `gj`.`WAIST_GJ`, `gj`.`BP_HIGH_GJ`, `gj`.`BP_LWST_GJ`, `gj`.`BLDS_GJ`, `gj`.`TOT_CHOLE_GJ`
FROM `jk`, `gj` 
WHERE  `jk`.`PERSON_ID_JK` = `gj`.`PERSON_ID_GJ` 
AND ( `AGE_GROUP_JK` >= 7 AND `AGE_GROUP_JK` <= 10 AND `IPSN_TYPE_CD_JK` = 5 )

#Exercise 6: Make a Christmas card using R

#Example 1
WM <- matrix(
  c(0,0,0,0.16,
  0.85,0.04,-0.04,0.85,
  0.20,-0.26,0.23,0.22,
  -0.15,0.28,0.26,0.24), nrow = 4)
TM <- matrix(
  c(0, 0, 0, 1.6, 
  0, 1.6, 0, 0.44), nrow=2)
N = 1e5
prob <- c(0.02, 0.84, 0.07, 0.07)
k <- sample(1:4, N, prob, replace=TRUE)
x = matrix(NA, nrow=2, ncol=N)
x[,1] = c(0.1,0.1) # initial point
for (i in 2:N) {
  x[,i] = crossprod(matrix(WM[,k[i]], nrow=2), x[,i-1]) + TM[,k[i]]
}
jpeg(filename = "barnsley_fern.jpg", width = 480, height = 720, quality =100 )
  par(bg="gold",mar=rep(0,4))
  plot(x=x[1,],y=x[2,], 
  col=grep("blue",colors(),value=TRUE), 
  axes=FALSE, pch = 16, cex=.3, 
  xlab="", ylab="" )
dev.off()

#Example 2
L <-  matrix(
    c(0.03,  0,     0  ,  0.1,
        0.85,  0.00,  0.00, 0.85,
        0.8,   0.00,  0.00, 0.8,
        0.2,  -0.08,  0.15, 0.22,
        -0.2,   0.08,  0.15, 0.22,
        0.25, -0.1,   0.12, 0.25,
        -0.2,   0.1,   0.12, 0.2),
    nrow=4)
# … and each row is a translation vector
B <- matrix(
    c(0, 0,
        0, 1.5,
        0, 1.5,
        0, 0.85,
        0, 0.85,
        0, 0.3,
        0, 0.4),
    nrow=2)
prob = c(0.02, 0.6,.08, 0.07, 0.07, 0.07, 0.07)

# Iterate the discrete stochastic map 
N = 1e5 #5  # number of iterations 
x = matrix(NA,nrow=2,ncol=N)
x[,1] = c(0,2)   # initial point
k <- sample(1:7,N,prob,replace=TRUE) # values 1-7 

for (i in 2:N) 
  x[,i] = crossprod(matrix(L[,k[i]],nrow=2),x[,i-1]) + B[,k[i]] # iterate 

# Plot the iteration history 
png('card.png')
par(bg='darkblue',mar=rep(0,4))    
plot(x=x[1,],y=x[2,],
    col=grep('green',colors(),value=TRUE),
    axes=FALSE,
    cex=.1,
    xlab=",
    ylab=" )#,pch=’.’)
bals <- sample(N,20)
points(x=x[1,bals],y=x[2,bals]-.1,
    col=c('red','blue','yellow','orange'),
    cex=2,
    pch=19
)
text(x=-.7,y=8,
    labels='Merry',
    adj=c(.5,.5),
    srt=45,
    vfont=c('script','plain'),
    cex=3,
    col='gold'
)
text(x=0.7,y=8,
    labels='Christmas',
    adj=c(.5,.5),
    srt=-45,
    vfont=c('script','plain'),
    cex=3,
    col='gold'
)
dev.off()

#나만의 크리스마스 카드 만들기

library(plotly)
x<-rnorm(5000,.5,3)
y<-rnorm(5000,.5,3)
z<-rbeta(5000,.5,7)
color<-runif(5000, min=0, max=1)
color<-ifelse(color<=.2,1,0) #20%는 장식
df<-data.frame(x,y,z,color)
df$color<-df$color+runif(nrow(df), min=-.1, max=.3)
df$size <-c(rep(1,nrow(df)))

#데이터를 원뿔 모양으로 정리
df$z1<-ifelse(x<0,x*0.05+0.5,x*-0.05+0.5)
df$z2<-ifelse(y<0,y*0.05+0.5,y*-0.05+0.5)
df$TF<-with(df,ifelse(z>z1|z>z2,1,0))
df<-subset(df,df$TF==0)

#x,y의 중앙값, z의 최대값 좌표에 별 넣기
star<-c(z=max(df$z)-.005,x=median(df$x)-.005,y=median(df$y)-.005,
color=1.5,size=5,z1=NA,z2=NA,TF=NA)
df<-rbind(df,star)

#png 파일로 그림 저장
png('mytree.png')
#초록, 노랑(장식), 빨강(별)으로 트리 완성
plot_ly(df, x = ~x, y = ~y, z = ~z, color = ~color, 
  colors = c('#009916', '#ffff00','#ea0056'), 
  size = ~size, marker = list(symbol = c('diamond'), sizemode = c('diameter')),
  sizes = c(7, 20)) %>% layout(title = 'X-mas Tree')
dev.off()

