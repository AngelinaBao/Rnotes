#qplot
library(ggplot2)
dia <- diamonds
qplot(carat, price, data = dia)
qplot(carat, price, data = dia, color = color)
qplot(carat, price, data = dia, color = cut, shape = cut)
qplot(carat, price, data = dia, geom = "point")
qplot(carat, price, data = dia, geom = c("point", "smooth"))

#color, fill
dat <- dia[sample(nrow(dia), 100),]
qplot(color, price, data = dat, geom = "boxplot")
qplot(color, price, data = dat, geom = "boxplot", fill = "blue")
# qplot(color, price, data = dat, geom = "boxplot") + geom_boxplot(
#   outlier.colour = "blue", outlier.alpha = I(0.1), fill = "pink", 
#   colour = "red", size = 1
# )
qplot(carat, data = dat, geom = "histogram", color = color, fill = color)
qplot(carat, data = dat, geom = "density")
qplot(carat, data = dat, geom = "density", color = color)

library(lubridate)
qplot(date, unemploy/pop, data = economics, geom = "line")
qplot(unemploy/pop,uempmed, data = economics,
      geom = "path", color = year(date))
