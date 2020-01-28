#RHadoop 과제3

#lec 20 실습문제 1,2

dat <- mtcars[c("mpg","cyl","wt")] # mtcars에서 mpg, cyl, wt 변수로 데이터프레임 형태의 자료를 포함한 dat 객체 생성
str(dat) # dat 자료 구조
dat$cyl <- as.factor(dat$cyl) # numeric 형태의 cyl 변수를 팩터(범주형 자료)로 변환
# pair plot
pairs(dat, col = 4, pch = 16, cex = 1.5, panel = panel.smooth, lower.panel = NULL)

fit <- lm( formula = mpg ~ cyl + wt, data = dat ) # 다중선형회귀모형 적합
summary(fit) # 적합 결과1, 가변수 cyl6, cyl8를 사용해 범주형변수 cyl를 표현 
anova(fit) # 적합 결과2: ANOVA Table

f.val <- ((824.78+118.20)/(3))/(183.06/28); f.val
pf( f.val, 3, 28, lower.tail = FALSE)



#실습 문제1 : 위의 결과를 R을 사용해서 직접 계산해보세요.

X <- model.matrix(fit) #디자인 행렬 생성
head(X,10) # 가변수 cyl6, cyl8을 포함한 디자인 행렬로 올바르게 표현됨
class(X)
str(X)

#분산분석
Y <- as.matrix(mtcars["mpg"])
beta <- qr.coef(qr(X), Y) #회귀계수 추정
SSE <- t(Y-(X%*%beta))%*%(Y-(X%*%beta)) #오차 제곱합(SSE)
m <- mean(Y)
SST <- t(Y-m)%*%(Y-m) #총 제곱합(SST)
SSR <- t((X%*%beta)-m)%*%((X%*%beta)-m) #회귀 제곱합(SSR)
c(SST-SSE, SSR) #확인

#분산분석표 작성
result <- data.frame("요인" = c("회귀", "오차", "전체"), 
  "자유도" = rep(0,3), "제곱합" = rep(0,3),
  "평균제곱" = rep(0,3), "F비" = rep(0,3))
result$자유도[1] <- 3 #cyl:2, wt:1
result$자유도[3] <- nrow(dat)-1
result$자유도[2] <- result$자유도[3]-result$자유도[1]
result$제곱합 <- c(SSR, SSE, SST)
result$평균제곱[1:2] <- result$제곱합[1:2]/result$자유도[1:2]
result$F비[1] <- result$평균제곱[1]/result$평균제곱[2]
result

R2 <- SSR/SST; R2 #결정계수
Adj.R2 <- 1-(result$평균제곱[2]/(result$제곱합[3]/result$자유도[3])); Adj.R2 #수정된 결정계수
Resi <- sqrt(result$평균제곱[2]); Resi #Residual standard error

#F 검정
pf(result$F비[1], result$자유도[1], result$자유도[2], lower.tail = FALSE)
#lm()을 적용한 값과 같음


#실습 문제2 : R하둡을 사용해서 분석을 하려고 할 때, 
map(), reduce(), mapreduce() 함수를 어떻게 작성하면 되는지 적어보세요. 

library(rJava)
library(rmr2)
library(rhdfs)
hdfs.init()

#첫번째 map 함수 ,t(X)*X 계산
mr.map1 <- function(., Xr){
  Xr <- Xr[,-1]
  keyval(1, list(t(Xr) %*% Xr))
}

#reduce 함수
mr.reduce <- function(., A){
  keyval(1, list(Reduce('+', A)))
}

#두번째 map 함수, t(X)*Y 계산
mr.map2 <- function(., Xr){
  Yr <- Xr[,1]
  Xr <- Xr[,-1]
  keyval(1, list(t(Xr) %*% Yr))
}

#mapreduce 함수
X1 <- to.dfs(table) #HDFS 내 table 데이터 불러오기
XtX <- values( from.dfs(
  mapreduce( input=X1, map=mr.map, reduce=mr.reduce, combine=T)))[[1]] #t(X)*X 계산
Xty <- values( from.dfs(
  mapreduce( input=X1, map=mr.map2, reduce=mr.reduce, combine=T)))[[1]] #t(X)*Y 계산

#회귀계수 추정
beta <- solve(XtX, Xty)







