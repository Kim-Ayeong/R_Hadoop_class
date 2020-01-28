#RHadoop ����

#Self-Checking Exercises

#1��
data(mtcars)
mode(mtcars) # memory ����Ǵ� ����
class(mtcars) # R������ �ڷ� ����
# ���� ���̸� �����ϱ� ���ؼ� ��ũ�Ǿ� �ִ� ���� �о ��
names(mtcars)
str(mtcars)
help(mtcars)

#2��
#������ �Լ���(high-level functions): ������ �׸��� ������ ��
?hist()  #histograms
?plot()  #xy plots
?dotchart()  #dot plots
?barplot()  #bar plots
?pie()  #pie charts
?boxplot()  #boxplots

#3��
Q. ������ �Ǹ��� ���� ���� �ڵ��� ���� �Һ񷮰��� ���踦 Ž���ϰ� �ʹٸ� � �׸��� ����ϴ� ���� �����ұ��?
Q. �ڵ����� ���Կ� ���� �Һ񷮰��� ���踦 �˾ƺ��� �ʹٸ� ��� �׸��� �׷����� �������?
Q. �ڵ����� ���� ���°� ������ �Ǹ��� ������ ���踦 ������ Ȯ���� ���� �ʹٸ� � �׸��� ����ϴ� ���� �������?
Q. ������ �Ǹ����� ���� ���� �ڵ����� carburetor�� ���� �׸����� ǥ���ϰ� �ʹٸ�?
Q. �ڵ����� ���Կ� ���� �Һ��� ���踦 ������ �Ǹ����� ���� �˾ƺ��� �ʹٸ� � �׸��� ����ϴ� ���� �������?

#4��
#GP �⺻�� ������
par()
help(par) # par�� help document�� �ð��� �ΰ� �ݺ��ؼ� ���� �� �о����.
# if you use mac,
par("bg") # default background color

#GP ������
?par()
?plot()
- col
? pch
? cex
? xlim, ylim
? lty, lwd
? axes, xaxt, yaxt
? main, xlab, ylab
? type: �׸��� ���� - ��l��: lines, ��p��: points, ��b��: lines and points, ��n��: no plotting

#GP�� ���� ��� ��
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

#5��
#������ �Լ���(low-level functions)
? text()
? abline()
? points()
? polygon()
? lines()
? axis()
? box()
? title()
? legend()

#�׸��� �߰��Ǵ� ���� Ȯ��
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

#6��
#mar ����Ͽ� ���� �����ϱ�
boxplot( mpg ? cyl, data = mtcars, xlab = "mpg(mile per gallon)", ylab = "Number of cylinders", 
col = c(3,4,6), border = c(3,4,6), pars = list(boxwex = 0.3), main = "mpg vs. cyl", horizontal= T)

#7��
#R Graphics 1.3�� ������ graphics device ����غ���
#��) pdf() �׸� ���� ���� > dev.off() ���� ����

#8��
#mfcol, mfrow ����� 2���� 2X3 ���·� ����غ���


#------------------------------------------------------------------------


#Exercise 1: ���� ���� �����

?rgb #rgb(red, green, blue, alpha, names = NULL, maxColorValue = 1)
?adjustcolor #adjustcolor(col, alpha.f = 1, red.f = 1, green.f = 1, blue.f = 1)

x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )

?colorRamp #�ΰ��� ���� ������ �������ִ� �Լ�
ramp <- colorRamp(c("red", "white"))
cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 200)

plot( y ~ x, col = cols.rgb, pch = 16 )
plot( y ~ x, col = adjustcolor( "blue", alpha.f = 0.2), pch = 16 )

?col2rgb #������ rgb�� ��ȯ
trans.col <- function(col, alpha.f) {
  rgb.code <- col2rgb(col)
  col.res <- rgb(t(rgb.code), max = 255, alpha = alpha.f * 255)
  return(col.res)
}

adjustcolor( "red", alpha.f = 0.2)
trans.col( "red", alpha.f = 0.2 )

#Exercise 2: �ڽŸ��� �÷� �ȷ�Ʈ �����

?.First()

myFall.palette <- function() {
  ramp <- colorRamp(c("red4", "gold2"))
  cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
  return(cols.rgb)
}

x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )
plot( y ~ x, col = myFall.palette(), pch = 16 )

#.Rprofile, Rprofile.site ���Ͽ� ����
.First <- function(){
  myFall.palette <- function() {
    ramp <- colorRamp(c("red4", "gold2"))
    cols.rgb <- rgb(ramp(seq(0, 1, length=length(x))), max = 255, alpha = 100)
    return(cols.rgb)
  }
}

#Exercise 3: �ڽŸ��� �÷� �ȷ�Ʈ ��Ű�� �����

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

#Ȯ��
library(devtools)
library(roxygen2)
library(myPalette)
x <- seq(-1, 1, by = 0.001)
y <- 2 + 3*x + rnorm( n = length(x) )
plot( y ~ x, col = mySpring(), pch = 16 )
plot( y ~ x, col = mySummer(), pch = 16 )
plot( y ~ x, col = myFall(), pch = 16 )
plot( y ~ x, col = myWinter(), pch = 16 )

#http://r-bong.blogspot.com/2016/03/rstudio.html ����

#Exercise 4: ���� �ý� �ڷ�

#��Using coarse GPS data to quantify city-scale transportation system resilience to extreme events.��
#Abstract, Introduction(Motivation,
Application To Hurricane SandyWith New York City Taxi, the dataset), Conclusion

Q1. ������ ����
  : �� ������ �ý��� GPS �����͸� Ȱ���Ͽ� Ư�� ���� ������ �ӵ� ����, Ư�� ��� ������ �ӵ� ���� �� 
����ý����� ȸ������ ���������� �����ϴ� ����� �����ϰ��� �Ѵ�.
Q2. ������ ����
  : �糭 ���� ��Ȳ���� ����ü� �ɷ��� ���������� ���� �� �ִ� ����� �ݵ�� �ʿ��ϴ�.
���� ���� ���� ���� ����� ����� ��γ� �� ������ �ý� �����͸����ε� ���뼺���� ������ �� �ִ� ����� �����Ѵ�.
  1. ���� �Ǵ� �� �̻� �Ը� ������ �� ����.
  2. ȸ�� �ð�, �ְ� �ӵ� ���� ���� �������� ��Ʈ��ũ ������ ���������� ������. 
  3. ���� ��Ȳ �� �������� ������ ������ ������.
  4. ��������� ����.
Q3. �ڷ� ���� ���(Ư���� �ڷ��� �̻��� ���������� ��� ó���߳��� ������ �� ��)
  : �� ������ 4�Ⱓ 7�� ���� ���� ����� ������ ���� �ý� �����͸� ������ �м��Ͽ���.
ǥ�� �� ���� �°��� ���� �� �� �ý��� ���� �������̰�, 
�� ��(pickup datetime, dropoff datetime, duration ��)�� �м��� �ʿ��� �׸��� �̷�����ִ�.
����, ���ͰŸ��� �����Ÿ����� ����� ª�� ���, �Ұ����� �Ÿ�, �ӵ�, �ð��� �����ϴ� ��� ��
�ڷ��� 7.5%�� �����ϴ� ��Ȯ�� ���� �����͵��� ��� ���ŵǾ���.
Q4. ���
: �� �м��� �ý� GPS �����͸��� ����Ͽ� ����ü��� ���� Ư�̻���� ������ �����ϰ� ������ �� ������ �����ش�. 
�� �м����� ���� �߿��� ���� �߰� ������ ��ġ�� �ʿ䰡 ���� ������ ����� �ſ� �����ϴٴ� ���̴�. 
����, ���� ���� ������ ���ϴ� ��� �̵� �ð� , ���� �ð��� ����ϰ� 
�Ϲ����� �����κ����� Ư�̻���� ������ ���� �ӵ� ������ ũ��� �Ⱓ�� ����ȭ�Ѵ�. 
�� ������ �Ϲ����� ���� ���� ���� �߿��� ����� ������ ���� ������ ������ �� �ִ�.
  �м� ��� �㸮���� ����� 4�� ������ ���տ��� ���� �� ����̸� �ӵ� ���� ���鿡�� ���� �ɰ��� ��� �� �ϳ������� 
�츮�� �м��� ���� ��� �� �� ���� ���� ������ �ʿ��ϴٴ� ����� �� �� �־���. 
�㸮���� ����� ���� Ư�̻�� �м��� ������ ���������� Ư���� �ľ��ϰ� ������ ���ο� ���� ��Ʈ��ũ �����ϴµ� ������ �� �� �ִ�.

# �ڷ� �м��ϱ�
Q1. �ý� ������ ���� ����ߴ� �ð����? > 20��
Q2. �ý� ������ ���� ����ߴ� ������? > �����
Q3. �� �ð��뿡�� ���� ����ߴ� ��� �ڵ��? : rate-code=1

filein <- "trip_data_1_sample.csv" 
dat <- read.csv(file = filein, nrow = 10, stringsAsFactors = FALSE) #���� �б�
headerInfo <- read.csv("dictionary_trip_data.csv", stringsAsFactors=FALSE) #���� �б�
colClasses <- as.character(as.vector(headerInfo[1, ]))
colClasses[1:2] <- "character"
dat <- read.csv(file = filein, nrow = 10, col.names = names(headerInfo), colClasses = colClasses )
dat <- read.csv(file = filein, col.names = names(headerInfo), colClasses = colClasses ) #�� �̸� ����
head(dat) #Ȯ��
str(dat) #Ȯ��

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

z <- aggregate(date ~ hour, mydat, FUN = length)  #�ð��뺰�� ��� �߻��ߴ���
str(z)
apply(table(date, hour),2,sum)
par( mar = c(5,5,1,1))
plot( date ~ as.numeric(hour), data = z, type ="n", xlab = "hour", ylab = "freq")
lines( as.numeric(z$hour), z$date, col = "black")
ind <- which( z$date == max(z$date))
abline( v = ind, col = "red")
text( as.numeric(z$hour), z$date, z$date, cex = 0.8, col = "red")
box()

zz <- aggregate(date ~ wkday, mydat, FUN = length)  #���Ϻ��� ��� �߻��ߴ���
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

table(dat$rate_code, as.factor(hour)) #�ð��뺰 ���� ����� ��� �ڵ�
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

Q. SQL �˻� ���� �ۼ�
����1 : 2010�⵵ 30,40�� �������� �㸮�ѷ�, ����, ����, �� �ݷ����׷� �ڷ� ����

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
# �� and each row is a translation vector
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
    ylab=" )#,pch=��.��)
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

#������ ũ�������� ī�� �����

library(plotly)
x<-rnorm(5000,.5,3)
y<-rnorm(5000,.5,3)
z<-rbeta(5000,.5,7)
color<-runif(5000, min=0, max=1)
color<-ifelse(color<=.2,1,0) #20%�� ���
df<-data.frame(x,y,z,color)
df$color<-df$color+runif(nrow(df), min=-.1, max=.3)
df$size <-c(rep(1,nrow(df)))

#�����͸� ���� ������� ����
df$z1<-ifelse(x<0,x*0.05+0.5,x*-0.05+0.5)
df$z2<-ifelse(y<0,y*0.05+0.5,y*-0.05+0.5)
df$TF<-with(df,ifelse(z>z1|z>z2,1,0))
df<-subset(df,df$TF==0)

#x,y�� �߾Ӱ�, z�� �ִ밪 ��ǥ�� �� �ֱ�
star<-c(z=max(df$z)-.005,x=median(df$x)-.005,y=median(df$y)-.005,
color=1.5,size=5,z1=NA,z2=NA,TF=NA)
df<-rbind(df,star)

#png ���Ϸ� �׸� ����
png('mytree.png')
#�ʷ�, ���(���), ����(��)���� Ʈ�� �ϼ�
plot_ly(df, x = ~x, y = ~y, z = ~z, color = ~color, 
  colors = c('#009916', '#ffff00','#ea0056'), 
  size = ~size, marker = list(symbol = c('diamond'), sizemode = c('diameter')),
  sizes = c(7, 20)) %>% layout(title = 'X-mas Tree')
dev.off()
