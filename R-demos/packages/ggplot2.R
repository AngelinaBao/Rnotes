library(ggplot2)
#simple plot made by ggplot
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() +
  labs(title = "Automobile Data", x = "Weight", y = "Miles Per Gallon")

#more paras added
ggplot(data = mtcars, aes(x = wt, y = mpg)) + 
  geom_point(pch = 18, color = "blue", size = 2) +
  geom_smooth(method = "lm", color = "red", linetype = 1) +
  labs(title = "Automobile Data", x = "Weight", y = "Miles Per Gallon")

#grouop&facet, ggplot2 use factor when defines grouop or facet
mtcars$am <- factor(mtcars$am, levels = c(0, 1), labels = c("Automatic", "Manual"))
mtcars$vs <- factor(mtcars$vs, levels = c(0, 1), labels = c("V-Engine", "Straight Engine"))
mtcars$cyl <- factor(mtcars$cyl)
ggplot(data = mtcars, aes(x = hp, y = mpg, shape = cyl, color = cyl)) +
  geom_point(size = 3)+
  facet_grid(am~vs) +
  labs(title = "Automobile Data by Engine Type",
       x = "Horsepower", y = "Miles Per Gallon")
