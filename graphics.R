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

c2016 <- subset(cepagri, horario >= "2016/01/01")
c2016 <- subset(c2016, horario < "2017/01/01")

c2016$horario <- as.POSIXct(c2016$horario)
ggplot(c2016, aes(x = temp, y = umid)) +
  geom_point(shape=1, fill="red", color="darkred", size=1) +


ggplot(c2016, aes(temp, sensa)) +
  geom_point(fill="red", color="darkred") +
  geom_smooth(method = "lm", formula = y ~ x, se=FALSE) +
  labs(title = "Temperatura x Sensação Termica",
       x = "Temperatura ºC", y = "Sensação Termica ºC")




summary(cepagri)
