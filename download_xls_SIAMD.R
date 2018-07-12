##------------------------------------------------------------##
##    funcao para download de arquivos do excel do FNDE       ##
##                                                            ##
#     Alexandre Silva                                         ##
##    Steven Dutt-Ross                                        ##
##    UNIRIO                                                  ##
##------------------------------------------------------------##


# Codigo<-SIMAD$Cod_da_Escola
# Codigo<-c(33105065,33062340,33100659)
# 
# n_paginas<-43
# tableFNDE <- c()
# 
# 
# 
# #for (i in 1:14895) {
# for (i in 1:3) {
#   url <- paste0(Parte1,Codigo[i],Parte2)
#   local2<-paste0(local,Codigo[i],".xls")
#   ##Download the file
#   download.file(url, local2, mode="wb")  
#   print(i)
# }  

setwd("C:/Users/Steven/Documents/DIRETORIO DE TRABALHO DO R/Fabio/")
local<-"C:/Users/Steven/Documents/DIRETORIO DE TRABALHO DO R/Fabio/Fabio"

Parte1<-'https://www.fnde.gov.br/distribuicaosimadnet/criarArquivoExcelDistribuicao?numeroEntidade=000000'
# 346764
Parte2<-'&anoPrograma=2015&codigoPrograma=01&ufSelecionada=RJ&criterios='

for (i in 101280:110000) {
  url <- paste0(Parte1,i,Parte2)
  local2<-paste0(local,i,".xls")
  Sys.sleep(3)
  ##Download the file
  download.file(url, local2, mode="wb")  
  print(i)
}  


#library(xlsx)
#write.xlsx(tableFNDE2, "SIMAD_RJ.xlsx", sheetName="SIMAD_RJ")


# for(url in urls) {
#   split_url = strsplit(url, "/")[[1]]
#   ##Extract final part of URL
#   dir = split_url[length(split_url)]
#   ##Create a directory
#   dir.create(codigo)
#   ##Download the file
#   download.file(url, dir, mode="wb")
# }