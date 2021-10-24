library(dplyr)
library(tidyverse)
library(datasets)
library(ggplot2)
library(grid)

toDrop=c("Africa","Asia","Europe","European Union","North America","Oceania","South America","World", "date")
#file.choose() 
data <- read.csv ("C:\\Users\\Rick\\Desktop\\total_cases.csv",header=FALSE,sep=",")
data = data[,!(names(data) %in% toDrop)]

transpose <- as.data.frame (t(data))
last_date <- transpose[,c(1,nrow(data))]
colnames(last_date) <- c( 'Pais', 'Casos')
last_date <- subset (last_date, !(Pais %in% toDrop))
last_date$Casos <- as.numeric(as.character(last_date$Casos))
last_date


#paises con menos contagios 
minimos <- last_date[tail(order(last_date$Casos,decreasing = TRUE),4),,drop=F]
rbind(minimos,subset(last_date,Pais=='Paraguay')[1,])


#paises con mas contagios 
maximo <- last_date[head(order(last_date$Casos,decreasing = TRUE),4),,drop=F]
rbind(maximo,subset(last_date,Pais=='Paraguay')[1,])

#casos por millon 

total_cases <- read.csv("C:\\Users\\Rick\\Desktop\\total_cases.csv", header=TRUE , sep=",") 
locations <- read.csv("C:\\Users\\Rick\\Desktop\\locations.csv", header=TRUE , sep=",")
total_cases$Europe <- total_cases$South.America <- total_cases$North.America <- NULL
total_cases$Africa <- total_cases$America <- total_cases$European.Union <- NULL
total_cases$World <- total_cases$date <- total_cases$Oceania <- NULL
total_cases$Asia <- NULL
casos_millon <- data.frame(t(total_cases["467",]*1000000/locations$population)) 
may_millon <- t(arrange(casos_millon,-X467)) #ORDENAMOS DESCEDENTEMENTE
may_casos_millon <- data.frame("Promedio"=may_millon[,(1:4)])

#casos en los ultimos 10 dias
transpose <- subset(transpose, !(V1 %in% toDrop))
transpose <- transpose[,c(1,nrow(data)-10,nrow(data))]
transpose$V458 <- as.numeric(as.character(transpose$V458))
transpose$V468 <- as.numeric(as.character(transpose$V468))
result <- apply(transpose,1,function(row) { (as.numeric(row['V468']) - as.numeric(row['V458'])) / 10})
transpose$Casos <- c(result)
transpose <- transpose[,c(1,4)]
casos_10d <- transpose[head(order(transpose$Casos,decreasing = TRUE),50),,drop=F]
colnames(casos_10d) <- c( 'Pais', 'Casos')
casos_10d

#correlacion 

# file 2 data
# data2 <-read.csv("C:\\Users\\Rick\\Desktop\\total_cases.csv")
# data2<-data2[, !(names(data2) %in% toDrop)]
# 
#  file_transpose <- data.frame(t(data2))
# colnames(file_transpose) <- data[,1]
#  file_transpose[is.na(file_transpose)] <-0
# 
# 
#  paises<-locations[,"location"]
#  casos<-last_date[,'Casos']
#  primera<- data2[1,]
#  diferencia<-apply(data2, 2 ,diff)
#  #diferencia <-rbind(primera,diferencia)
# prom<- data.frame(location = paises,CasosTotales=casos)

#grafico 

tusDatos<-read.csv("C:\\Users\\Rick\\Desktop\\total_cases.csv", header=TRUE , sep=",")
DatosGrafico <- slice(subset(tusDatos,select = c(Paraguay,Uruguay,Venezuela,Canada)), 1:348 )
DatosGrafico <- data.frame(diff(as.matrix(DatosGrafico)))
DatosGrafico["date"] <- tusDatos[1:347,]$date
DatosGrafico <- DatosGrafico %>% pivot_longer(., cols = c(Paraguay,Uruguay,Venezuela,Canada), names_to = "Paises", values_to = "casos")
DatosGrafico <- transform(DatosGrafico, date = as.Date(date, format = "%d/%m/%y") )
DatosGrafico
ggplot(data = DatosGrafico, aes(x= date, y= casos, color=Paises)) + geom_line(size=0.1) + theme(axis.title.x = element_text(size=12,face="bold",colour = "Black",vjust=-1,hjust=0.5)) + theme(axis.title.y = element_text(size=12,face="bold",colour = "Black",vjust=-1,hjust=0.5)) + theme(plot.margin=unit(c(0,0,0.5,0.2),"cm")) + ylim(c(0,2000))




