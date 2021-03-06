饼状图
par(mfrow = c(2,2))
x <- c(8,12,4,9)
country_labels <- c("China", "Japan", "US", "Germany", "UK")
pie(x, country_labels, main = "Simple pie")
pct <- round(x/sum(x)*100)
labl1 <- paste(country_labels, " ", pct, "%", sep = "")
pie(pct, labl1, main = "Pie chart with percentage", col = rainbow(length(labl1)))
library(plotrix)
pie3D(x, labels = country_labels, main = "3D Pie Chart")
mytable <- table(state.region)
labls <- paste(names(mytable), "\n", mytable)
pie(mytable, labls, main = "Pie Chart from a table")
#扇形图
library(plotrix)
fan.plot(mytable, labels = labls, main = "Fan Plot")
