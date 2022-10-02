temp_mes <- tapply(cepagri$temp, cepagri$horario$mon, mean)
data_temp_mes <- data.frame(
  name = month.abb,
  value=temp_mes
)

temp_ano <- tapply(cepagri$temp, cepagri$horario$year + 1900, mean)
data_temp_ano <- data.frame(
  name = names(temp_ano),
  value=temp_ano
)
barplot(height = data_temp_mes$value,names=data$name,col = "#69b3a2", main = "Temperatura média dos meses")

ggplot(data = data_temp_ano, aes(x = name, y = value)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura média de cada ano",
       x = "Ano", y = "Temperatura ºC")
