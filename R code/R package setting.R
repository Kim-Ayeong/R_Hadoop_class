#10월 24일

<순서>
#1. R업데이트
install.packages('installr')
library(installr)
updateR()
R.Version()$version.string #확인
getRversion()
#2. Rtools 다운
#3. 시스템 환경변수에서 path 모두 추가
#또는 cmd 창 > PATH C:\Program Files\R\R-3.5.1\bin 등등
            > R 실행
#5. 패키지 설치, 로딩
install.packages("devtools", "roxygen2")
library("devtools", "roxygen2")
#6. C 파일 작성 후 확인
getwd() #필요하면 setwd()로 작업경로 변경
dir()
#7. R에서 컴파일
system("R CMD SHLIB convolve.c") #compile C code
dir() 				   #dll 파일 확인
dyn.load("convolve.dll")

#실습문제1
system("R CMD SHLIB convolve.c") #compile C code
dyn.load("convolve.dll")

convC <- function(a, b){
  .C("convolve",
  as.double(a),
  as.integer(length(a)),
  as.double(b),
  as.integer(length(b)),
  ab = double(length(a) + length(b) - 1)
  )
}

#실습문제2
a = 1:3
b = 2:5
convC(a,b)

#실습문제3
convR1 <- function(a, b){
  na = length(a)
  nb = length(b)
  nab = na + nb - 1
  ab = numeric(length(a) + length(b) - 1)
  for(i in 1:na){
    for(j in 1:nb)
      ab[i + j - 1] = ab[i + j - 1] + a[i] * b[j]
  }
  return(ab)
}

convR2 <- function(a, b){
  na = length(a)
  nb = length(b)
  nab = na + nb - 1
  ab = numeric(length(a) + length(b) - 1)
  ab.new = ab
  for(i in 1:na){
    ab.old = ab.new
    ab.tmp = ab
    ab.tmp[c(1:nb)+(i-1)] = a[i] * b
    ab.new = ab.old + ab.tmp
  }
  ab = ab.new
  return(ab)
}

convR3 <- function(a, b){
  na = length(a)
  nb = length(b)
  nab = na + nb - 1
  ab = numeric(length(a) + length(b) - 1)
  AB = lapply( 1:na, function(x) {
    ab[c(1:nb)+(x-1)] = a[x]*b
    ab} )
  ab = Reduce("+", AB)
  return(ab)
}

#실습문제4
a = 1:30
b = 2:50
system.time( convC(a,b) )
system.time( convR1(a,b) )
system.time( convR2(a,b) )
system.time( convR3(a,b) )

a = 1:3000
b = 2:5000
system.time( convC(a,b) )
system.time( convR1(a,b) )
system.time( convR2(a,b) )
system.time( convR3(a,b) )

a = 1:3000
b = 2:5000

#install.packages("microbenchmark")
library(microbenchmark)
microbenchmark(
convC(a,b),
convR1(a,b),
convR2(a,b),
convR3(a,b),
times = 10L
)

