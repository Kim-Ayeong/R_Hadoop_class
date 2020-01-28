#RHadoop 과제4

#lec 22 실습문제 1,2

#실습 문제1 : 위에서 반복 계산 단계를 작성해보세요.

str(iris)
Dat = as.matrix(scale(iris[,-5]))
fit <- kmeans( Dat, centers = 3) #3개의 군집으로 kmeans 군집화
fit$cluster #각 데이터가 어떤 군집에 속하는지
fit$centers #3개 군집의 중심점(1~3행)
plot( Dat[, 1:2], col = fit$cluster, pch = 16 )
points( fit$centers[,1:2], pch = "+", cex = 5, col = "white" )
points( fit$centers[,1:2], pch = "+", cex = 3, col = 1:3 )

## 유클리디언 거리 함수
dist.fun <- function(Center, Dat) apply(Center, 1, function(x) colSums((t(Dat)-x)^2))
Dat = as.matrix(scale(iris[,-5])) #데이터
num.clusters = 3 #군집 개수
C = NULL #군집 중심점 초기화
cluster <- sample(1:num.clusters, nrow(Dat), replace = TRUE); cluster #초기군집 랜덤 배정

#iterate updating steps until convergence
maxNum <- 10 #최대 반복 횟수
cluster.mat <- matrix(nrow=maxNum, ncol=3) #군집 비교 매트릭스 생성
cluster.mat[1,] <- as.vector(table(cluster))

for (i in 2:maxNum) {
  res <- aggregate( x=cbind(Dat), by=list(cluster), FUN=mean ) #군집 중심점 계산
  C <- res[,-1] #군집 중심점 업데이트
  D <- dist.fun(C, Dat) #각 중심점으로부터 거리 계산 
  cluster <- max.col(-D) #update group index with a group minimizing distance
  cluster.mat[i,] <- as.vector(table(cluster))
  if ( cluster.mat[i-1,]==cluster.mat[i,] ) break #분류된 군집에 변화가 없으면 break
}
cluster.mat


#실습 문제2 : R하둡을 사용해서 분석을 하려고 할 때,
map(), reduce(), mapreduce() 함수를 어떻게 작성하면 되는지 적어보세요. 

#map() 함수
kmeans.map <- function(., P) {
  nearest <- if(is.null(C)){
    sample(1:num.clusters, nrow(P), replace = TRUE)
  }
  else {
    D <- dist.fun(C, P)
    nearest <- max.col(-D)
  }
  keyval(nearest, cbind(1, P))
}

#reduce() 함수
kmeans.reduce <- function(k, P) keyval(k, t(as.matrix(apply(P, 2, sum))))

#First iteration
C = NULL
num.clusters = 3
DatMat = as.matrix(scale(iris[,-5])) #data
mr <- from.dfs(mapreduce(to.dfs(DatMat), map = kmeans.map)); mr$key
mr <- from.dfs(mapreduce(to.dfs(DatMat), map = kmeans.map, reduce = kmeans.reduce)); mr
C <- values(mr)[,-1]/values(mr)[,1]; C

#mapreduce() 함수
kmeans.mr <- function(P, num.clusters, num.iter, combine, in.memory.combine) {
  C = NULL
  for(i in 1:num.iter ) {
    C = values(from.dfs(
      mapreduce(P, map = kmeans.map, reduce = kmeans.reduce)))
    if(combine || in.memory.combine) C = C[,-1] / C[,1]
    if(nrow(C) < num.clusters) {
      C = rbind(C, matrix(rnorm((num.clusters - nrow(C)) * nrow(C)), 
          ncol = nrow(C)) %*% C)
    }
  }
  C
}

#데이터 준비
P = do.call(rbind, rep(list(matrix(rnorm(10, sd = 10), ncol=2)), 20)) 
    + matrix(rnorm(200), ncol =2)

#mapreduce 함수 사용
kmeans.mr(to.dfs(P), num.clusters = 12, num.iter = 5, 
  combine = FALSE, in.memory.combine = FALSE)

