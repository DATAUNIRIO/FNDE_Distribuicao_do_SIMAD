##================================================================================================
##                                                                                              
##    Nome: 03 maneiras de verificar se um site existe (Check if URL exists in R)                                           
##                                                    
##    site: https://stackoverflow.com/questions/31420210/r-check-existence-of-url-problems-with-httrget-and-url-exists                                                                                                                                               
##    Objetivo: Testar se a URL existe
##    prof. Steven Dutt-Ross                          
##    UNIRIO           
##================================================================================================

#----------------------------------------------------------------------------------------
# Metodo 01
# https://stackoverflow.com/questions/31420210/r-check-existence-of-url-problems-with-httrget-and-url-exists                                                                                                                                              
#----------------------------------------------------------------------------------------


library(httr)
urls <- c(
  'http://www.unirio.br/',
  'https://www.deakin.edu.au/current-students/unitguides/UnitGuide.php?year=2015&semester=TRI-1&unit=SLE010', 
  'https://www.deakin.edu.au/current-students/unitguides/UnitGuide.php?year=2015&semester=TRI-2&unit=HMM202',
  'https://www.deakin.edu.au/current-students/unitguides/UnitGuide.php?year=2015&semester=TRI-2&unit=SLE339'
)

sapply(urls, url_success, config(followlocation = 0L), USE.NAMES = FALSE)

#----------------------------------------------------------------------------------------
# Metodo 02
# https://stackoverflow.com/questions/43915316/checking-validity-of-a-list-og-urls-using-get
#----------------------------------------------------------------------------------------

websites <- read.table(header=T, text="website
                       1   www.msn.com
                       2   www.wazl.com
                       3  www.amazon.com
                       4 www.rifapro.com")

library(httr)
urls <- paste0(ifelse(grepl("^https?://", websites$website, ig=T), "", "http://"),
               websites$website)
lst <- lapply(unique(tolower(urls)), function(url) try(HEAD(url), silent = T))
names(lst) <- urls
sapply(lst, function(x) if (inherits(x, "try-error")) -9999 else status_code(x))

sites<-sapply(lst, function(x) if (inherits(x, "try-error")) "Não Existe site" else status_code(x))





#----------------------------------------------------------------------------------------
# Metodo 03
# Ping 
#----------------------------------------------------------------------------------------

library(pingr)

ping("amazon.com") # good site
## [1] 45 46 45

ping("xxxyyyzzz.com")

for(i in 1:4){
ping(urls[i]) # good site
}

ping_port("www.google.com", port = 80, count = 1)

# Thanks, but using ping() I get only NAs for any site. Even for ping("amazon.com"). Following the pingr documentation, this one works fine: ping_port("www.google.com", port = 80, count = 1).