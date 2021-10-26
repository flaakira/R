#Import transformed File
setwd("C:/Users/foliveira/Desktop/curso/Curso R")
df<-read.csv("FipeTransformada.csv",header=TRUE, encoding = "UTF-8", stringsAsFactors = T)

#import library
library("dplyr")

# new models group by price mean
media_marca<-df %>% filter(Ano_Modelo=="Zero Km") %>% 
  group_by(Marca) %>% 
  summarise(mean(Preco))

# extract multiples information from the same column

View(df)
levels(df$Carro)
library("stringr")

df$Cilindradas <- str_extract(df$Carro, "[0-9]\\.[0-9]")
str(df$Cilindradas)

df$Cilindradas <- as.factor(df$Cilindradas)
str(df$Cilindradas)
summary(df$Cilindradas)

# analysis NA cases
unique(df$Carro[is.na(df$Cilindradas)])

#alternative filter with dplyr
library(dplyr)

df %>% 
  filter(is.na(Cilindradas)) %>% 
  select(Carro) %>% 
  distinct(Carro)

#mechanic type Automatic or manual

aut <- subset(df, str_detect(df$Carro, "Aut\\."), "Carro")
aut <- unique(aut)
aut$cambio <- "Aut"

View(aut)

df<-left_join(df,aut)
df$cambio[is.na(df$cambio)] <-"Mec"
str(df$cambio)

#split car collumn name
library(tidyr)

df<- separate(df, "Carro", into="Nome", sep = " ", remove = FALSE)
summary(df$Nome)
df$Nome<- as.factor(df$Nome)
str(df$Nome)
str(df$Carro)

str(df)

df <- na.omit(df)

write.table(df,file = "Fipeprev.csv", row.names = FALSE, sep = ",", fileEncoding = "UTF-8")

          