#9월5일

getwd()
dir()
rm(list=ls())

(x <- c(1:10))
x[(x>8) | (x<5)]

a <- c(1,2,5.3,6,-2,4) #numeric vector
b <- c("one","two","three") #character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
mode(a)
mode(b)
mode(c)
tmp <- c(1, "one", TRUE)
mode(tmp)

?matrix
args(matrix)
y <- matrix(data=1:20, nrow=5, ncol=4)
cells <- c(1,26,24,68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE,
dimnames= list(rnames, cnames))

y
y[c(2, 4), 1]

d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(d,e,f)
names(mydata)
names(mydata) <- c("ID","Color","Passed")
mydata[,2]
mydata[c("ID","Age")]
mydata$ID 

w <? list(name="Fred", mynumbers=a, mymatrix=y, age=5.3)

