library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

idx <- grep("ICE",SCC$EI.Sector,ignore.case = TRUE)
MVsources <- SCC$SCC[idx]
MVData <- filter(NEI,SCC %in% MVsources,fips == "24510")

total_PM25 <- tapply(MVData$Emissions,MVData$year,sum,na.rm = TRUE)

png("plot5.png")

bp <- barplot(total_PM25,col = "red", space = 1.5,ylim = c(0,500))
points(bp,total_PM25,pch = 19)
lines(bp,total_PM25,lty = 2)
title(main = "PM25 emissions from Motor vehicle sources in Baltimore",
      ylab = "Emissions (tonnes)",xlab = "Year")

dev.off()