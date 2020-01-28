#10월 31일

#SQL
cmd창 > mysql -p -u root
비번 root

#SQL 실행
#기본 쿼리문
mysql> SELECT NOW();
mysql> SELECT NOW();SELECT USER();
mysql> SELECT NOW(), USER(), VERSION();
mysql> SHOW PROCESSLIST;

#데이터베이스 생성
mysql> SHOW DATABASES;
mysql> CREATE DATABASE sampdb;
mysql> SHOW DATABASES;
mysql> USE sampdb;
mysql> SELECT DATABASE();

#MYSQL에서 테이블 만들기
#방법1
CREATE TABLE tbl_name (column_specs);
#방법2
CREATE TABLE president
(
last_name VARCHAR(15) NOT NULL, #문자공간=15, NULL 허용X 
first_name VARCHAR(15) NOT NULL,
suffix VARCHAR(5) NULL,
city VARCHAR(20) NOT NULL,
state VARCHAR(2) NOT NULL,
birth DATE NOT NULL,
death DATE NULL
);
#C:\root\tmp\sampdb에 이미 생성되어 있음

#sampdb 선택 후 테이블 만들기
mysql> USE sampdb;
mysql> SELECT DATABASE();

mysql> source C:/root/tmp/sampdb/create_president.sql;
#또는 cmd창 > % mysql sampdb < C:/root/tmp/sampdb/create_president.sql;

#Exercise 1 실행해보기

#테이블 구조 보기
mysql> SHOW TABLES;
mysql> DESCRIBE president;
mysql> DESC president;
mysql> EXPLAIN president;
mysql> SHOW COLUMNS FROM president;
mysql> SHOW FIELDS FROM president;
#mysql> DESCRIBE student sex ;

#새로운 행 직접 추가하기

#방법1
INSERT INTO tbl_name VALUES(value1,value2,...);
#방법2
#student 테이블에 행 추가
mysql> INSERT INTO student VALUES('Kyle','M',NULL);
#grade event 테이블에 행 추가
mysql> INSERT INTO grade_event VALUES('2008-09-03','Q',NULL);
#두행을 한번에 추가
mysql> INSERT INTO student VALUES('Avery','F',NULL),('Nathan','M', NULL);

#sampdb 선택
mysql> USE sampdb;
mysql> SELECT DATABASE();

#행 추가
mysql> source C:/tmp/insert_president.sql;
#또는 cmd 창 > % mysql sampdb < c:/tmp/insert_president.sql;

#정보검색하기
#방법1
SELECT what to retrieve
FROM table or tables
WHERE conditions that data must satisfy;
#방법2
#테이블 전체 내용
mysql> SELECT * FROM president;
#하나의 행에서 하나의 컬럼 검색
mysql> SELECT birth FROM president WHERE last_name = 'Eisenhower';
#컬럼은 어떤 순서로 지명해도 됨
mysql> SELECT name, sex, student_id FROM student;
mysql> SELECT name, student_id FROM student;

#Example 4 실행해보기
#install.packages("RMySQL")
library("RMySQL")
con <- dbConnect(dbDriver("MySQL"), host = "localhost", dbname = "sampdb", 
  user = "root", password = "root")
dbGetQuery(con, "show tables;") # connect DB
sql <- "select * from student limit 10;"
sql <-
"select * from student
order by sex
limit 50;"
res <- dbGetQuery(con, sql) # save query result to an object named as dat.jk.gj
res
dbDisconnect(con) # disconnet DB

