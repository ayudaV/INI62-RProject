library(ggplot2)
library(reshape)
november2016 <- cepagri

cepagri_by_mon <- aggregate(cepagri[, 2:5], list(cepagri$horario$mon), mean)


# Long format
df <- melt(cepagri_by_mon, id.vars = 1)
df[1]
ggplot(df, aes(x = df[1], y = value, color = variable)) +
  geom_line()