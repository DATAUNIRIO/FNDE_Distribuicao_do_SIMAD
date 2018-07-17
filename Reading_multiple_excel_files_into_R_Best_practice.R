#https://stackoverflow.com/questions/32888757/reading-multiple-excel-files-into-r-best-practice

setwd('C:/Users/Steven/Documents/DIRETORIO DE TRABALHO DO R/Fabio')
library(readxl)
# get all files ending in xls
files <- list.files(pattern='*.xls')
# read in data
dat <- lapply(files, read_excel, range = "A10:D500")
names(dat) <- gsub("\\.xls", "", files) # remove file extension
library(purrr)
dat2 <- map(files, read_excel, range = "A10:D500")
names(dat2) <- gsub("\\.xls", "", files)

dat3<-do.call(rbind.data.frame, dat2)
dat3$chave<-row.names(dat3)
dat3<-na.omit(dat3)
dat3$chave <- data.frame(do.call('rbind', strsplit(as.character(dat3$chave),'.',fixed=TRUE)))

library(xlsx)
write.xlsx(dat3, "FNDE.xls") 
write.csv(dat3,"FNDE.csv")

##################################################################################
##################################################################################
##################################################################################

# library(readxl)
# #file.list <- list.files(pattern='*.xls')
# #df.list <- lapply(file.list, read_excel)
# library(purrr)
# file.list <- list.files(pattern='*.xls')
# file.list <- setNames(file.list, file.list) # only needed when you need an id-column with the file-names
# df <- map_df(file.list, read_excel, range = "A10:D500")
# df<-na.omit(df)


