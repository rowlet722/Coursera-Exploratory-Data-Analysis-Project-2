NEI <- readRDS("summarySCC_PM25.rds")

total_PM25 <- tapply(NEI$Emissions,NEI$year,sum,na.rm = TRUE)

png("plot1.png")

bp <- barplot(total_PM25,col = "red",space = 1.5,ylim = c(0,8e6))
title(main = "Total PM2.5 emissions per year",xlab = "Year",ylab = "PM2.5 emitted (tonnes)")
points(bp,total_PM25,pch = 19)
lines(bp,total_PM25,lty = 2)

dev.off()