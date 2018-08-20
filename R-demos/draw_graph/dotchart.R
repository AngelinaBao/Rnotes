x <- mtcars[order(mtcars$mpg),]#根据mpg从低到高对mtcars进行排序
x$color[x$cyl == 4] <- "Black" #添加一个字符向量color到x中，根据cyl 的值分别
#将color赋值为"Black"、"Red"、"Blue"
x$color[x$cyl == 6] <- "Red"
x$color[x$cyl == 8] <- "Blue"
x$cyl <- factor(x$cyl) #将数值向量cyl 转化为因子，后面参数groups会用到cyl, 而groups是来选定一个因子
dotchart(x$mpg, labels = rownames(x),
         groups = x$cyl,
         main = "Dotchart Of Miles per Gallon for Different Car Type",
         xlab = "Miles Per Gallon",
         color = x$color,
         gcolor = "Black",
         cex = .7,
         pch = 19
)