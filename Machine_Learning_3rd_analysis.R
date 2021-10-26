#extract database
setwd("C:/Users/foliveira/Desktop/curso/Curso R")
df<-read.csv("Fipeprev.csv", header = TRUE, encoding = "UTF-8")

# change variable char to factor
df$Marca <- as.factor(df$Marca)
df$Nome <- as.factor(df$Nome)
df$Carro <- as.factor(df$Carro)
df$Ano_Modelo <- as.factor(df$Ano_Modelo)
df$Combustivel<- as.factor(df$Combustivel)
df$cambio<- as.factor(df$cambio)


#train and test split
set.seed(100)
linhas<- sample(1:length(df$Marca), length(df$Marca)*0.7)
#70% of Df
treino = df[linhas,]

#30% of Df
teste =df[-linhas,]

View(treino)
View(teste)
length(treino$Marca)+length(teste$Marca)

#create model

library(rpart)

modelo<- rpart(Preco ~.,
               data=treino,
               control=rpart.control(cp=0))


#predict model

teste$Previsao <- predict(modelo,teste)
View(teste)


#Price Result

teste$P <- round(teste$Previsao/teste$Preco,2)
teste$P <- teste$P - 1
teste$P <- abs(teste$P)
R_1 <- summary(teste$P)
R_1

#Price distribution
summary(df$Preco)

quantile(df$Preco, 0.9)

hist(df$Preco[df$Preco<quantile(df$Preco,.9)], breaks=10,labels=T)

R_Final_1 <- summary(teste$P[teste$Preco>10000 & teste$Preco<70000])
R_1
R_Final_1

#delete column car for analysis
df$Carro <- NULL

treino = df[linhas,]
teste =df[-linhas,]

modelo<- rpart(Preco ~.,
               data=treino,
               control=rpart.control(cp=0))

teste$Previsao <- predict(modelo,teste)

teste$P <- round(teste$Previsao/teste$Preco,2)
teste$P <- teste$P - 1
teste$P <- abs(teste$P)
R_2 <- summary(teste$P)
R_1
R_2

R_Final_2 <- summary(teste$P[teste$Preco>10000 & teste$Preco<70000])
R_Final_1
R_Final_2

#Extract final file
write.table(df, file="FipePrevAjustada.csv", row.names=FALSE, sep = ",", fileEncoding = 'UTF8')
#Extract train and test file
write.table(teste, file="teste.csv", row.names=FALSE, sep = ",", fileEncoding = 'UTF8')
write.table(treino, file="treino.csv", row.names=FALSE, sep = ",", fileEncoding = 'UTF8')
