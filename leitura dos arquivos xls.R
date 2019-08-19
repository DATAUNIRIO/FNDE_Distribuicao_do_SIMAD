##------------------------------------------------------------##
##    funcao para download de arquivos do excel do FNDE       ##
##                                                            ##
#     Alexandre Silva                                         ##
##    Steven Dutt-Ross                                        ##
##    UNIRIO                                                  ##
##------------------------------------------------------------##


library(readxl)
arquivo <-"C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/000000000002.xls"
dados<-read_excel(arquivo)

sequencial_entidade <- read_excel("FNDE Simas/000000000002.xls", 
                                 sheet = "RESULTADO DA PESQUISA", range = "b5:b5", 
                                 col_names = FALSE)

ano <- read_excel("FNDE Simas/000000000002.xls", 
                                  sheet = "RESULTADO DA PESQUISA", range = "b6:b6", 
                                  col_names = FALSE)

sequencial_entidade <- read_excel("FNDE Simas/000000000002.xls", 
                                  sheet = "RESULTADO DA PESQUISA", range = "b5:b5", 
                                  col_names = FALSE)

programa<- read_excel("FNDE Simas/000000000002.xls", 
                      sheet = "RESULTADO DA PESQUISA", range = "b7:b7", 
                      col_names = FALSE)


                           

dados<- read_excel("FNDE Simas/000000000002.xls", 
                      sheet = "RESULTADO DA PESQUISA", range = "a10:d270", 
                      col_names = TRUE)

nomes<-c("SERIE_ANO","OBJETO","CRITERIO","QTDE_OBJETO_ADQUIRIDO")
colnames(dados)<-nomes
names(dados)

#vendo se tem a mesma dimensao (os dois primeiros sao maiores que os dois ultimos)
teste_serie  <- dim(dados[is.na(dados$SERIE_ANO),])[1]
teste_objeto <- dim(dados[is.na(dados$OBJETO),])[1]
teste_criterio <- dim(dados[is.na(dados$CRITERIO),])[1]
teste_qtd  <- dim(dados[is.na(dados$QTDE_OBJETO_ADQUIRIDO),])[1]

teste_serie==teste_objeto
teste_serie==teste_criterio
teste_serie==teste_qtd
teste_objeto==teste_criterio
teste_objeto==teste_qtd
teste_criterio==teste_qtd

# refazendo o teste
teste_criterio <- dim(dados[is.na(dados$CRITERIO),])[1]
teste_qtd  <- dim(dados[is.na(dados$QTDE_OBJETO_ADQUIRIDO),])[1]
teste_criterio==teste_qtd


dadoscriterio<-dados[!is.na(dados$CRITERIO),]

DADOS<-c()

if (teste_criterio==teste_qtd) {
  DADOS<-bind_rows(DADOS,dadoscriterio)
} else {
  stop("O numero de linhas do criterio eh diferente da qtd de objetos adiquiridos")
}

# TESTE PARA VER SE O if ESTA FUNCIONANDO
# teste_qtd <-teste_qtd +1
# teste_criterio==teste_qtd

#######################################################
# outras duas funcoes
new_data <- dados %>% filter_all(any_vars(!is.na(.))) 
new_data2 <- new_data[-dim(new_data[,])[1],]

new_data3<-dados[complete.cases(dados), ]


#######################################################
new_data3<-dados[complete.cases(dados), ]

sequencial_entidade <- rep(sequencial_entidade,dim(new_data3[,])[1])
sequencial_entidade <- unlist(sequencial_entidade, use.names=FALSE)

DADOS<-bind_rows(DADOS,new_data3)







###################################################
# sum(is.na(DADOS20152$SÉRIE.ANO))
# sum(is.na(DADOS20152$CRITÉRIO))
# 
# DADOS20152<-DADOS2015
# 
# DADOS20152<-DADOS20152 %>% 
#   mutate(SERIE_ANO = replace(SERIE_ANO, sequencial_entidade==000000220087, SERIE_ANO2))  %>% 
#   mutate(CRITERIO = replace(CRITERIO, sequencial_entidade==000000220087, CRITERIO2))
# 
# library(tidyr)
# DADOS20152<-DADOS20152 %>% 
#   mutate(SÉRIE.ANO = replace_na(SÉRIE.ANO, S.c9.RIE.ANO))
# 
# apply(DADOS2015,1,
#       if (sequencial_entidade==000000220087){
#         SÉRIE.ANO<-S.c9.RIE.ANO
#         CRITÉRIO<-CRIT.c9.RIO
#       })
