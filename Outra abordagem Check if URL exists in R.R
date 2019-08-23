

setwd("C:/Users/Steven/Documents/DIRETORIO DE TRABALHO DO R/Fabio/")
local<-"C:/Users/Steven/Documents/DIRETORIO DE TRABALHO DO R/Fabio/Fabio"

Parte1<-'https://www.fnde.gov.br/distribuicaosimadnet/criarArquivoExcelDistribuicao?numeroEntidade=000000'
# 346764
Parte2<-'&anoPrograma=2015&codigoPrograma=01&ufSelecionada=RJ&criterios='

require(doMC)
require(foreach)
registerDoMC(20)

x <- foreach(i = 1:1000000) %dopar% {
  xxx <- getURL(urls[paste0(Parte1,i,Parte2)])
}


#----------------------------------------------------------------------------------------
# https://sociaisemetodos.wordpress.com/2013/08/29/webscrapping-i-fazendo-download-de-dados-de-tabelas-em-sites/
#----------------------------------------------------------------------------------------

# Cria um função simples para retirar tabs e carateres especiais da página
cleanupHTML <- function(z) {
  z <- gsub("\t","",z) #retira tabs
  z <- gsub("  ", "",z) #retira espaços duplos
  z <- gsub("^\\s+", "", z) # retira espaços no início das linhas
  z <- gsub("\\s+$", "", z) # retira espaços no fim das linhas
  return(gsub("<(.|\n)*?>","",z)) #retira caracteres especiais e retorna o resultado
}


# Endereço básico</span>
baseurl <- "http://www.portaldatransparencia.gov.br/servidores/OrgaoExercicio-ListaServidores.asp?CodOS=25201&DescOS=BANCO%20CENTRAL%20DO%20BRASIL&CodOrg=25201&DescOrg=BANCO%20CENTRAL%20DO%20BRASIL&Pagina=XX"

#Loop para fazer download de uma sequencia de páginas
data <- NULL
for (i in 1:278) { #contador: vai da página 1 à pág. 278
  print(i) #imprime na tela a página que está sendo acessada
  url <- gsub("XX", i, baseurl) #substitui a expressão XX no endereço pelo índice da página
  x <- readLines(url) #lê o código fonte da página número 'i'
  x <- iconv(x) #converte o sistema de codificação de caracteres para UTF-8
  # Este último comando funciona apenas para Windows.
  # No Linux, troque pelo seguinte comando:
  # x <- iconv(x, "latin1", "utf-8")
  
  #delimina as linhas inicial e final (onde estão contidos os dados desejados)
  start <- grep("<table summary=\"Lista de servidores por Nível da Função\">", x)
  end <- grep("<script type=\"text/javascript\" language=\"javascript\" src=\"../../Recursos/helper.js\"></script>", x)[1]
  
  x <- cleanupHTML(x[start:end]) #aplica a função que retira tabs e caracteres especiais
  data <- c(data, x) #salva os resultados num vetor
}


temp <- data

#Retira espaços vazious e marcas de comentários
temp <- temp[-which(temp %in% c("", " ", " ", " ", " ", " ", " "," ", " <!--", " -->"))]

#Retira cabeçalhos (pois foram coletados várias vezes -- uma vez em cada página)
temp <- temp[-which(temp %in% c("CPF", "Nome do servidor", "Órgão de lotação"))]

#organiza os resultados como um Dataframe
temp_m <- as.data.frame(matrix(temp, byrow=T, ncol=3))

#Dá nome às variáveis
names(temp_m) = c("CPF", "Nome do servidor", "Órgão de lotação")

View(temp_m)


#----------------------------------------------------------------------------------------
# https://sociaisemetodos.wordpress.com/2013/09/01/webscrapping-ii-baixando-tabelas-com-o-readhtmltable/
#----------------------------------------------------------------------------------------

require(XML)

# Endereço básico
baseurl <- "http://www.portaldatransparencia.gov.br/servidores/OrgaoExercicio-ListaServidores.asp?CodOS=25201&DescOS=BANCO%20CENTRAL%20DO%20BRASIL&CodOrg=25201&DescOrg=BANCO%20CENTRAL%20DO%20BRASIL&Pagina=XX"

#Loop para fazer download de uma sequencia de páginas
data <- data.frame()
for (i in 1:278) { #contador: vai da página 1 à pág. 278
  print(i) #imprime na tela a página que está sendo acessada
  url <- gsub("XX", i, baseurl) #substitui a expressão XX no endereço pelo índice da página
  x <- readHTMLTable(url)[[2]]
  
  data <- rbind(data, x) #salva os resultados num vetor
}

data #resultado final