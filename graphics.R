install.packages("ggplot2")

library(ggplot2)

november2016 <- cepagri
november2016$horario <- as.Date(november2016$horario, format = '%y/%m')

november2016 <- subset(november2016, horario >= "2016/11/01")
november2016 <- subset(november2016, horario < "2016/12/01")

ggplot(cepagri, aes())

p <- ggplot(cepagri, aes(x = horario, y = temp)) 
p <- p + geom_point() 

ggsave("grafico.png", width = 4, height = 6) 

#ggsave("grafico.jpg", units = "cm", width = 20, height = 20)

ggplot(data = november2016, aes(x = horario, y = temp)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Temperatura data/hora",
       subtitle = "November 2016",
       x = "Data", y = "Temperatura ºC")

g <- ggplot(november2016, aes(temp, sensa)) +
  geom_point()

g + geom_smooth(method = "lm", 
                formula = y ~ x,
                se=FALSE)


mensal <- c()
for(i in 1:12) {
  mensal[i] <- mean(subset(cepagri, horario$mon == i-1)$temp)
}
mensal
summary(cepagri)
data <- data.frame(
  name = month.abb,
  value=mensal
)
barplot(height = data$value,names=data$name,col = "#69b3a2")