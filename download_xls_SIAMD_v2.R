##------------------------------------------------------------##
##    funcao para download de arquivos do excel do FNDE       ##
##                                                            ##
#     Alexandre Silva                                         ##
##    Steven Dutt-Ross                                        ##
##    UNIRIO                                                  ##
##------------------------------------------------------------##

library(readr)
resultado <- read_csv("~/DIRETORIO DE TRABALHO DO R/FNDE Simas/resultado2016.txt", 
                      col_names = FALSE)
#View(resultado)

setwd("C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/2016/")
local<-"C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/2016/"

numeroEntidade<-resultado$X2
head(numeroEntidade)
length(numeroEntidade)
remove(resultado)

Parte1<-'https://www.fnde.gov.br/distribuicaosimadnet/criarArquivoExcelDistribuicao?numeroEntidade='
# 346764
Parte2<-'&anoPrograma='
ano=2016
Parte3<-'&codigoPrograma=01&ufSelecionada=RJ&criterios='

#numeroEntidade2<-numeroEntidade
numeroEntidade2<-numeroEntidade[113526:119385]
length(numeroEntidade2)
numeroEntidade2[1]


for (i in numeroEntidade2) {
  url <- paste0(Parte1,i,Parte2,ano,Parte3)
  local2<-paste0(local,i,".xls")
  Sys.sleep(2)
  ##Download the file
  download.file(url, local2, mode="wb")  
  print(i)
}  


