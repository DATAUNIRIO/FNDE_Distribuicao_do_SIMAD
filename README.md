# FNDE_Distribuicao_do_SIMAD


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


# Check if URL exists
This functions is analogous to file.exists and determines whether a request for a specific URL responds without error. We make the request but ask the server not to return the body. We just process the header.

library(RCurl)  
url.exists("http://www.omegahat.net/RCurl")  
try(url.exists("http://www.omegahat.net/RCurl-xxx"))  
