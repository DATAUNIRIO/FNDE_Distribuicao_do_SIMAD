##================================================================================================
##                                                                                              
##    Nome: Coleta de outras informacoes do FNDE via rvest                                          
##                                                    
##    prof. Alexandre Silva                          
##    prof. Steven Dutt-Ross                          
##    UNIRIO           
##================================================================================================


# library(rvest)
# library(dplyr)
# url <- "https://www.fnde.gov.br/distribuicaosimadnet/selecionar?numeroEntidade=000000191842&anoPrograma=2015&codigoPrograma=01&ufSelecionada=RJ&criterios="
# 
# FNDE1 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[1]') %>% html_text()
# FNDE2 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[2]') %>% html_text()
# FNDE3 <- url %>%
#   read_html(encoding = "UTF-8") %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[3]') %>% html_text()
# FNDE4 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[4]') %>% html_text()
# FNDE5 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[5]') %>% html_text()
# FNDE6 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[6]') %>% html_text()
# FNDE7 <- url %>%
#   read_html() %>%
#   html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[7]') %>% html_text()
# 
# FNDE1 <- gsub("\t","",FNDE1)
# FNDE1 <- gsub("\n","",FNDE1)
# 
# FNDE2 <- gsub("\t","",FNDE2)
# FNDE2 <- gsub("\n","",FNDE2)
# 
# FNDE3 <- gsub("\t","",FNDE3)
# FNDE3 <- gsub("\n","",FNDE3)
# 
# FNDE4 <- gsub("\t","",FNDE4)
# FNDE4 <- gsub("\n","",FNDE4)
# 
# FNDE5 <- gsub("\t","",FNDE5)
# FNDE5 <- gsub("\n","",FNDE5)
# 
# FNDE6 <- gsub("\t","",FNDE6)
# FNDE6 <- gsub("\n","",FNDE6)
# 
# FNDE7 <- gsub("\t","",FNDE7)
# FNDE7 <- gsub("\n","",FNDE7)
# 
# FNDE <- paste(FNDE1,FNDE2,FNDE3,FNDE4,FNDE5,FNDE6,FNDE7,sep = ",")
# FNDE <- paste(FNDE,FNDE,sep = ";")
#https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
#----------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------

local<-'C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/'
setwd(local)

library(readr)
resultado <- read_csv("C:/Users/Hp/Documents/GitHub/FNDE_Distribuicao_do_SIMAD/links/resultado2018.txt", 
                      col_names = FALSE)
#View(resultado)


numeroEntidade<-resultado$X2
tail(numeroEntidade)
length(numeroEntidade)
remove(resultado)

numeroEntidade2<-numeroEntidade
remove(numeroEntidade)
#numeroEntidade2<-numeroEntidade[113526:119385]
length(numeroEntidade2)
class(numeroEntidade2)
#numeroEntidade2<-numeroEntidade[112469:112469]
#numeroEntidade2<-sample(numeroEntidade2,3000)
#numeroEntidade2[51]<-as.character(000000346764)


library(rvest)
library(dplyr)

new_data <- c()
DADOS<-c()

for (i in numeroEntidade2) {
url <- paste0("https://www.fnde.gov.br/distribuicaosimadnet/selecionar?numeroEntidade=",i,
              "&anoPrograma=2018&codigoPrograma=01&ufSelecionada=RJ&criterios=")

FNDE1 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[1]') %>% html_text()
FNDE2 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[2]') %>% html_text()
FNDE3 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[3]') %>% html_text()
FNDE4 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[4]') %>% html_text()
FNDE5 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[5]') %>% html_text()
FNDE6 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[6]') %>% html_text()
FNDE7 <- url %>%
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath='//*[@id="pesquisar"]/div[1]/table/tbody/tr[7]') %>% html_text()

FNDE1 <- gsub("\t","",FNDE1)
FNDE1 <- gsub("\n","",FNDE1)
FNDE1 <- gsub("Nome da Entidade :","",FNDE1)
new_data$Entidade <-FNDE1

FNDE2 <- gsub("\t","",FNDE2)
FNDE2 <- gsub("\n","",FNDE2)
new_data$Endereco <-FNDE2
#FNDE2 <- strsplit(FNDE2, ",")

FNDE3 <- gsub("\t","",FNDE3)
FNDE3 <- gsub("\n","",FNDE3)
new_data$Municipio <-FNDE3

FNDE4 <- gsub("\t","",FNDE4)
FNDE4 <- gsub("\n","",FNDE4)
new_data$CEP <-FNDE4

FNDE5 <- gsub("\t","",FNDE5)
FNDE5 <- gsub("\n","",FNDE5)
new_data$Origem <-FNDE5

FNDE6 <- gsub("\t","",FNDE6)
FNDE6 <- gsub("\n","",FNDE6)
new_data$Ano <-FNDE6

FNDE7 <- gsub("\t","",FNDE7)
FNDE7 <- gsub("\n","",FNDE7)
new_data$Programa <-FNDE7

DADOS<- bind_rows(DADOS,new_data)
Sys.sleep(5)
}


#https://www.fnde.gov.br/distribuicaosimadnet/selecionar?numeroEntidade=000000346764&anoPrograma=2018&codigoPrograma=01&ufSelecionada=RJ&criterios=
#https://www.fnde.gov.br/distribuicaosimadnet/selecionar?numeroEntidade=000000191865&anoPrograma=2018&codigoPrograma=01&ufSelecionada=RJ&criterios=