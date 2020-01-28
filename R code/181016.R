#10�� 16��

#lec 9

aggregate() : �����͸� ���� �����ͷ� ������ ������ ����, �л� ������ �� �� ����

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

as.POSIXct() : ���� ������ POSIXct ��ü�� ��ȯ, �ð� ���� ������ �ٷ� �� ����
format() �Լ�: POSIXct ��ü�� ���� Ÿ������ ��ȯ

(z <- Sys.time()) 			# ���� �ð�, as class "POSIXct"
unclass(z) 					# a large integer, ���� �ð������ ���ݱ����� �� �ð�
floor(unclass(z)/86400) 		# 1970-01-01������ �� �ð�
(now <- as.POSIXlt(Sys.time())) 	# ���� �ð��� "POSIXlt" ��ü��
unlist(unclass(now)) 			# �ð��� �����׷����� ���� 
now$year + 1900 				# see ?DateTimeClasses
months(now); weekdays(now) 		# see ?months

as.POSIXlt(x = Sys.time())
as.POSIXlt(x = Sys.time(), tz = "Asia/Seoul") #KST: ���ѹα� ǥ�ؽ�
as.POSIXlt(x = unclass(Sys.time()), origin = "1970-01-01", tz = "GMT") #GMT ��������
as.POSIXlt(x = unclass(Sys.time()), origin = "1970-01-01", tz = "Asia/Seoul")

source() : ���� �ȿ� ����� script�� R session�� �о���µ� ���
getwd()
dir( pattern = "myt") #myt�� �����ϴ� ���ϸ� �˻�
source( "myttest.R" )
objects(pattern = "myt")
source("http://statistics.ssu.ac.kr/~SHCHO/myttest.R") # read a file directly using URL

rgb() : RGB(red, green, blue) ���� �ش��ϴ� ������ ���� �� ����
rgb(128, 0, 0, max = 255)

datcol <- read.csv( "color.csv", header = F, stringsAsFactors = FALSE)
myfavcol <- datcol[[2]]
write.csv( myfavcol, "myfavcol.csv", row.names = F)
cols <- read.csv( "myfavcol.csv") #���� ����ϴ� �÷� �����س���
#plot(1:13, col=as.character(cols$x), pch=16, cex=1.2)�� Ȯ��

#R�� ������ �� �ڵ������� �о���� ���� ��
1. C:\Program Files\R\R-n.n.n\etc �ȿ� �ִ� Rprofile.site�� �߰� �ۼ�
2. ~.Rprofile file �ۼ�
First( ) will be run at the start of the R session
Last( ) will be run at the end of the session

#1. first.R�̶�� ���� �ȿ� ������ script�� ����
library(utils)
cols <- read.csv( "myfavcol.csv")
#2. ���� �۾� directory �ȿ� .Rprofile �Լ��� �����ؼ� ������ script�� ����
.First <- function(){
  source("first.R")
  cat("\nWelcome at", date(), "\n")
}
.Last <- function(){
  cat("\nGoodbye at ", date(), "\n")
}

# New York Taxi �ڷ� �м��ϱ�
Q1. �ý� ������ ���� ����ߴ� �ð����?
Q2. �ý� ������ ���� ����ߴ� ������?
Q3. �� �ð��뿡�� ���� ����ߴ� ��� �ڵ��?
Q4. �� ������ ���� ������ �ð��� �����?

#�ǽ��ڵ�

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
z <- aggregate(date ~ hour, mydat, FUN = length)  #�ð��뺰�� ��� �߻��ߴ���, frequence ���
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

