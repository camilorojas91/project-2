library(ggplot2)
library(dplyr)
library(stringr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##### plot 1 #####

jpeg("plot1.jpeg", quality = 100)

plot1 <- hist(NEI$year, main = "PM2.5 general EEUU", xlab = "year")

dev.off()



#No the emitions are increasing 

##### plot 2 ####

NEI2 <- NEI %>% 
  filter(fips == "24510")

jpeg("plot2.jpeg", quality = 100)

hist(NEI2$year, main = "PM2.5 Baltimore City", xlab = "year")
dev.off()


#####plot 3 ####
jpeg("plot3.jpeg", quality = 100)

ggplot(NEI2, aes(x = year))+
  geom_bar()+
  facet_wrap(.~type)
dev.off()
##### plot 4 ####

SCC$SCC <- as.character(SCC$SCC)

base_total <- full_join(NEI, SCC, by = "SCC")

base_total$coal <- ifelse(str_detect(base_total$SCC.Level.Three, "coal") == TRUE, 1,0)

jpeg("plot4.jpeg", quality = 100)
ggplot(base_total, 
       aes(x = year, y = coal))+
  geom_col()
dev.off()
##### plot 5 ####
jpeg("plot5.jpeg", quality = 100)
ggplot(NEI2,
       aes(x = year, y = Emissions))+
  geom_col()
dev.off()
#### plot 6 #####

NEI3 <- NEI %>% 
  filter(fips == c("24510", "06037"))
jpeg("plot6.jpeg", quality = 100)
ggplot(NEI3,
       aes(x = year, y = Emissions))+
  geom_col()+
  facet_wrap(.~fips)
dev.off()