#双因素方差分析
head(ToothGrowth)
tail(ToothGrowth)
attach(ToothGrowth)
table(supp, dose) #各单元中各样本大小相等，表明是均衡设计
aggregate(len, by = list(supp, dose), FUN = mean) #求各组的均值
aggregate(len, by = list(supp, dose), FUN = sd) #求各组的标准差
dose <- factor(dose) 
#将剂量转化为因子，这样aov()就会将它当做分组变量，而不是一个数值协变量
fit <- aov(len ~ supp * dose)
summary(fit) #结果表明，主效应(supp和dose)和交互效应都很显著
#结果可视化
#interaction.plot()可以展示双因素方差分析的交互效应
interaction.plot(dose, supp, len,
                 type = "b",
                 col = c("red", "blue"),
                 pch = c(16, 18),
                 main = "Interaction Plot of Dose& Supp")
#结果表明，随剂量的增加，牙齿长长，0.5和1剂量时，orange比VC更促进牙齿生长
#其它交互方法：plotmeans() & interaction2Wt()
library(gplots)
plotmeans(len ~ interaction(supp, dose, seq = " "),
          connect = list(c(1,3,5), c(2,4,6)),
          col = c("red", "darkgreen"),
          main = "Interaction Plot with 95% CIs",
          xlab = "Treatment and Dose Combination")
library(HH)
interaction2wt(len ~ supp * dose)
#三种绘图方法中，更推荐HH包中的interaction2wt()函数，因为它能展示任意复杂
#度设计（双因素方差分析、三因素方差分析等）的主效应（箱线图）和交互效应。
#该设计是均衡的，故而不用担心效应顺序的影响