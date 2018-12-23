#条形图
library(vcd)
data("Arthritis")
#简单条形图
counts1 <- table(Arthritis$Improved)
barplot(counts1, main = "simple Barplot", xlab = "Improved", ylab = "Frequency")
#水平条形图
barplot(counts1, main = "Barplot of Improved", xlab = "Improved Status",
     ylab = "Frequency", col = "Lightblue", horiz = T)
#堆砌条形图
counts <- table(Arthritis$Improved, Arthritis$Treatment)
barplot(counts, col = c("Yellow", "Red", "Lightblue"), main = "Stacked Barplot", xlab = "Treatment", ylab = "Frequency", legend = rownames(counts))
#分组条形图
barplot(counts, main = "Grouped Barplot", xlab = "Treatment", ylab = "Frequency", col = c("Red", "Yellow", "Lightblue"), legend = rownames(counts), args.legend = list(x = "top"), beside = T)       

#均值条形图
states <- data.frame(state.region, state.x77)
head(states)
head(state.region)
head(state.x77)
#根据州分组
Mean <- aggregate(states$Illiteracy, by = list(state.region), FUN = mean)
#按照文盲率平均值从低到高排序
means <- Mean[order(Mean$x),]
means
barplot(means$x, names.arg = means$Group.1, col = "Lightgreen", cex.names = .8, horiz = T)
title("Mean Illiteracy Rate")

#棘状图(每个条形的高度为1，即每一段的高度表示比例)
library(vcd)
attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main = "Spine Example")
detach(Arthritis)
#棘状图方法二
library(vcd)
attach(Arthritis)
spine(Treatment ~ Improved, data = Arthritis)
detach(Arthritis)
