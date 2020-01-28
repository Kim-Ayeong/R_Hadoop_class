#RHadoop ����3

#lec 20 �ǽ����� 1,2

dat <- mtcars[c("mpg","cyl","wt")] # mtcars���� mpg, cyl, wt ������ ������������ ������ �ڷḦ ������ dat ��ü ����
str(dat) # dat �ڷ� ����
dat$cyl <- as.factor(dat$cyl) # numeric ������ cyl ������ ����(������ �ڷ�)�� ��ȯ
# pair plot
pairs(dat, col = 4, pch = 16, cex = 1.5, panel = panel.smooth, lower.panel = NULL)

fit <- lm( formula = mpg ~ cyl + wt, data = dat ) # ���߼���ȸ�͸��� ����
summary(fit) # ���� ���1, ������ cyl6, cyl8�� ����� ���������� cyl�� ǥ�� 
anova(fit) # ���� ���2: ANOVA Table

f.val <- ((824.78+118.20)/(3))/(183.06/28); f.val
pf( f.val, 3, 28, lower.tail = FALSE)



#�ǽ� ����1 : ���� ����� R�� ����ؼ� ���� ����غ�����.

X <- model.matrix(fit) #������ ��� ����
head(X,10) # ������ cyl6, cyl8�� ������ ������ ��ķ� �ùٸ��� ǥ����
class(X)
str(X)

#�л�м�
Y <- as.matrix(mtcars["mpg"])
beta <- qr.coef(qr(X), Y) #ȸ�Ͱ�� ����
SSE <- t(Y-(X%*%beta))%*%(Y-(X%*%beta)) #���� ������(SSE)
m <- mean(Y)
SST <- t(Y-m)%*%(Y-m) #�� ������(SST)
SSR <- t((X%*%beta)-m)%*%((X%*%beta)-m) #ȸ�� ������(SSR)
c(SST-SSE, SSR) #Ȯ��

#�л�м�ǥ �ۼ�
result <- data.frame("����" = c("ȸ��", "����", "��ü"), 
  "������" = rep(0,3), "������" = rep(0,3),
  "�������" = rep(0,3), "F��" = rep(0,3))
result$������[1] <- 3 #cyl:2, wt:1
result$������[3] <- nrow(dat)-1
result$������[2] <- result$������[3]-result$������[1]
result$������ <- c(SSR, SSE, SST)
result$�������[1:2] <- result$������[1:2]/result$������[1:2]
result$F��[1] <- result$�������[1]/result$�������[2]
result

R2 <- SSR/SST; R2 #�������
Adj.R2 <- 1-(result$�������[2]/(result$������[3]/result$������[3])); Adj.R2 #������ �������
Resi <- sqrt(result$�������[2]); Resi #Residual standard error

#F ����
pf(result$F��[1], result$������[1], result$������[2], lower.tail = FALSE)
#lm()�� ������ ���� ����


#�ǽ� ����2 : R�ϵ��� ����ؼ� �м��� �Ϸ��� �� ��, 
map(), reduce(), mapreduce() �Լ��� ��� �ۼ��ϸ� �Ǵ��� �������. 

library(rJava)
library(rmr2)
library(rhdfs)
hdfs.init()

#ù��° map �Լ� ,t(X)*X ���
mr.map1 <- function(., Xr){
  Xr <- Xr[,-1]
  keyval(1, list(t(Xr) %*% Xr))
}

#reduce �Լ�
mr.reduce <- function(., A){
  keyval(1, list(Reduce('+', A)))
}

#�ι�° map �Լ�, t(X)*Y ���
mr.map2 <- function(., Xr){
  Yr <- Xr[,1]
  Xr <- Xr[,-1]
  keyval(1, list(t(Xr) %*% Yr))
}

#mapreduce �Լ�
X1 <- to.dfs(table) #HDFS �� table ������ �ҷ�����
XtX <- values( from.dfs(
  mapreduce( input=X1, map=mr.map, reduce=mr.reduce, combine=T)))[[1]] #t(X)*X ���
Xty <- values( from.dfs(
  mapreduce( input=X1, map=mr.map2, reduce=mr.reduce, combine=T)))[[1]] #t(X)*Y ���

#ȸ�Ͱ�� ����
beta <- solve(XtX, Xty)






