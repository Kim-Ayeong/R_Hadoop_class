#10�� 30��

#R ����
R.Version()$version.string
library("devtools", "roxygen2")
getwd()
dir()
system("R CMD SHLIB convolve.c") #compile C code
dir() 				   #dll ���� Ȯ��
dyn.load("convolve.dll")


#SQL ��ġ(��ȣ ������ ����)
#�ý��� ȯ�� ���� path �߰�

cmdâ > mysql -p -u root
��� root

#SQL �����غ���
mysql> SELECT NOW();
mysql> SELECT NOW();SELECT USER();
mysql> SELECT NOW(), USER(), VERSION();
mysql> SHOW PROCESSLIST


#Example 4
#R���� MySQL�� �����Ͽ� �����ͺ��̽� ����ϱ�

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