#10�� 23��

#lec11
R���� C���� �ۼ��� �Լ��� ȣ���� �� �ִ� ���(routine)
.C()
.Call()

#�غ�
1.R ���� Ȯ�� > �ֽŹ������� ��������
R.Version()$version.string
getRversion()
2.Rtools ��ġ(����Ʈķ�۽� ���� �ٿ�)
3.ȯ�溯�� ����

#C�ڵ� �ۼ��� ���ǻ���
��� �Լ��� void�� ���
�Ű������� ��� ���ν� ����
��� ���Ͽ� #include <R.h> ����

#Example 1
#R�� �ۼ�
simfun1 <- function(){
  for(i in 0:10)
  cat(paste(paste("Number of index = ", i, sep = ""), "\n", sep = ""))
}
simfun1()
#C�� �ۼ� < R��Ʃ������� simple1.c�� ����
#include <R.h>
void simfun1(){
  int i;
  for(i = 0; i <= 10; i++){
    Rprintf("Number of index = \%d\n", i);
  }
}
#������ > simple1.dll ����
dir()
getwd()
system("R CMD SHLIB simfun1.c") #compile C code
#R���� ����
dyn.load("simfun1.dll") #load C code to R
simfun1 <- function(){
  res <- .C("simfun1")
  return(res)
}
simfun1()

#Example 2
#R�� �ۼ�
simfun2 <- function(n){
  for(i in 1:n)
    cat("Welcome to Bigdata Analytics!\n")
  }
simfun2(n=3)
#C�� �ۼ�
#include <R.h>
void simfun2(int*n){		# *=������ ����
  int i;
  for(i = 1; i <= *n; i++){
    Rprintf("Welcome to Bigdata Analytics!\n");
  }
}
#������
system("R CMD SHLIB simfun2.c")
#R���� ����
dyn.load("simfun2.dll")
simfun2 <- function(n){
  .C("simfun2", as.integer(n))
}
simfun2(2)
#C���� R�� �Ѿ�� �� ������� ����Ʈ ���·� �Ѿ��

#Example 3
#R�� �ۼ�
simfun3 <- function(n){
  res <- integer(n)
  for(i in 0:n)
    res[i] <- i
  return(res)
}
simfun3(n=5)
#C�� �ۼ�
#include <R.h>
void simfun3(int*n, int*res){
  int i;
  for(i = 0; i <= *n; i++){
    res[i] = i; #������� ���� argument�� ������
  }
}
#������
system("R CMD SHLIB simfun3.c")
#R���� ����
dyn.load("simfun3.dll")
simfun3 <- function(n){
  res <- .C("simfun3", as.integer(n), res = integer(n))$res    #res�� �ٷ� ���
  res[["res"]]
}
simfun3(3)