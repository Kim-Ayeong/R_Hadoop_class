#10월 17일

#R 패키지 만들기
1. R 최신버전(3.5.1)을 업데이트
2. 윈도우 환경변수에 R경로 추가(블로그 참고)
CMD > PATH C:\Program Files\R\R-3.5.1\bin
CMD > R
3. Rtools 설치
  1)Rtools35.exe 파일 다운
  2)R packages “devtools”,“roxygen” 설치
  install.packages(c("devtools", "roxygen2"))
  3)Miktex $X
  basic-miktex-2.9.6850-x64.exe 파일 다운
4. R 패키지 구조
KernSmooth_2.23-15.tar.gz 파일 다운
#KernSmooth.zip 파일 다운

#패키지 안에 반드시 포함해야할 파일&폴더
① man : help
② R : R 함수
③ DESCRIPTION : 간단한 설명
④ NAMESPACE
그외 data(이용해볼 자료가 있으면), src, test, exec, inst 등 필요한 디렉토리 만들기

#튜토리얼 따라하기(simpack 파일 참고)
 : 패키지 다운 > 압축 풀기 > 경로 설정 > 다시 패키지화

export(simfun)
simfun <- function( n ){
  for(i in 1:n) {
    cat( "Welcome to Bigdata Analytics!\n" )
  }
}
R CMD check simpack
R CMD build simpack #다시 패키지화
R CMD INSTALL filename
library(simpack)
simfun(5)