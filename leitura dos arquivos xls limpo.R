##------------------------------------------------------------##
##    funcao para juntar todos os arquivos do excel           ##
##                                                            ##
#     Alexandre Silva                                         ##
##    Steven Dutt-Ross                                        ##
##    UNIRIO                                                  ##
##------------------------------------------------------------##




#library(readxl)

# arquivo <-"C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/000000000002.xls"
# 
# sequencial_entidade <- read_excel("FNDE Simas/000000000002.xls", 
#                                  sheet = "RESULTADO DA PESQUISA", range = "b5:b5", 
#                                  col_names = FALSE)
# 
# ano <- read_excel("FNDE Simas/000000000002.xls", 
#                                   sheet = "RESULTADO DA PESQUISA", range = "b6:b6", 
#                                   col_names = FALSE)
# 
# programa<- read_excel("FNDE Simas/000000000002.xls", 
#                       sheet = "RESULTADO DA PESQUISA", range = "b7:b7", 
#                       col_names = FALSE)
# 
# 
# dados<- read_excel("FNDE Simas/000000000002.xls", 
#                       sheet = "RESULTADO DA PESQUISA", range = "a10:d270", 
#                       col_names = TRUE)
# 
# nomes<-c("SERIE_ANO","OBJETO","CRITERIO","QTDE_OBJETO_ADQUIRIDO")
# colnames(dados)<-nomes
# names(dados)
# 
# #######################################################
# new_data<-dados[complete.cases(dados), ]
# 
# sequencial_entidade <- rep(sequencial_entidade,dim(new_data[,])[1])
# sequencial_entidade <- unlist(sequencial_entidade, use.names=FALSE)
# 
# ano <- rep(ano,dim(new_data[,])[1])
# ano <- unlist(ano, use.names=FALSE)
# 
# programa <- rep(programa,dim(new_data[,])[1])
# programa <- unlist(programa, use.names=FALSE)
# 
# new_data2<-data.frame(sequencial_entidade,ano,programa,new_data,stringsAsFactors = TRUE)
# 
# DADOS<-c()
# 
# DADOS<-bind_rows(DADOS,new_data)

###########################################################


library(readxl)
library(dplyr)
DADOS<-c()
nomes<-c("SERIE_ANO","OBJETO","CRITERIO","QTDE_OBJETO_ADQUIRIDO")

local<-'C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/'
ano<-'2018/'
setwd(paste0(local,ano))
getwd()

filenames <- list.files(pattern=".xls", full.names=TRUE)
filenames[1]
length(filenames)

for (i in filenames) {
  ################################################################
  # Leitura
  ################################################################
  sequencial_entidade <- read_excel(paste0(i), 
                                    sheet = "RESULTADO DA PESQUISA", range = "b5:b5", 
                                    col_names = FALSE)
  ano <- read_excel(paste0(i), 
                    sheet = "RESULTADO DA PESQUISA", range = "b6:b6", 
                    col_names = FALSE)
  
  programa<- read_excel(paste0(i), 
                        sheet = "RESULTADO DA PESQUISA", range = "b7:b7", 
                        col_names = FALSE)
  
  
  dados<- read_excel(paste0(i), 
                     sheet = "RESULTADO DA PESQUISA", range = "a10:d270", 
                     col_names = TRUE)
  colnames(dados)<-nomes
  
  ################################################################
  #Tratamento
  ################################################################
  new_data<-dados[complete.cases(dados), ]
  
  sequencial_entidade <- rep(sequencial_entidade,dim(new_data[,])[1])
  sequencial_entidade <- unlist(sequencial_entidade, use.names=FALSE)
  
  ano <- rep(ano,dim(new_data[,])[1])
  ano <- unlist(ano, use.names=FALSE)
  
  programa <- rep(programa,dim(new_data[,])[1])
  programa <- unlist(programa, use.names=FALSE)
  
  # Merge das colunas e depois dos casos (append)
  new_data2<-data.frame(sequencial_entidade,ano,programa,new_data,stringsAsFactors = TRUE)
  DADOS<-bind_rows(DADOS,  new_data2)
  
}

##########################################


tail(DADOS)
DADOS2018<-DADOS
remove(DADOS)

local<-'C:/Users/Hp/Documents/DIRETORIO DE TRABALHO DO R/FNDE Simas/'
setwd(local)
save(DADOS2018,file = 'DADOS2018.RData')
write.csv(DADOS2018,file = 'DADOS2018.csv')


# no banco de 2015 tem um problema de enconding
# isso acontece exatamente onde o sequencial_entidade==000000220087
# o arquivo estava corrompido e tive que "reparar" no excel
# assim a funcao for criou novas variaveis (novas colunas) e
# não fez o enconding direito
# exemplo criterio = CI<ca>NCIAS SABER E FAZER

# no banco de 2016 os arquivos 000000064976.xls  000000256996.xls 000000270714.xls
#estao corrompidos.
# deletei os dois

# no banco de 2018 os arquivos 000000038773.xls
#estao corrompidos.
# deletei 