#10�� 17��

#R ��Ű�� �����
1. R �ֽŹ���(3.5.1)�� ������Ʈ
2. ������ ȯ�溯���� R��� �߰�(���α� ����)
CMD > PATH C:\Program Files\R\R-3.5.1\bin
CMD > R
3. Rtools ��ġ
  1)Rtools35.exe ���� �ٿ�
  2)R packages ��devtools��,��roxygen�� ��ġ
  install.packages(c("devtools", "roxygen2"))
  3)Miktex $X
  basic-miktex-2.9.6850-x64.exe ���� �ٿ�
4. R ��Ű�� ����
KernSmooth_2.23-15.tar.gz ���� �ٿ�
#KernSmooth.zip ���� �ٿ�

#��Ű�� �ȿ� �ݵ�� �����ؾ��� ����&����
�� man : help
�� R : R �Լ�
�� DESCRIPTION : ������ ����
�� NAMESPACE
�׿� data(�̿��غ� �ڷᰡ ������), src, test, exec, inst �� �ʿ��� ���丮 �����

#Ʃ�丮�� �����ϱ�(simpack ���� ����)
 : ��Ű�� �ٿ� > ���� Ǯ�� > ��� ���� > �ٽ� ��Ű��ȭ

export(simfun)
simfun <- function( n ){
  for(i in 1:n) {
    cat( "Welcome to Bigdata Analytics!\n" )
  }
}
R CMD check simpack
R CMD build simpack #�ٽ� ��Ű��ȭ
R CMD INSTALL filename
library(simpack)
simfun(5)