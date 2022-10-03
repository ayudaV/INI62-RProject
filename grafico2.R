temp_mes <- tapply(cepagri$temp, cepagri$horario$mon, mean)
data_temp_mes <- data.frame(
  name = factor(month.abb, levels=unique(month.abb)),
  value=temp_mes
)
ggplot(data = data_temp_mes, aes(x = name, y = value)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura média de cada ano",
       x = "Ano", y = "Temperatura ºC")

barplot(height = data_temp_mes$value,names=data_temp_mes$name,col = "#69b3a2", main = "Temperatura média dos meses")



temp_ano <- tapply(cepagri$temp, cepagri$horario$year + 1900, mean)
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


temp_hora <- tapply(cepagri$temp, format(cepagri$horario, format="%H"), mean)

library(ggplot2)
library(hrbrthemes)

# create data
xValue <- 1:24
yValue <- temp_hora
data <- data.frame(xValue,yValue)

# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="#69b3a2", size=1, alpha=0.9, linetype=1) +
  theme_ipsum() +
  labs(title = "Temperatura  x Horário",
       x = "Hora do dia", y = "Temperatura ºC")

umid_mes <- tapply(cepagri$umid, cepagri$horario$mon, mean)
umid_mes

ca <- data.frame(
  name = factor(month.abb, levels=unique(month.abb)),
  value=umid_mes
)
ca
ggplot(data = ca, aes(x = name, y = value)) +
  geom_bar(stat = "identity", fill = "purple") +
  geom_line( color="#69b3a2", size=1, alpha=0.9, linetype=1) +
  labs(title = "Temperatura média de cada ano",
       x = "Ano", y = "Temperatura ºC")



umid_mes <- tapply(cepagri$umid, cepagri$horario$mon, mean)

library(plotly)

dat1 <- data.frame(
  value= c("Temp", "Umid", "Sensa"),
  name = factor(month.abb, levels=unique(month.abb)),
  total_bill = c(cepagri$temp, umid_mes, cepagri$sensa)
)

p <- ggplot(data=dat1, aes(x=name, y=value, group=total_bill)) +
  geom_line() +
  geom_point()

fig <- ggplotly(p)

fig
