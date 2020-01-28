#10�� 31��

#SQL
cmdâ > mysql -p -u root
��� root

#SQL ����
#�⺻ ������
mysql> SELECT NOW();
mysql> SELECT NOW();SELECT USER();
mysql> SELECT NOW(), USER(), VERSION();
mysql> SHOW PROCESSLIST;

#�����ͺ��̽� ����
mysql> SHOW DATABASES;
mysql> CREATE DATABASE sampdb;
mysql> SHOW DATABASES;
mysql> USE sampdb;
mysql> SELECT DATABASE();

#MYSQL���� ���̺� �����
#���1
CREATE TABLE tbl_name (column_specs);
#���2
CREATE TABLE president
(
last_name VARCHAR(15) NOT NULL, #���ڰ���=15, NULL ���X 
first_name VARCHAR(15) NOT NULL,
suffix VARCHAR(5) NULL,
city VARCHAR(20) NOT NULL,
state VARCHAR(2) NOT NULL,
birth DATE NOT NULL,
death DATE NULL
);
#C:\root\tmp\sampdb�� �̹� �����Ǿ� ����

#sampdb ���� �� ���̺� �����
mysql> USE sampdb;
mysql> SELECT DATABASE();

mysql> source C:/root/tmp/sampdb/create_president.sql;
#�Ǵ� cmdâ > % mysql sampdb < C:/root/tmp/sampdb/create_president.sql;

#Exercise 1 �����غ���

#���̺� ���� ����
mysql> SHOW TABLES;
mysql> DESCRIBE president;
mysql> DESC president;
mysql> EXPLAIN president;
mysql> SHOW COLUMNS FROM president;
mysql> SHOW FIELDS FROM president;
#mysql> DESCRIBE student sex ;

#���ο� �� ���� �߰��ϱ�

#���1
INSERT INTO tbl_name VALUES(value1,value2,...);
#���2
#student ���̺��� �� �߰�
mysql> INSERT INTO student VALUES('Kyle','M',NULL);
#grade event ���̺��� �� �߰�
mysql> INSERT INTO grade_event VALUES('2008-09-03','Q',NULL);
#������ �ѹ��� �߰�
mysql> INSERT INTO student VALUES('Avery','F',NULL),('Nathan','M', NULL);

#sampdb ����
mysql> USE sampdb;
mysql> SELECT DATABASE();

#�� �߰�
mysql> source C:/tmp/insert_president.sql;
#�Ǵ� cmd â > % mysql sampdb < c:/tmp/insert_president.sql;

#�����˻��ϱ�
#���1
SELECT what to retrieve
FROM table or tables
WHERE conditions that data must satisfy;
#���2
#���̺� ��ü ����
mysql> SELECT * FROM president;
#�ϳ��� �࿡�� �ϳ��� �÷� �˻�
mysql> SELECT birth FROM president WHERE last_name = 'Eisenhower';
#�÷��� � ������ �����ص� ��
mysql> SELECT name, sex, student_id FROM student;
mysql> SELECT name, student_id FROM student;

#Example 4 �����غ���
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
