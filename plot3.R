library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

Balt_PM25 <- filter(NEI,fips == "24510")
total_PM25 <- tapply(Balt_PM25$Emissions,list(Balt_PM25$year,Balt_PM25$type),sum,na.rm = TRUE)

values <- c(total_PM25)
type <- rep(colnames(total_PM25),each = 4)
year <- rep(rownames(total_PM25),times = 4)
data <- data.frame(values,type,year)

png("plot3.png")

g <- ggplot(data,aes(x = year,y = values, fill = type)) + 
  geom_bar(position = "dodge",stat = "identity") +
  labs(title = "PM2.5 emissions by type and year",x = "Year",y = "PM2.5 emission (tonnes)", 
       fill = "Type")
print(g)

dev.off()