library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

Balt_PM25 <- filter(NEI,fips == "24510")
total_PM25 <- tapply(Balt_PM25$Emissions,Balt_PM25$year,sum,na.rm=TRUE)

png("plot2.png")

bp <- barplot(total_PM25,col = "red",space = 1.5,ylim = c(0,3500))
title(main = "Total PM2.5 emissions in Baltimore per year",xlab = "Year",ylab = "PM2.5 emitted (tonnes)")
points(bp,total_PM25,pch = 19)
lines(bp,total_PM25,lty = 2)

dev.off()