#10��2��

#lec 6 p.21
paste <-> strsplit �ݴ� ����
grep("[a,z]", letters) #a, z�� letters �� ��� �� �ִ���
txt <- c("arm","foot","lefroo", "bafoobar")
if(length(i <- grep("foo", txt))) #length=2, if(TRUE)
cat("��foo�� appears at least once in\n\t", txt, "\n")
i
txt[i]
(txtt <- paste(txt, txt, sep="."))
strsplit(x = txtt, split = "[.]")

d <- pdf(Ȯ���е��Լ�)/pmf(Ȯ�������Լ�)
p <- cdf(���������Լ�)
q <- quantile
r <- random ���� ����

dnorm(-1); dnorm(1) #default�� : m=0, sd=1
dnorm(c(-1, 1))
pnorm(1.96)
qnorm(0.975)
rnorm(50, m=0, sd=1)

dat <- rnorm(1000)
xx <- seq(-3, 3, by = 0.1)
yy <- dnorm(xx)
hist(dat, freq = F, col = "grey50", main = "Histogram of a random sample from N(0,1)")
lines(xx, yy, col = 4, lwd = 3)

diff() : ����
scale() : ǥ��ȭ

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

attach()  #search path�� ��� ���̱�, ���� �̸��� �浹 ����
detach()  #attach�� �׻� �Բ� ���

#lec7
#p.26 Word Count ����
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

#������ ��1
cat("abcdef\nghijk")    #�ٹٲ�
cat('abcdef\rghijk')    #ó������ return
cat('abcdef\bghijk')    #��ĭ ������
cat('abcdef\ng\'hijk')  #'���� �״��
#cat('abcdef\ng'hijk')  #''���̿� '����� ����
cat("abcdef\ng'hijk")   #""���̿� '����� ����X, �ݴ뵵 ��������

#������ ��2
(string <- c("8'sdf", "abc*dfg", "iloveyou"))
grep( pattern = '\'', x = string, value = TRUE)
#grep( pattern = ''', x = string, value = TRUE)  #����
grep( pattern = "'", x = string, value = TRUE)   #����X
grep( pattern = "\'", x = string, value = TRUE)
gsub( pattern = "\'", replacement = "*", x = c("8'sdf", "dfds")) #�ٲٱ�

#gsub( pattern = "\*", replacement = "+", x = string) #����
gsub( pattern = "\\*", replacement = "+", x = string) #\\�� �̽������� ������ ȥ�� ����

(strings <- c("a", "ab", "acb", "accb", "acccb", "accccb"))
grep("ac*b", strings, value = TRUE)  	#* : 0�� �̻�
grep("ac+b", strings, value = TRUE)  	#+ : 1�� �̻�
grep("ac?b", strings, value = TRUE)  	#? : 0�� �Ǵ� 1��
grep("ac{2}b", strings, value = TRUE)  	#2�� �ݺ�
grep("ac{2,}b", strings, value = TRUE)  	#2�� �̻� �ݺ�
grep("ac{2,3}b", strings, value = TRUE)  	#2�� �Ǵ� 3�� �ݺ�


(strings <- c("abcd", "cdab", "cabd", "c abd"))
grep("ab", strings, value = TRUE) 		#ab�� �ִ� ���ڿ� ���
grep("^ab", strings, value = TRUE) 		#ab�� �����ϴ�
grep("ab$", strings, value = TRUE) 		#ab�� ������
grep("\\bab", strings, value = TRUE) 	#ab �տ� �����̽��� �ִ�
grep("ab\\b", strings, value = TRUE) 	#ab �ڿ� �����̽��� �ִ�
grep("\\Bab", strings, value = TRUE) 	#


(strings <- c("^ab", "a", "ab", "abc", "abd", "abe", "ab 12", "ab 123"))
grep(pattern = "ab.", x = strings, value = TRUE) 	#ab ���� �����̵� �ִ�
grep(pattern = "^ab.*", x = strings, value = TRUE) 	#ab�� �����ϰ� ������ �����̵� �ִ�
grep(pattern = "^ab*", strings, value = TRUE) 		#a�� �����ϰ� b�� 0�� �̻� �ݺ�

grep("ab[c-e]", strings, value = TRUE) 	#ab ������ c-e
grep("ab[^c]", strings, value = TRUE) 	#ab ������ c�� ������ x
grep("^ab", strings, value = TRUE)
grep("\\^ab", strings, value = TRUE)
grep("abc|abd", strings, value = TRUE)

grep(pattern = "(ab) 12", x = strings, value = TRUE)
grep(pattern = "ab 12", x = strings, value = TRUE)
gsub(pattern = "(ab) 12", replacement = "ab 34", x = strings)
gsub(pattern = "(ab) 12", replacement = "\\1 34", x = strings)
gsub(pattern = "ab 12", replacement = "\\1 34", x = strings)

#~p.16


