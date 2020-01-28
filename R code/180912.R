#9월12일

x <- c(1, 2, 3)
x1 <- c(1L, 2L, 3L)
y <- c(TRUE, TRUE, FALSE, FALSE)
z <- c("Sarah", "Tracy", "Jon")
typeof(z)
length(z)
class(z)
str(z) #유용
typeof(x); mode(x); class(x) # what is the difference?
typeof(x1); mode(x1); class(x1) # what is the difference?
#type은 mode에서는 구분해주지 않는 자료형까지 보여줌
#numeric은 integer, double를 구분하지 X

#is.vector 보다 is.atomic(x)이나 is.list(x)를 권장
x <- c("1", "2")
is.vector(x)
attributes(x) <- list(note="special")
x
is.vector(x) #FALSE, because it has an attribute
is.atomic(x) #사용 권장

#모든 객체에는 애트리뷰트를 부여할 수 있다.
y <- 1:10
attr(y, "my attribute") <- "This is a vector"
attr(y, "my attribute")
str(attributes(y))
#연산을 하면 애트리뷰트 정보가 사라짐
#Name, Dimensions, Class는 연산을 해도 사라지지 않는 애트리뷰트!

#함수 생성 방법
vector() #logical 벡터가 생성됨
vector("character",length=5)
character(5)
numeric(5)
logical(5)

#모두 동일한 벡터
1:10
seq(10)
seq( from = 1, to = 10, by = 1)
seq( 1, 10, 1)
rev( seq( 10, 1, -1) ) #rev() : reverse the order
seq( from = 1, to = 10, length = 10)

rep(x = 1:10, each = 2) #각각의 요소를 2번 반복
rep(x = 1:10, times = 3) #전체를 3번 반복

x <- c(0.5, NA, 0.7); mode(x) #NA값이 있어도 알아서 잘 인식함

x <- c(1, 2, NA)
is.na(x)
x[!is.na(x)] #결측값을 제외하고 출력
anyNA(x) #결측값이 하나라도 있으면 TRUE

#타입별 flexible : logical < integer < double < character
x <- c(1.7, "a"); mode(x)
x <- c(TRUE, 2); mode(x)
x <- c("a", TRUE); mode(x) #더 유연한 자료형으로 자동 변환

sum(is.na(x)) #결측값 개수

x <- c(FALSE, FALSE, TRUE)
as.numeric(x) #강제 형변환
sum(x)
mean(x)
z <- 0:9; typeof(z)
digits <- as.character(z); typeof(digits)
d <- as.integer(digits)

x <- list(a1=1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x) #a1 이름을 부여해놓으면 편리
x <- list(list(list(list())))
str(x)
is.recursive(x) #반복 가능한 list 형태인가?, atomic의 반대

x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
typeof(x)
y <- unlist(x)
mode(y)

#matric는 atomic벡터에 dimension을 부여한 것 < 모두 같은 타입을 가지고 있어야함
m <- matrix(nrow = 2, ncol = 2)
dim(m)
dim(m)[1] #가능
class(m)
typeof(m) #형태 확인

m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m <- matrix(1:6, 2, 3, byrow = F) #입력순서 전환
mm <- 1:10
dim(mm) <- c(2, 5) #매트릭스로 분할

a <- matrix(1:6, ncol = 3, nrow = 2)
rownames(a) <- c("A", "B")
colnames(a) <- c("a", "b", "c")
nrow(a)
ncol(a)
rownames(a)
colnames(a)

x <- 1:3
y <- 10:12
cbind(x, y) #열 더하기
rbind(x, y) #행 더하기

mdat <- matrix(c(1, 2, 3, 11, 12, 13), nrow = 2, ncol = 3, byrow=TRUE)
mdat
mdat[2,3]
mdat[-2,-3]
mdat[1:2,3]
mdat[,2:3]
mdat[2:3] #첫번째 열부터 차례대로 순서를 부여 > 123456번째 중에 2,3번째 요소 출력

str(matrix(1:3, ncol = 1)) #열 벡터 생성
str(matrix(1:3, nrow = 1)) #행 벡터 생성

#Data frame은 같은 길이의 list끼리 묶은 특별한 형태
datf <- data.frame(x = 1:3, y = c("a", "b", "c"))
str(datf) #속성에 자동으로 Factor를 적용
names(datf); colnames(datf); rownames(datf)
dim(datf); ncol(datf); nrow(datf)

#lec3 ~p.39