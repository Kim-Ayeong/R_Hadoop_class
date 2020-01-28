#10�� 24��

<����>
#1. R������Ʈ
install.packages('installr')
library(installr)
updateR()
R.Version()$version.string #Ȯ��
getRversion()
#2. Rtools �ٿ�
#3. �ý��� ȯ�溯������ path ��� �߰�
#�Ǵ� cmd â > PATH C:\Program Files\R\R-3.5.1\bin ���
            > R ����
#5. ��Ű�� ��ġ, �ε�
install.packages("devtools", "roxygen2")
library("devtools", "roxygen2")
#6. C ���� �ۼ� �� Ȯ��
getwd() #�ʿ��ϸ� setwd()�� �۾���� ����
dir()
#7. R���� ������
system("R CMD SHLIB convolve.c") #compile C code
dir() 				   #dll ���� Ȯ��
dyn.load("convolve.dll")

#�ǽ�����1
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

#�ǽ�����2
a = 1:3
b = 2:5
convC(a,b)

#�ǽ�����3
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

#�ǽ�����4
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
