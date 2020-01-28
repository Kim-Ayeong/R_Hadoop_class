#9월18일

#lec3_updated2
#factor
x <- factor(c("a", "b", "b", "a"))
str(x) #1,2는 임의로 부여한 factor 수준 값
x[2] <- "a" #가능
x[2] <- "c" #불가능, 미싱값 입력

x <- rep( x = c(0,1), times = c(3,17) )
(Gender <- factor(x)) #convert the numeric vector as a factor
(Gender <- factor(x, levels=c(0, 1), labels=c("M", "F")))
par(mfrow = c(1,2))
plot(Gender, col = c(1,2))

# Ordered factor
x <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
(Income <- ordered(x, levels=c(1, 2, 3), labels=c("L", "M", "H")))

#lec5
{1+2; 3+4; 6+8} #14, 마지막 식만 결과값만 출력

#if문
str(mtcars)
x <- mtcars$mpg
if(is.numeric(x)) boxplot(x, border="blue", col="lightblue", pars=list(boxwex=0.3))
#border:선의 색, col:채우기 색, boxplot의 상대적인 길이가 0.3
x <- factor(mtcars$cyl)
if( is.numeric(x) ) boxplot(x) else {
  if(is.factor(x)) {
    tmp <- table(x)
    nlev <- length(levels(x))
    barplot(tmp, col = (1:nlev) + 1)
  }
}

#for문
x <- mtcars$mpg
(nn <- length(x))
y <- rep("NA", nn)
for(i in 1:nn) {
  tmp <- x[i]
  if(tmp < 12) y[i] <- "low"
  if(tmp >= 12 & tmp < 17) y[i] <- "moderate"
  if(tmp >= 17) y[i] <- "high"
}
y

#repeat, while문보다 for문 사용을 권장
#function
simfun1 <- function(x){
  res <- x^2
  return(res)
}
class(simfun1)
simfun1(1:3)

simfun2 <- function(x){
  res <- x^2
  invisible(res)
}
simfun2(1:3) #결과값이 보이지 않음
(tmp <- simfun2(1:3)) #할당 후에는 결과값이 보임

simfun3 <- function(x){
  res <- simfun1(x)
  ress <- res^2
  return(ress)
}
simfun3(1:3)

mvfun <- function(x){
  nn <- length(x)
  res.mean <- sum(x)/nn
  res.var <- sum((x-res.mean)^2)/(nn-1)
  res <- list(mean=res.mean, var=res.var)
  return(res)
}
mvfun(1:3)

#The . . . argument : 이전에 쓰던 argument를 다음 함수에도 전달해줄 수 있음.
simplot1 <- function(x, y){
  fit <- lm(y~x) 
  plot(x, y, col=4, pch=16 )
  abline(fit, col=2, lwd=2)
}
simplot1(x=mtcars$mpg, y=mtcars$cyl)

simplot2 <- function(x, y, lcol=2, lwd=2, ... ){
  fit <- lm(y~x)
  plot(x, y, ...) #plot 속 ...을 함수 인자로도 쓸 수 있음. 
  abline(fit, col=lcol, lwd=lwd) #plot의 ...인자와 충돌할 수 있으므로, lcol, lwd로 따로 지정
}
simplot2(x=mtcars$mpg, y=mtcars$cyl) #디폴트값 그대로 받아오기
simplot2(x=mtcars$mpg, y=mtcars$cyl, col=mtcars$cyl, pch=23) #plot 함수의 ...인자로 전달
simplot2(x=mtcars$mpg, y=mtcars$cyl, lcol=4, lwd=1, col=mtcars$cyl, pch=23)

plot(1:25, col=1:25, pch=1:25, cex=2) #이 중에서 골라 사용하기

#Exercise 2
simfun4 <- function(x){
  if(is.numeric(x)) x.num <- x
  else stop("x must be a numeric vector!")
  res <- x.num^2
  return(res)
}
simfun4(1:3)
simfun4(rep("m",3))

#Exercise 3
guessfun <- function(x){
  if(!is.character(x) || length(x)>1) stop("x must be a character H or T!")
  res <- sample( x = c("H","T"), size = 1 )
  if( is.character(x) && x == res) print("You win!")
  else print("You lose!")
}
guessfun(1)
guessfun(c("H","T"))
guessfun(H)
guessfun("H")

