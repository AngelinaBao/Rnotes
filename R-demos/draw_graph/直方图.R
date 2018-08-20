#直方图
par(mfrow = c(2,2))     #将作图区域分为四块，也可以用layout()
attach(mtcars)     #绑定数据框mtcars，后面就可以直接使用列名，无需用$

hist(mpg)       #简单直方图

#指定了分组、颜色、x轴坐标和标题的直方图
hist(mpg, breaks = 12, col = "Red", xlab = "Miles Per Gallon", main = "Histogram of mpg")

#在上图基础上添加了密度曲线和轴须图(rug plot)
hist(mpg, freq = FALSE, breaks = 12, col = "Red", xlab = "Miles per Gallon", main = "Histogram of mpg")
rug(jitter(mpg))
lines(density(mpg), col = "Blue", lwd = 2)

#在第二幅图的基础上加了一条正态曲线和一个将图形围起来的盒型
h <- hist(mpg, breaks = 12, col = "Red", xlab = "Miles Per Gallon", main = "Histogram with norm curve and box")
xfit <- seq(min(mpg), max(mpg), length = 40)
yfit <- dnorm(xfit, mean = mean(mpg), sd = sd(mpg))
yfit <- yfit*diff(h$mids[1:2])* length(mpg)
lines(xfit, yfit, col = "Blue", lwd = 2)
box()          #添加盒型
detach(mtcars)      #attach() 的配套使用
