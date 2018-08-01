#核密度图(是用于估计随机变量概率密度函数的一种非参数方法)
install.packages("sm")
head(mtcars)
library(sm)
class(cyl)
str(mtcars)
attach(mtcars)
cyl.f <- factor(cyl, levels = c(4,6,8), labels = c("4.cyl", "6.cyl", "8.cyl"))
sm.density.compare(mpg, cyl.f) #向图形叠加两组或更多的核密度图
title("Miles per Gallon for Cyl")
colfill <- c(1:length(levels(cyl.f)))
legend(locator(1), levels(cyl.f), fill = colfill) #首先创建的是一个颜色向量，这里的colfill值为c(2, 3, 4)。然后通过legend()函数向图形上添加一个
#图例。第一个参数值locator(1)表示用鼠标点击想让图例出现的位置来交互式地放置这个图例。第二个参数值则是由标签组成的字符向量。第三个参数值使用向量
#colfill为cyl.f的每一个水平指定了一种颜色。

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
am.f <- factor(am, levels = c(0,1), labels = c("auto", "standard")) #创建变速箱类型的因子
cyl.f <- factor(cyl, levels = c(4,6,8), labels = c("4", "6", "8")) #创建汽缸数量的因子
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
