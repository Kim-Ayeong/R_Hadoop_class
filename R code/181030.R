#10월 30일

#R 세팅
R.Version()$version.string
library("devtools", "roxygen2")
getwd()
dir()
system("R CMD SHLIB convolve.c") #compile C code
dir() 				   #dll 파일 확인
dyn.load("convolve.dll")


#SQL 설치(암호 구버전 선택)
#시스템 환경 변수 path 추가

cmd창 > mysql -p -u root
비번 root

#SQL 실행해보기
mysql> SELECT NOW();
mysql> SELECT NOW();SELECT USER();
mysql> SELECT NOW(), USER(), VERSION();
mysql> SHOW PROCESSLIST


#Example 4
#R에서 MySQL에 접속하여 데이터베이스 사용하기

#install.packages("RMySQL")
library("RMySQL")
con <- dbConnect(dbDriver("MySQL"), host = "localhost", dbname = "
sampdb", user = "root", password = "root")
dbGetQuery(con, "show tables;") # connect DB
sql <- "select * from student limit 10;"
sql <-
"select * from student
order by sex
limit 50;"
res <- dbGetQuery(con, sql) # save query result to an object named
as dat.jk.gj
res
dbDisconnect(con) # disconnet DB