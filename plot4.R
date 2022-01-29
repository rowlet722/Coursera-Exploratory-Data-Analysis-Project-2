library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

idxComb <- grep("combustion",SCC$SCC.Level.One,ignore.case = TRUE)
idxCoal <- grep("coal",SCC$SCC.Level.Three,ignore.case = TRUE)
idx <- intersect(idxComb,idxCoal)
coalSources <- SCC$SCC[idx]
coalData <- filter(NEI,SCC %in% coalSources)

total_PM25 <- tapply(coalData$Emissions,coalData$year,sum,na.rm = TRUE)

png("plot4.png")

bp <- barplot(total_PM25,col = "red", space = 1.5, ylim = c(0,6e5))
points(bp,total_PM25,pch = 19)
lines(bp,total_PM25,lty = 2)
title(main = "PM25 emissions from Coal related sources",ylab = "Emissions (tonnes)",
      xlab = "Year")

dev.off()
