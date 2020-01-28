#R/Hadoop ����

#Learning-By-Yourself
#Exercise 1
?factor
f1 <- factor(c("a","b")); f1; as.numeric(f1)
f2 <- factor(c("a","b"), labels = c("c","d")); f2; as.numeric(f2)
f3 <- factor(c("a","b"), levels = c("b","a")); f3; as.numeric(f3)
f4 <- factor(c("a","b"), levels = c("b","a"), labels = c("c","d")); f4; as.numeric(f4)
cbind(f1,f2,f3,f4)
ff <- f1
levels(ff) <- c("b", "a")
ff
par(mar=c(5,5,1,1))
n.lev <- length(levels(chickwts$feed)); n.lev
boxplot(chickwts$weight~chickwts$feed, col = colors()[c(1:n.lev)*10], xaxt = "n")
axis(side = 1, at = 1:6, labels = levels(chickwts$feed), col.axis = 4, las = 2)
box()

#1. ���� ���� boxplot�� �׸��µ� ���� chickwts �ڷḦ ������ ���ô�.
#1-1 chickwts ��ü�� R �ڷ��� ����(type) �� � ������ �ش��ϳ���?
class(chickwts)
typeof(chickwts)
#1-2 � �������� �ڷῡ ���ԵǾ� �ֳ���?
str(chickwts)
#1-3 ���̿� ������ feed ������ ����(level)�� ��̸� �� ������ �̸�(label)�� �����ΰ���?
length(levels(chickwts$feed))
levels(chickwts$feed)
#labels(chickwts$feed)

#2. ���� boxplot���� feed ������ ���ص�(levels)�� ���� weight ������ ������ �ϸ������ϰ� �� �����ؼ� �����ݴϴ�. 
#�׸��� x ���� �� ������ �̸��� ���� ���ĺ� ������ ���� ���ĵǾ� �ֽ��ϴ�.
#���� x ���� feed ������ ������ weight ������ �߾Ӱ��� ������������ �����Ͽ� �׸��� �׸��⸦ ���Ѵٸ�, ��� �ϸ� �ɱ��? 
#�ѹ� �Ʒ��� ���� �׸��� �׷�������
sort(tapply(chickwts$weight, chickwts$feed, median)) #���� Ȯ��
levelorder <- c("horsebean", "linseed", "soybean", "meatmeal", "sunflower", "casein")
chickwts$feed<-factor(chickwts$feed, levels=levelorder) #���� ������
par(mar=c(5,5,1,1))
n.lev <- length(levels(chickwts$feed)); n.lev
boxplot(chickwts$weight~chickwts$feed, col = colors()[c(1:n.lev)*10], xaxt = "n")
axis(side = 1, at = 1:6, labels = levels(chickwts$feed), col.axis = 4, las = 2)
box()

#Exercise 5
#1. ������ ����Ʈ���� https://www.r-bloggers.com/apply-lapply-rapply-sapply-functions-in-r ���� �а� �Ʒ��� �� �Լ��� ���� ������ ������.
#apply  (������, 1-����� 2-������, �����Լ�) : �� ��ҿ� �Լ��� �����Ű�� �⺻ �Լ�
#tapply (����� ����, �׷����� ����, �����Լ�) : table + apply, �׷캰 apply�� �� ������ �����ϰ� ���� ��
#sapply (������, �����Լ�) : simple + apply, lapply�� ����� ���ͳ� ��Ʈ������ ���
#lapply (������, �����Լ�) : list + apply, ����Ʈ �� ��ҿ� �Լ��� ������� ����Ʈ�� ���
#by	 (����� ���� ����, �׷����� ����, �����Լ�) : �׷캰 apply�� ���� ������ �����ϰ� ���� ��

#2. �� �Լ��� ������ ������ �� ã�� �������. (���� �ۿ� ���� ���� ����).
Age <- c(56,34,67,33,25,28)
Weight <- c(78,67,56,44,56,89)
Height <-c (165, 171,167,167,166,181) 
BMI_df<-data.frame(Age,Weight,Height)
BMI_df
apply(BMI_df, 1, sum)
apply(BMI_df, 2, sum)
lapply(BMI_df, mean)
sapply(BMI_df, mean)
#str(mtcars)
tapply(mtcars$wt, mtcars$cyl, mean)
by(mtcars[,5], mtcars$cyl, mean)

#3. tapply() �Լ��� hadoop�� MapReduce�� �����ϴµ� ������ �˴ϴ�.
#tapply() �Լ��� help file�� �а� �������� ���� ������ ������.

?tapply

require(stats)
groups <- as.factor(rbinom(32, n = 5, prob = 0.4))
tapply(groups, groups, length) #- is almost the same as
table(groups)

## contingency table from data.frame : array with named dimnames
tapply(warpbreaks$breaks, warpbreaks[,-1], sum)
tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)

n <- 17; fac <- factor(rep_len(1:3, n), levels = 1:5)
table(fac)
tapply(1:n, fac, sum)
tapply(1:n, fac, sum, default = 0) # maybe more desirable
tapply(1:n, fac, sum, simplify = FALSE)
tapply(1:n, fac, range)
tapply(1:n, fac, quantile)
tapply(1:n, fac, length) ## NA's
tapply(1:n, fac, length, default = 0) # == table(fac)

## example of ... argument: find quarterly means
tapply(presidents, cycle(presidents), mean, na.rm = TRUE)

ind <- list(c(1, 2, 2), c("A", "A", "B"))
table(ind)
tapply(1:3, ind) #-> the split vector
tapply(1:3, ind, sum)

## Some assertions (not held by all patch propsals):
nq <- names(quantile(1:5))
stopifnot(
  identical(tapply(1:3, ind), c(1L, 2L, 4L)),
  identical(tapply(1:3, ind, sum),
            matrix(c(1L, 2L, NA, 3L), 2, dimnames = list(c("1", "2"), c("A", "B")))),
  identical(tapply(1:n, fac, quantile)[-1],
            array(list(`2` = structure(c(2, 5.75, 9.5, 13.25, 17), .Names = nq),
                 `3` = structure(c(3, 6, 9, 12, 15), .Names = nq),
                 `4` = NULL, `5` = NULL), dim=4, dimnames=list(as.character(2:5)))))