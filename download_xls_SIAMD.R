##------------------------------------------------------------##
##    funcao para download de arquivos do excel do FNDE       ##
##                                                            ##
#     Alexandre Silva                                         ##
##    Steven Dutt-Ross                                        ##
##    UNIRIO                                                  ##
##------------------------------------------------------------##

library(readr)
resultado <- read_csv("~/GitHub/FNDE_Distribuicao_do_SIMAD/resultado 18 06.txt", 
                      col_names = FALSE)
View(resultado)

setwd("C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/")
local<-"C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/"

numeroEntidade<-resultado$X2
head(numeroEntidade)
Parte1<-'https://www.fnde.gov.br/distribuicaosimadnet/criarArquivoExcelDistribuicao?numeroEntidade=000000'
# 346764
Parte2<-'&anoPrograma=2015&codigoPrograma=01&ufSelecionada=RJ&criterios='

for (i in numeroEntidade) {
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