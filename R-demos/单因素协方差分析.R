data(litter, package = "multcomp")
head(litter)
attach(litter)
table(dose) #0剂量时产崽最多
aggregate(weight, by = list(dose), FUN = mean) #零剂量组幼崽体重均值最大
colnames(litter)
fit <- aov(weight ~ gesttime + dose)
summary(fit) #ANOVA的F检验表明：怀孕时间与幼崽出生体重相关；控制怀孕时间，药物
#剂量与出生体重相关
#由于使用了协变量，你可能想获取调整的组均值，即去除协变量效应后的组均值
library(effects)
effect("dose", fit) #调整的均值与aggregate计算的未调整的均值类似
#剂量的F检验只说明了不同处理方式幼崽的出生体重均值不同，但没有说明哪一种处理
#方式与其它方式不同
#与单因素方差分析类似，我们使用multcomp包对所有均值进行成对比较
#multcomp包可以对用户自定义的均值假设进行检验
#假设我们想研究未用药条件与其它三种用药条件是否影响不同
library(multcomp)
contrast <- rbind("no drug vs .drug" = c(3, -1, -1, -1))
#对照c(3,-1,-1,-1)设定第一组和其它三组的均值进行比较
summary(glht(fit, linfct = mcp(dose = contrast)))
#假设检验的t值(2.581)在p<0.05水平下显著，所以得出未用药组比其它组出生体重高的结论

#假设检验，ANCOVA假定正态性、同方差性以及回归斜率相同
#正态性检验
library(car)
qqPlot(lm(weight ~ gesttime + dose, data = litter), simulate = T,
       main = "Q-Q Plot")
#数据落在95%置信区间内，说明满足正态性假设
#ANOVA模型包含怀孕时间*剂量的交互项时，可对回归斜率的同质性进行检验
library(multcomp)
fit2 <- aov(weight ~ gesttime * dose, data = litter)
summary(fit2)
#gesttime和dose的交互项不显著(p>0.1)，说明gesttime和因变量的线性函数与dose和因变量的
#线性函数不相交，也就支持斜率相等的假设
#如果不支持斜率相等的假设，可以使用不需要假设回归斜率同质性的非参数ANOVA方法，
#sm包中的sm.anova()函数可以实现此方法

#结果可视化
#HH包中的ancova()可以绘制因变量、协变量和因子之间的关系图
library(HH)
ancova(weight ~ gesttime + dose, data = litter)
#可以看出，用怀孕时间来预测出生体重的回归线相互平行，只是截距不同，出生体重随
#怀孕时间的增加而增加，0剂量组出生体重最大，5剂量组出生体重最小
#若用ancova(weight ~ gesttime*dose)，生成的图形将允许斜率和截距项依据组别而
#发生变化，这对可视化那些违背回归斜率同质性的实例非常有用
ancova(weight ~ gesttime*dose, data = litter) #本例满足回归斜率同质性
detach(litter)
