library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

idx <- grep("ICE",SCC$EI.Sector,ignore.case = TRUE)
MVsources <- SCC$SCC[idx]

BaltData <- filter(NEI,SCC %in% MVsources,fips == "24510")
LAData <- filter(NEI,SCC %in% MVsources,fips == "06037")

Balt_PM25 <- tapply(BaltData$Emissions,BaltData$year,sum,na.rm = TRUE)
LA_PM25 <- tapply(LAData$Emissions,LAData$year,sum,na.rm = TRUE)

values <- c(rbind(Balt_PM25,LA_PM25))
county <- rep(c("Baltimore","LA"),times = 4)
year <- rep(c("1999","2002","2005","2008"),each = 2)
data <- data.frame(values,county,year)

png("plot6.png")

g <- ggplot(data,aes(x = year, y = values, fill = county)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(title = "PM2.5 emissions from Motor Vehicle sources", x = "Year",
       y = "PM2.5 emission (tonnes)", fill = "County")

print(g)

dev.off()