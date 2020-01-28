#RHadoop ����4

#lec 22 �ǽ����� 1,2

#�ǽ� ����1 : ������ �ݺ� ��� �ܰ踦 �ۼ��غ�����.

str(iris)
Dat = as.matrix(scale(iris[,-5]))
fit <- kmeans( Dat, centers = 3) #3���� �������� kmeans ����ȭ
fit$cluster #�� �����Ͱ� � ������ ���ϴ���
fit$centers #3�� ������ �߽���(1~3��)
plot( Dat[, 1:2], col = fit$cluster, pch = 16 )
points( fit$centers[,1:2], pch = "+", cex = 5, col = "white" )
points( fit$centers[,1:2], pch = "+", cex = 3, col = 1:3 )

## ��Ŭ����� �Ÿ� �Լ�
dist.fun <- function(Center, Dat) apply(Center, 1, function(x) colSums((t(Dat)-x)^2))
Dat = as.matrix(scale(iris[,-5])) #������
num.clusters = 3 #���� ����
C = NULL #���� �߽��� �ʱ�ȭ
cluster <- sample(1:num.clusters, nrow(Dat), replace = TRUE); cluster #�ʱⱺ�� ���� ����

#iterate updating steps until convergence
maxNum <- 10 #�ִ� �ݺ� Ƚ��
cluster.mat <- matrix(nrow=maxNum, ncol=3) #���� �� ��Ʈ���� ����
cluster.mat[1,] <- as.vector(table(cluster))

for (i in 2:maxNum) {
  res <- aggregate( x=cbind(Dat), by=list(cluster), FUN=mean ) #���� �߽��� ���
  C <- res[,-1] #���� �߽��� ������Ʈ
  D <- dist.fun(C, Dat) #�� �߽������κ��� �Ÿ� ��� 
  cluster <- max.col(-D) #update group index with a group minimizing distance
  cluster.mat[i,] <- as.vector(table(cluster))
  if ( cluster.mat[i-1,]==cluster.mat[i,] ) break #�з��� ������ ��ȭ�� ������ break
}
cluster.mat


#�ǽ� ����2 : R�ϵ��� ����ؼ� �м��� �Ϸ��� �� ��,
map(), reduce(), mapreduce() �Լ��� ��� �ۼ��ϸ� �Ǵ��� �������. 

#map() �Լ�
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

#reduce() �Լ�
kmeans.reduce <- function(k, P) keyval(k, t(as.matrix(apply(P, 2, sum))))

#First iteration
C = NULL
num.clusters = 3
DatMat = as.matrix(scale(iris[,-5])) #data
mr <- from.dfs(mapreduce(to.dfs(DatMat), map = kmeans.map)); mr$key
mr <- from.dfs(mapreduce(to.dfs(DatMat), map = kmeans.map, reduce = kmeans.reduce)); mr
C <- values(mr)[,-1]/values(mr)[,1]; C

#mapreduce() �Լ�
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

#������ �غ�
P = do.call(rbind, rep(list(matrix(rnorm(10, sd = 10), ncol=2)), 20)) 
    + matrix(rnorm(200), ncol =2)

#mapreduce �Լ� ���
kmeans.mr(to.dfs(P), num.clusters = 12, num.iter = 5, 
  combine = FALSE, in.memory.combine = FALSE)
