library(ggplot2)

cepagri_by_mon <- aggregate(cepagri[,2:5], list(cepagri$horario$mon), mean)

long_cepagri <- melt(cepagri_by_mon, id.vars = "Group.1")
ggplot(long_cepagri, aes(x = Group.1, y = value, color = variable)) +
  geom_line() +
  labs(title = "Grafico Temp, Vento, Umid, Sensa",
       x = "Mês", y = "Valor")

