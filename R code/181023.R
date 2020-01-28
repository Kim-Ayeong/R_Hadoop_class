#10월 23일

#lec11
R에서 C언어로 작성한 함수를 호출할 수 있는 방법(routine)
.C()
.Call()

#준비
1.R 버전 확인 > 최신버전으로 업데이터
R.Version()$version.string
getRversion()
2.Rtools 설치(스마트캠퍼스 파일 다운)
3.환경변수 지정

#C코드 작성시 유의사항
모든 함수는 void를 기술
매개변수는 모두 포인스 변수
모든 파일에 #include <R.h> 포함

#Example 1
#R로 작성
simfun1 <- function(){
  for(i in 0:10)
  cat(paste(paste("Number of index = ", i, sep = ""), "\n", sep = ""))
}
simfun1()
#C로 작성 < R스튜디오에서 simple1.c로 저장
#include <R.h>
void simfun1(){
  int i;
  for(i = 0; i <= 10; i++){
    Rprintf("Number of index = \%d\n", i);
  }
}
#컴파일 > simple1.dll 생성
dir()
getwd()
system("R CMD SHLIB simfun1.c") #compile C code
#R에서 실행
dyn.load("simfun1.dll") #load C code to R
simfun1 <- function(){
  res <- .C("simfun1")
  return(res)
}
simfun1()

#Example 2
#R로 작성
simfun2 <- function(n){
  for(i in 1:n)
    cat("Welcome to Bigdata Analytics!\n")
  }
simfun2(n=3)
#C로 작성
#include <R.h>
void simfun2(int*n){		# *=포인터 변수
  int i;
  for(i = 1; i <= *n; i++){
    Rprintf("Welcome to Bigdata Analytics!\n");
  }
}
#컴파일
system("R CMD SHLIB simfun2.c")
#R에서 실행
dyn.load("simfun2.dll")
simfun2 <- function(n){
  .C("simfun2", as.integer(n))
}
simfun2(2)
#C에서 R로 넘어올 때 결과값은 리스트 형태로 넘어옴

#Example 3
#R로 작성
simfun3 <- function(n){
  res <- integer(n)
  for(i in 0:n)
    res[i] <- i
  return(res)
}
simfun3(n=5)
#C로 작성
#include <R.h>
void simfun3(int*n, int*res){
  int i;
  for(i = 0; i <= *n; i++){
    res[i] = i; #결과값이 없고 argument를 가져옴
  }
}
#컴파일
system("R CMD SHLIB simfun3.c")
#R에서 실행
dyn.load("simfun3.dll")
simfun3 <- function(n){
  res <- .C("simfun3", as.integer(n), res = integer(n))$res    #res를 바로 출력
  res[["res"]]
}
simfun3(3)
