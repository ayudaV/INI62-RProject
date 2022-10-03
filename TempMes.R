library(ggplot2)

mean = tapply(cepagri$temp, format(cepagri$horario, "%m"), mean)
min = tapply(cepagri$temp, format(cepagri$horario, "%m"), min)
max = tapply(cepagri$temp, format(cepagri$horario, "%m"), max)

df = data.frame(row.names(mean), mean, min, max, row.names = NULL)
colnames(df) = c("Mes", "Media", "Minima", "Maxima")
df$Mes = month.abb

ggplot(data=df, aes(x=factor(Mes, level=Mes), group=1))+
  geom_line(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_point(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_line(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_point(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_line(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  geom_point(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  labs(x="Mês", y="Temperatura (ºC)", title="Gráfico de Temperaturas (Mês)")+
  scale_colour_manual("", 
                    breaks = c("Maxima", "Media", "Minima"),
                    values = c("red", "purple", "blue"))