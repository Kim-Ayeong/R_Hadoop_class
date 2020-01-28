#9��12��

x <- c(1, 2, 3)
x1 <- c(1L, 2L, 3L)
y <- c(TRUE, TRUE, FALSE, FALSE)
z <- c("Sarah", "Tracy", "Jon")
typeof(z)
length(z)
class(z)
str(z) #����
typeof(x); mode(x); class(x) # what is the difference?
typeof(x1); mode(x1); class(x1) # what is the difference?
#type�� mode������ ���������� �ʴ� �ڷ������� ������
#numeric�� integer, double�� �������� X

#is.vector ���� is.atomic(x)�̳� is.list(x)�� ����
x <- c("1", "2")
is.vector(x)
attributes(x) <- list(note="special")
x
is.vector(x) #FALSE, because it has an attribute
is.atomic(x) #��� ����

#��� ��ü���� ��Ʈ����Ʈ�� �ο��� �� �ִ�.
y <- 1:10
attr(y, "my attribute") <- "This is a vector"
attr(y, "my attribute")
str(attributes(y))
#������ �ϸ� ��Ʈ����Ʈ ������ �����
#Name, Dimensions, Class�� ������ �ص� ������� �ʴ� ��Ʈ����Ʈ!

#�Լ� ���� ���
vector() #logical ���Ͱ� ������
vector("character",length=5)
character(5)
numeric(5)
logical(5)

#��� ������ ����
1:10
seq(10)
seq( from = 1, to = 10, by = 1)
seq( 1, 10, 1)
rev( seq( 10, 1, -1) ) #rev() : reverse the order
seq( from = 1, to = 10, length = 10)

rep(x = 1:10, each = 2) #������ ��Ҹ� 2�� �ݺ�
rep(x = 1:10, times = 3) #��ü�� 3�� �ݺ�

x <- c(0.5, NA, 0.7); mode(x) #NA���� �־ �˾Ƽ� �� �ν���

x <- c(1, 2, NA)
is.na(x)
x[!is.na(x)] #�������� �����ϰ� ���
anyNA(x) #�������� �ϳ��� ������ TRUE

#Ÿ�Ժ� flexible : logical < integer < double < character
x <- c(1.7, "a"); mode(x)
x <- c(TRUE, 2); mode(x)
x <- c("a", TRUE); mode(x) #�� ������ �ڷ������� �ڵ� ��ȯ

sum(is.na(x)) #������ ����

x <- c(FALSE, FALSE, TRUE)
as.numeric(x) #���� ����ȯ
sum(x)
mean(x)
z <- 0:9; typeof(z)
digits <- as.character(z); typeof(digits)
d <- as.integer(digits)

x <- list(a1=1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x) #a1 �̸��� �ο��س����� ����
x <- list(list(list(list())))
str(x)
is.recursive(x) #�ݺ� ������ list �����ΰ�?, atomic�� �ݴ�

x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
typeof(x)
y <- unlist(x)
mode(y)

#matric�� atomic���Ϳ� dimension�� �ο��� �� < ��� ���� Ÿ���� ������ �־����
m <- matrix(nrow = 2, ncol = 2)
dim(m)
dim(m)[1] #����
class(m)
typeof(m) #���� Ȯ��

m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m <- matrix(1:6, 2, 3, byrow = F) #�Է¼��� ��ȯ
mm <- 1:10
dim(mm) <- c(2, 5) #��Ʈ������ ����

a <- matrix(1:6, ncol = 3, nrow = 2)
rownames(a) <- c("A", "B")
colnames(a) <- c("a", "b", "c")
nrow(a)
ncol(a)
rownames(a)
colnames(a)

x <- 1:3
y <- 10:12
cbind(x, y) #�� ���ϱ�
rbind(x, y) #�� ���ϱ�

mdat <- matrix(c(1, 2, 3, 11, 12, 13), nrow = 2, ncol = 3, byrow=TRUE)
mdat
mdat[2,3]
mdat[-2,-3]
mdat[1:2,3]
mdat[,2:3]
mdat[2:3] #ù��° ������ ���ʴ�� ������ �ο� > 123456��° �߿� 2,3��° ��� ���

str(matrix(1:3, ncol = 1)) #�� ���� ����
str(matrix(1:3, nrow = 1)) #�� ���� ����

#Data frame�� ���� ������ list���� ���� Ư���� ����
datf <- data.frame(x = 1:3, y = c("a", "b", "c"))
str(datf) #�Ӽ��� �ڵ����� Factor�� ����
names(datf); colnames(datf); rownames(datf)
dim(datf); ncol(datf); nrow(datf)

#lec3 ~p.39