#9��11��

#~p.39
#������ ������� �о��

getwd()
dir()
data()
search()
str(cars)
write.csv(cars, "cars.csv") #���� �����
?write.csv
dat <- read.csv("cars.csv")
str(dat)
summary(dat)
fivenum(dat[,1])
sapply(dat, mean, na.rm=TRUE)
sapply(dat, sd, na.rm=TRUE)
sapply(dat, median, na.rm=TRUE)
sapply(dat, range, na.rm=TRUE)
sapply(dat, quantile , na.rm=TRUE)

str(mtcars)
attach(mtcars)
par(mar=c(5,3,5,3))
plot(wt, mpg, col="lightblue", pch=16)
abline(lm(mpg~wt), col=2, lwd=2)
title("Regression of MPG on Weight")
dev.off() #����̽� ����

pdf("mtcars.pdf", width=6, height=6) #�Ʒ� ������ ����ߴٰ� pdf ���Ϸ� ����
attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
dev.off()

.libPaths() #get library location
library(MASS) #see all packages installed
search() #see packages currently loaded
install.packages("packagename")

#~lec3 p.5
Atomic Vector vs List
Matrix vs Data frame
= Homogeneous vs Heterogeneous
Array�� ���� �� ���� �߼�

