#Pre Processamento

rm(list=ls())

names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

cepagri$temp <- as.numeric(cepagri$temp)
cepagri <- na.omit(cepagri) 

cepagri$horario <- as.POSIXlt(cepagri$horario,format="%d/%m/%Y-%H:%M",tz=Sys.timezone())

cepagri <- subset(cepagri, sensa <= 60)
cepagri <- subset(cepagri, sensa >= 0)

cepagri <- subset(cepagri, umid > 10)


summary(cepagri)

#Temperatura Novembro 2016
library(ggplot2)

november2016 <- cepagri
november2016$horario <- as.Date(november2016$horario, format = '%y/%m/%d')
november2016 <- subset(november2016, horario >= "2016/11/01")
november2016 <- subset(november2016, horario < "2016/12/01")

ggplot(data = november2016, aes(x = horario, y = temp)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura data/hora",
       subtitle = "November 2016",
       x = "Data", y = "Temperatura ºC")

#Graficos de ponto 2016
c2016 <- subset(cepagri, horario >= "2016/01/01")
c2016 <- subset(c2016, horario < "2017/01/01")

c2016$horario <- as.POSIXct(c2016$horario)

ggplot(c2016, aes(temp, sensa)) +
  geom_point(fill="red", color="darkred") +
  geom_smooth(method = "lm", formula = y ~ x, se=FALSE) +
  labs(title = "Temp x Sensação Termica",
       x = "Temperatura ºC", y = "Sensação Termica ºC")

ggplot(c2016, aes(vento, sensa)) +
  geom_point(fill="green", color="darkgreen") +
  geom_smooth(method = "lm", formula = y ~ x, se=FALSE) +
  labs(title = "Vento x Sensação Termica",
       x = "Vento km/h", y = "Sensação Termica ºC")

ggplot(c2016, aes(umid, sensa)) +
  geom_point(fill="blue", color="darkblue") +
  geom_smooth(method = "lm", formula = y ~ x, se=FALSE) +
  labs(title = "Umidade x Sensação Termica",
       x = "Umidade %", y = "Sensação Termica ºC")




#Grafico Geral De Linha
library(ggplot2)

cepagri_by_mon <- aggregate(cepagri[,2:5], list(cepagri$horario$mon), mean)

long_cepagri <- melt(cepagri_by_mon, id.vars = "Group.1")
ggplot(long_cepagri, aes(x = Group.1, y = value, color = variable)) +
  geom_line() +
  labs(title = "Grafico Temp, Vento, Umid, Sensa",
       x = "Mês", y = "Valor")



#Graficos de linha (Maxima, Media, Minima) de todos os anos
library(ggplot2)

mean = tapply(cepagri$vento, format(cepagri$horario, "%Y"), mean)
min = tapply(cepagri$vento, format(cepagri$horario, "%Y"), min)
max = tapply(cepagri$vento, format(cepagri$horario, "%Y"), max)

df = data.frame(row.names(mean), mean, min, max, row.names = NULL)
colnames(df) = c("Ano", "Media", "Minima", "Maxima")

ggplot(data=df, aes(x=factor(Ano, level=Ano), group=1))+
  geom_line(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_point(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_line(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_point(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_line(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  geom_point(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  labs(x="Ano", y="Velocidade", title="Velocidade do Vento (Ano)")+
  scale_colour_manual("", 
                      breaks = c("Maxima", "Media", "Minima"),
                      values = c("red", "purple", "blue"))


#Grafico de Linha Smooth
library(hrbrthemes)

xValue <- 1:24
yValue <- temp_hora
data <- data.frame(xValue,yValue)

ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="#69b3a2", size=1, alpha=0.9, linetype=1) +
  theme_ipsum() +
  labs(title = "Temperatura  x Horário",
       x = "Hora do dia", y = "Temperatura ºC")

#Gráficos de Barra
temp_mes <- tapply(cepagri$temp, cepagri$horario$mon, mean)
data_temp_mes <- data.frame(
  name = factor(month.abb, levels=unique(month.abb)),
  value=temp_mes
)
ggplot(data = data_temp_mes, aes(x = name, y = value)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura média de cada mês",
       x = "Ano", y = "Temperatura ºC")

barplot(height = data_temp_mes$value,names=data_temp_mes$name,col = "#69b3a2", main = "Temperatura média dos meses")



temp_ano <- tapply(cepagri$temp, format(cepagri$horario, "%Y"), mean)
data_temp_ano <- data.frame(
  name = names(temp_ano),
  value=temp_ano
)
barplot(height = data_temp_ano$value,names=data_temp_ano$name,col = "#69b3a2", main = "Temperatura média dos anos")

ggplot(data = data_temp_ano, aes(x = name, y = value)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura média de cada ano",
       x = "Ano", y = "Temperatura ºC")

temp_hora <- tapply(cepagri$temp, cepagri$horario$hour, mean)
data_temp_hora <- data.frame(
  name = seq(0, 23),
  value=temp_hora
)
barplot(height = data_temp_hora$value,names=data_temp_hora$name,col = "#69b3a2", main = "Temperatura média de cada horário do dia")


