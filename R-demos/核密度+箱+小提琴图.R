#核密度图(是用于估计随机变量概率密度函数的一种非参数方法)
install.packages("sm")
head(mtcars)
library(sm)
class(cyl)
str(mtcars)
attach(mtcars)
cyl.f <- factor(cyl, levels = c(4,6,8), labels = c("4.cyl", "6.cyl", "8.cyl"))
sm.density.compare(mpg, cyl.f)
title("Miles per Gallon for Cyl")
colfill <- c(1:length(levels(cyl.f)))
legend(locator(1), levels(cyl.f), fill = colfill)

#箱图
boxplot(mpg, main = "Boxplot of Miles per Gallon")
boxplot.stats(mpg)
boxplot(mpg ~ cyl, data = mtcars,
        notch = TRUE,
        main = "New Boxplot",
        xlab = "Cyl",
        ylab = "Miles per Gallon",
        col = "Red",
        varwidth = TRUE
)

head(mtcars)
am.f <- factor(am, levels = c(0,1), labels = c("auto", "standard"))
cyl.f <- factor(cyl, levels = c(4,6,8), labels = c("4", "6", "8"))
boxplot(mpg ~ am.f*cyl.f, data = mtcars,
        main = "Complex Boxplot\n (mgp~am*cyl)",
        xlab = "Auto Type",
        ylab = "Miles per Gallon",
        col = c("Yellow", "Red"),
        varwidth = TRUE)

#小提琴图
x1 <- mpg[cyl == 4]
x2 <- mpg[cyl == 6]
x3 <- mpg[cyl == 8]
install.packages("vioplot")
library(vioplot)
vioplot(x1,x2,x3, names = c("4缸", "6缸", "8缸"), col = "tomato")
title("Violin Plot of Miles per Gallon", 
      xlab = "缸数",
      ylab = "Miles Per Gallon")
