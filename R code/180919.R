#9��19��

#Exercise 4 : switch���� �̿��� �Լ� ���� ���� 

methods(class = "lm") #��� ������ �޼ҵ� ���
methods(plot)
plot.default
plot.density #����
getAnywhere("plot.density") #stats ��Ű�� �ȿ� ����
getAnywhere("plot.lm")
getS3method(f="plot", class="density")

fit <- lm(mtcars$mpg ~ mtcars$cyl)
fit
plot(fit)
plot(mtcars$mpg ~ mtcars$cyl)

xx <- 1:20
class(xx)
summary(xx) #��跮 ���

yy <- sample(x=c("L", "M", "H"), size=20, replace=T)
yy <- ordered(yy, levels = c("L", "M", "H"))
class(yy)
summary(yy) #���̺� ���

dat <- data.frame(xx, yy)
str(dat)
class(dat)
summary(dat) #������ ���� �´� summary

fit <- lm(xx ~ yy) #fit a linear model and assign its results to
class(fit)
summary(fit)
class(fit) <- "data.frame"
class(fit)
summary(fit)

methods(summary)

fun <- function( x ){
  res <- sample( x = c("H","T"), size = 1)
  if( !is.character(x) ) stop( "x must be a character H or T!")
  if( length(x) > 1 ) stop( "x must be a character H or T!")
  if( is.character(x) & x == res ) print("You win!")
  else print("You lost!")
  ress <- is.character(x) & x == res
  resss <- list(res, ress)
  structure( resss, class = "fun" ) #"fun" Ŭ���� ����
}
toss <- fun( "H" )
str(toss)
class(toss)
toss[[1]]
toss[[2]]
toss

summary.fun <- function( x ){  #summary ����
  cat(paste("computer coin toss result:", x[[1]]))
  cat("\n")
  cat(paste("your guess = computer coin toss result?", x[[2]]))
}
summary(toss)

#lec6

3 + 2 #Addition
5 - 2 #Subtraction
5 * 3 #Multiplication
5 / 3 #Division
2��10 
2**10 #Exponent
5 %% 2 #������ Modulus (Remainder from division)
5 %/% 2 #��, Integer Division
2 == 10 #Equal to
5 != 2 #Not equal to

TRUE | FALSE 	#Element-wise OR
TRUE || FALSE 	#OR
TRUE & FALSE 	#Element-wise AND
TRUE && FALSE 	#AND

((-2:2)>=0) & ((-2:2)<=0) #������ �� ���Һ��� ��� ����
(-2:2)>=0
(-2:2)<=0
((-2:2)>=0) && ((-2:2)<=0) #��ü ������ ���

a
TRUE | a 	#����
FALSE & a 	#����
TRUE || a 	#�ʿ��� �������� ����
FALSE && a 	#�ʿ��� �������� ����

A <- a <- 4; A; a
A = a = 4; A; a
4 -> a -> A; A; a
A <- B = 25  #����
A <- (B = 25)  #����X

rm(list=ls()); objects()
fun1 <- function(x){
  y <- 1 + x
  return(y)
}
fun2 <- function(x){
  y <<- 1 + x
  return(y)
}
objects()
fun1(1); objects(); y   #y�� local variable
fun2(1); objects(); y   #y�� global variable

#Recycling Rule ����!
c(1, 2, 3) + c(2, 4, 8, 12, 14, 18)
c(1, 2, 3) + c(2, 4, 8, 12, 14, 18, 22)
5 + c(4, 7, 17)
c(5, 5, 5) + c(4, 7, 17)

A <- matrix(c(1,2,3,4), 2)
B <- matrix(c(1,2,1,2), 2)
A^B
A%*%B
B%*%A

A <- matrix(c(3, 1, 2, 1, 3, 5, 7, -2, 4), nrow=3, byrow=T)
b <- c(3, 2, -1)
solve(A, b) #�����, solves Ax = b(��)
solve(A)
zapsmall(A%*%solve(A)) #�������

A <- matrix(c(3, 1, 2, 1, 3, 5, 7, -2, 4), nrow=3, byrow=T)
det(A)  #determinant
t(A)    #����, tanspose
x <- c(1, 1, 1)
A%*%x
x%*%A; t(x)%*%A
diag(A) #����, print diagonal componants
sum(diag(A))
diag(c(1, 2, 3)) 
diag(3)

A <- matrix(c(3, 1, 2, 1, 3, 5, 7, -2, 4), nrow=3, byrow=T)
rowSums(A); apply(A, 1, sum) #����
colSums(A); apply(A, 2, sum)
rowMeans(A); apply(A, 1, mean)
colMeans(A); apply(A, 2, mean)
apply(A, 2, function(x) {x^2-mean(x)})

A <- matrix(c(1,9,4,1), 2)
eigen(A) #������, ��������
qr(A)
svd(A)

ceiling() #�ø�
floor()   #����
trunc()   #~�� ���� �ʴ� �ִ� ����
x <- c(-3.2, -1.8, 2.3, 2.9)
floor(x); trunc(x)

round()   #�Ҽ��� ~° �ڸ����� �ݿø�
signif()  #�Ҽ��� ~° �ڸ����� �ݿø�
x <- c(3.5678, 5.4321, 135.789)
cbind(x, round=round(x, 2), signif=signif(x, 2))

#~p.20




