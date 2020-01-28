#install.packages("RMySQL")
library("RMySQL")

con <- dbConnect(dbDriver("MySQL"), host = "localhost", dbname = "sampdb", user = "root", password = "suNS@%14")
dbGetQuery(con, "show tables;") # connect DB
sql <- "select * from student limit 10;"
sql <- 
"select * from student 
order by sex
limit 50;"
res <- dbGetQuery(con, sql) # save query result to an object named as dat.jk.gj
res
dbDisconnect(con) # disconnet DB


