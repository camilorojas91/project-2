library(ggplot2)
library(dplyr)
library(stringr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##### plot 1 #####

hist(NEI$year, main = "PM2.5 general EEUU", xlab = "year")

#No the emitions are increasing 

##### plot 2 ####

NEI2 <- NEI %>% 
  filter(fips == "24510")

hist(NEI2$year, main = "PM2.5 Baltimore City", xlab = "year")

#####plot 3 ####

ggplot(NEI2, aes(x = year))+
  geom_bar()+
  facet_wrap(.~type)

##### plot 4 ####

SCC$SCC <- as.character(SCC$SCC)

base_total <- full_join(NEI, SCC, by = "SCC")

base_total$coal <- ifelse(str_detect(base_total$SCC.Level.Three, "coal") == TRUE, 1,0)

ggplot(base_total, 
       aes(x = year, y = coal))+
  geom_col()

##### plot 5 ####

ggplot(NEI2,
       aes(x = year, y = Emissions))+
  geom_col()

#### plot 6 #####

NEI3 <- NEI %>% 
  filter(fips == c("24510", "06037"))

ggplot(NEI3,
       aes(x = year, y = Emissions))+
  geom_col()+
  facet_wrap(.~fips)
