rm(list=ls(all=TRUE))
library("LSAfun")
library(readtext)
library(rvest)

url = "http://economia.estadao.com.br/noticias/geral,trabalhadores-informais-chegam-a-10-milhoes-no-pais,10000071200"
download.file(url, destfile = "scrapedpage.html", quiet=T)
content <- read_html("scrapedpage.html")
scraping_wiki<-content

dados<-scraping_wiki %>%
  html_nodes("p")%>%
  html_text()

concatenar<-function(x){
  saida<-x[1]
  for(i in 2:length(x)){
    entrada<-x[i]
    saida<-paste(saida,entrada)
    
  }
  saida
}

desacentuar <- function(x) {
  gsub("`|\\'", "", iconv(x, to = "ASCII//TRANSLIT"))
}

saidaFuncao<-desacentuar(concatenar(dados))
saidaFinal<-genericSummary(saidaFuncao,k=5,split=c(".","!","?"),min=2,breakdown=FALSE)

write.table(saidaFinal,file="C://Pasta_Python//mineraTexto//saida3.txt", sep = "\t")
