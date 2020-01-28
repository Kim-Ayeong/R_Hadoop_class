#10월2일

#lec 6 p.21
paste <-> strsplit 반대 개념
grep("[a,z]", letters) #a, z가 letters 중 어디에 들어가 있는지
txt <- c("arm","foot","lefroo", "bafoobar")
if(length(i <- grep("foo", txt))) #length=2, if(TRUE)
cat("’foo’ appears at least once in\n\t", txt, "\n")
i
txt[i]
(txtt <- paste(txt, txt, sep="."))
strsplit(x = txtt, split = "[.]")

d <- pdf(확률밀도함수)/pmf(확률질량함수)
p <- cdf(누적분포함수)
q <- quantile
r <- random 난수 생성

dnorm(-1); dnorm(1) #default값 : m=0, sd=1
dnorm(c(-1, 1))
pnorm(1.96)
qnorm(0.975)
rnorm(50, m=0, sd=1)

dat <- rnorm(1000)
xx <- seq(-3, 3, by = 0.1)
yy <- dnorm(xx)
hist(dat, freq = F, col = "grey50", main = "Histogram of a random sample from N(0,1)")
lines(xx, yy, col = 4, lwd = 3)

diff() : 차이
scale() : 표준화

boxplot(mtcars$mpg, pars = list(boxwex = 0.3),
col = colors()[10], border = 4)
yy <- summary(mtcars$mpg); yy
xx <- rep(1.3, length(xx))
labels <- paste( names(yy), yy, sep = "=" )
text(x = xx[-4], y = yy[-4], labels = labels[-4])

state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
"qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
"sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
"sa", "act", "nsw", "vic", "vic", "act")
statef <- factor(state)
table(statef)

attach()  #search path에 경로 붙이기, 변수 이름과 충돌 주의
detach()  #attach와 항상 함께 사용

#lec7
#p.26 Word Count 예제
infile <- "ullyses.txt"
dat <- readLines(infile, n = 100)
words <- unlist(strsplit(dat, split = "[[:space:][:punct:]]"))
words <- tolower(words)
words[grep(pattern = "[0-9]", x = words)]
words[grep(pattern = "\\d", x = words)]
words <- gsub("[0-9]", "", words)
words <- words[words != ""]
wordcount <- table(words)
wordcount

#간단한 예1
cat("abcdef\nghijk")    #줄바꿈
cat('abcdef\rghijk')    #처음으로 return
cat('abcdef\bghijk')    #한칸 앞으로
cat('abcdef\ng\'hijk')  #'문자 그대로
#cat('abcdef\ng'hijk')  #''사이에 '사용은 에러
cat("abcdef\ng'hijk")   #""사이에 '사용은 에러X, 반대도 마찬가지

#간단한 예2
(string <- c("8'sdf", "abc*dfg", "iloveyou"))
grep( pattern = '\'', x = string, value = TRUE)
#grep( pattern = ''', x = string, value = TRUE)  #에러
grep( pattern = "'", x = string, value = TRUE)   #에러X
grep( pattern = "\'", x = string, value = TRUE)
gsub( pattern = "\'", replacement = "*", x = c("8'sdf", "dfds")) #바꾸기

#gsub( pattern = "\*", replacement = "+", x = string) #에러
gsub( pattern = "\\*", replacement = "+", x = string) #\\와 이스케이프 시퀀스 혼동 주의

(strings <- c("a", "ab", "acb", "accb", "acccb", "accccb"))
grep("ac*b", strings, value = TRUE)  	#* : 0번 이상
grep("ac+b", strings, value = TRUE)  	#+ : 1번 이상
grep("ac?b", strings, value = TRUE)  	#? : 0번 또는 1번
grep("ac{2}b", strings, value = TRUE)  	#2번 반복
grep("ac{2,}b", strings, value = TRUE)  	#2번 이상 반복
grep("ac{2,3}b", strings, value = TRUE)  	#2번 또는 3번 반복


(strings <- c("abcd", "cdab", "cabd", "c abd"))
grep("ab", strings, value = TRUE) 		#ab가 있는 문자열 출력
grep("^ab", strings, value = TRUE) 		#ab로 시작하는
grep("ab$", strings, value = TRUE) 		#ab로 끝나는
grep("\\bab", strings, value = TRUE) 	#ab 앞에 스페이스가 있는
grep("ab\\b", strings, value = TRUE) 	#ab 뒤에 스페이스가 있는
grep("\\Bab", strings, value = TRUE) 	#


(strings <- c("^ab", "a", "ab", "abc", "abd", "abe", "ab 12", "ab 123"))
grep(pattern = "ab.", x = strings, value = TRUE) 	#ab 다음 무었이든 있는
grep(pattern = "^ab.*", x = strings, value = TRUE) 	#ab로 시작하고 다음에 무엇이든 있는
grep(pattern = "^ab*", strings, value = TRUE) 		#a로 시작하고 b가 0번 이상 반복

grep("ab[c-e]", strings, value = TRUE) 	#ab 다음에 c-e
grep("ab[^c]", strings, value = TRUE) 	#ab 다음에 c가 나오면 x
grep("^ab", strings, value = TRUE)
grep("\\^ab", strings, value = TRUE)
grep("abc|abd", strings, value = TRUE)

grep(pattern = "(ab) 12", x = strings, value = TRUE)
grep(pattern = "ab 12", x = strings, value = TRUE)
gsub(pattern = "(ab) 12", replacement = "ab 34", x = strings)
gsub(pattern = "(ab) 12", replacement = "\\1 34", x = strings)
gsub(pattern = "ab 12", replacement = "\\1 34", x = strings)

#~p.16



