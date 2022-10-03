library(ggplot2)

mean = tapply(cepagri$temp, format(cepagri$horario, "%Y"), mean)
min = tapply(cepagri$temp, format(cepagri$horario, "%Y"), min)
max = tapply(cepagri$temp, format(cepagri$horario, "%Y"), max)

df = data.frame(row.names(mean), mean, min, max, row.names = NULL)
colnames(df) = c("Ano", "Media", "Minima", "Maxima")

ggplot(data=df, aes(x=factor(Ano, level=Ano), group=1))+
  geom_line(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_point(data=df, mapping=aes(y=Media, colour="Media"))+
  geom_line(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_point(data=df, mapping=aes(y=Minima, colour="Minima"))+
  geom_line(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  geom_point(data=df, mapping=aes(y=Maxima, colour="Maxima"))+
  labs(x="Ano", y="Temperatura (ºC)", title="Gráfico de Temperatura (Ano)")+
  scale_colour_manual("", 
                      breaks = c("Maxima", "Media", "Minima"),
                      values = c("red", "purple", "blue"))