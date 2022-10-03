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


