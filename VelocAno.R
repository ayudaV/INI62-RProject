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
  labs(x="Mês", y="Velocidade", title="Velocidade do Vento")+
  scale_colour_manual("", 
                      breaks = c("Maxima", "Media", "Minima"),
                      values = c("red", "purple", "blue"))