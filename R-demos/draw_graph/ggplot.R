#最简单的例子
install.packages("ggplot2")
library(ggplot2)
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() + labs(title = "Automobile Data",
                                                                  x = "Weight",
                                                                  y = "Miles Per Gallon")
#扩展上面的例子
ggplot(data = mtcars, aes(x = wt, y = mpg)) + 
  geom_point(pch = 17, color = "blue", size = 2) +
  geom_smooth(method = "lm", color = "red", linetype = 1) +
  labs(title = "Automobile Data", x = "Weight", y = "Mile Per Gallon")

#分组和面, ggplot2包在定义组或面时使用因子
#因子化
colnames(mtcars)
head(mtcars)
mtcars$am <- factor(mtcars$am, levels = c(0, 1), labels = c("Automatic", "Manual"))
mtcars$vs <- factor(mtcars$vs, levels = c(0, 1), labels = c("V-Engine", "Straight Engine"))
mtcars$cyl <- factor(mtcars$cyl)
#绘图
ggplot(data = mtcars, aes(x = hp, y = mpg, shape = cyl, color = cyl)) +
  geom_point(size = 3) +
  facet_grid(am ~ vs) +
  labs(title = "Automobile Data by Engine Type", x = "Horsepower", y = "Miles Per Gallon")
#通过变速箱类型（手动和自动）和发动机装置（V型发动机与直列式发动机）对数据进行分组，显示变速箱的
#马力与油耗之间的关系

#几何函数常见选项
install.packages("lattice")
library(ggplot2)
data(singer, package = "lattice")
colnames(singer)
ggplot(singer, aes(x = voice.part, y = height)) + geom_violin(fill = "lightblue") +
  geom_boxplot(fill = "lightgreen", width = .2)

#展示singer数据集中每个声部成员的身高分布，利用核密度图水平排列，给每个声部分布不同的颜色
data("mtcars")
head(mtcars)
library(ggplot2)
head(singer, 3)
ggplot(data = singer, aes(x = height, fill = voice.part)) + 
  geom_density() + 
  facet_grid(voice.part ~ .)
