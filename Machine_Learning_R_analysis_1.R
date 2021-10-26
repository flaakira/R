#Import DATA
setwd("C:/Users/foliveira/Desktop/curso/Curso R")
df <- read.csv("fipe_Jun2018.csv", header=TRUE, encoding = "UTF-8")
#Visualize
View(df)
str(df)
#Editing and change HEAD
names(df)
df[1] <- NULL
df$price_reference<- NULL
names(df)
names(df)<-c("Marca","Carro","Ano_Modelo","Combustivel","Preco")

#Editing model year- new models
summary(df$Ano_Modelo)
df$Ano_Modelo[df$Ano_Modelo==32000] <-"Zero Km"
df$Ano_Modelo <- as.factor(df$Ano_Modelo)
summary(df$Ano_Modelo)
str(df$Ano_Modelo)

#Editing Brazilian currency to numeric
df$Preco<-gsub("R\\$|\\.| ","",df$Preco)
summary(df$Preco)
df$Preco <- as.numeric(gsub("\\,",".",df$Preco))
summary(df$Preco)

#Save new CSV table
write.table(df, file = "FipeTransformada.csv",row.names = FALSE,sep = ",", fileEncoding = "UTF-8")


