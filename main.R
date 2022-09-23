rm(list=ls())

names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

cepagri$temp <- as.numeric(cepagri$temp)
cepagri <- na.omit(cepagri) 

cepagri$horario <- as.POSIXct(cepagri$horario,format="%d/%m/%Y-%H:%M",tz=Sys.timezone())

cepagri <- subset(cepagri, sensa <= 60)

#cepagri = subset(cepagri, umid >= 10)

summary(cepagri)