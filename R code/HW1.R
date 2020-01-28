#R/Hadoop 과제

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

#1. 먼저 위의 boxplot을 그리는데 사용된 chickwts 자료를 이해해 봅시다.
#1-1 chickwts 객체는 R 자료의 종류(type) 중 어떤 종류에 해당하나요?
class(chickwts)
typeof(chickwts)
#1-2 어떤 변수들이 자료에 포함되어 있나요?
str(chickwts)
#1-3 먹이와 연관된 feed 변수의 수준(level)은 몇개이며 각 수준의 이름(label)은 무엇인가요?
length(levels(chickwts$feed))
levels(chickwts$feed)
#labels(chickwts$feed)

#2. 위의 boxplot에는 feed 변수의 수준들(levels)에 따라 weight 변수의 분포를 일목정연하게 잘 정리해서 보여줍니다. 
#그림의 x 축의 각 수준의 이름은 영어 알파벳 순서에 따라 정렬되어 있습니다.
#만약 x 축의 feed 변수의 순서를 weight 분포의 중앙값의 오른차순으로 변경하여 그림을 그리기를 원한다면, 어떻게 하면 될까요? 
#한번 아래와 같이 그림을 그려보세요
sort(tapply(chickwts$weight, chickwts$feed, median)) #순서 확인
levelorder <- c("horsebean", "linseed", "soybean", "meatmeal", "sunflower", "casein")
chickwts$feed<-factor(chickwts$feed, levels=levelorder) #범주 재정의
par(mar=c(5,5,1,1))
n.lev <- length(levels(chickwts$feed)); n.lev
boxplot(chickwts$weight~chickwts$feed, col = colors()[c(1:n.lev)*10], xaxt = "n")
axis(side = 1, at = 1:6, labels = levels(chickwts$feed), col.axis = 4, las = 2)
box()

#Exercise 5
#1. 다음의 사이트에서 https://www.r-bloggers.com/apply-lapply-rapply-sapply-functions-in-r 글을 읽고 아래의 각 함수에 대해 이해해 보세요.
#apply  (데이터, 1-행단위 2-열단위, 적용함수) : 각 요소에 함수를 적용시키는 기본 함수
#tapply (계산할 변수, 그룹지을 변수, 적용함수) : table + apply, 그룹별 apply를 한 변수에 적용하고 싶을 때
#sapply (데이터, 적용함수) : simple + apply, lapply의 결과를 벡터나 매트릭스로 출력
#lapply (데이터, 적용함수) : list + apply, 리스트 각 요소에 함수를 적용시켜 리스트로 출력
#by	 (계산할 여러 변수, 그룹지을 변수, 적용함수) : 그룹별 apply를 여러 변수에 적용하고 싶을 때

#2. 각 함수를 적용한 적절한 예 찾아 적어보세요. (위의 글에 사용된 예는 제외).
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

#3. tapply() 함수는 hadoop의 MapReduce를 이해하는데 도움이 됩니다.
#tapply() 함수의 help file을 읽고 예제들을 따라서 실행해 보세요.

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
