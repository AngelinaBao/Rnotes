rm(list = ls())
gc()
#单因素方差分析
library(multcomp)
data(cholesterol, package = "multcomp")
attach(cholesterol)
head(cholesterol)
table(cholesterol)
class(cholesterol)
table(trt)
aggregate(response, by = list(trt), FUN = mean)
aggregate(response, by = list(trt), FUN = sd)
fit <- aov(response ~ trt)
summary(fit)
library(gplots)
plotmeans(response ~ trt, xlab = "Treatment", ylab = "Response",
          main = "Mean Plot \nwith 95% CI")
detach(cholesterol)
#多重均值比较
#Method 1
TukeyHSD(fit)
par(las = 2) #使轴标签水平
par(mar = c(5,8,4,2)) #增大边界
plot(TukeyHSD(fit))
#Method 2
library(multcomp)
par(mar = c(5,4,6,2))
tuk <- glht(fit, linfct = mcp(trt = "Tukey"))
plot(cld(tuk, .05), col = "lightgrey") #cld设置显著水平
#有相同字母的组说明差异不显著，1time和2times差异不显著，1time和4times差异显著
#假设检验
#正态性检验
library(car)
qqPlot(lm(response ~ trt, data = cholesterol), simulate = T, main = "QQ Plot")
#当simulate=TRUE时， 95%的置信区间将会用参数自助法生成
#qqPlot要用lm()拟合
#数据落在95%的置信区间内，说明满足正态性假设
#齐方差性检验
bartlett.test(response ~ trt, data = cholesterol)
#p=0.9653 说明五组的方差并无显著不同
#齐方差性对离群点非常敏感，所以要检查是否存在离群点
outlierTest(fit)
#结果说明不存在离群点(p>1时产生NA)
#因此，根据Q-Q图、bartleet、outlierTest检验的结果，该数据似乎用ANOVA模型拟合
#得很好