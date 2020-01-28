#9월4일

# R=통계 계산, 그래픽화를 위한 언어(C 바탕)
# Quick-R에서 명령어 참고

x <- 1:10
x <- rnorm(n = 1000, mean = 0, sd = 1)
mean(x)
mean(
  x
) # +가 나오면 명령문이 아직 끝나지 않음
mean(x); sd(x)
mean(x)
sd(x) #위와 같음
for(i in 1:10){
  res = i*2
  print(res)
}
A <- 100
a <- -100
A; a
A == a
objects() #대소문자 구분
#p.22