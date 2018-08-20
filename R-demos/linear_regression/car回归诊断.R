library(car)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
qqPlot(fit, lablels = row.names(states), id.method = "identify",
       simulate = T, main = "Q-Q Plot")
states["Nevada",]
fitted(fit)["Nevada"]
residuals(fit)["Nevada"]
rstudent(fit)["Nevada"]
#独立性检验
durbinWatsonTest(fit) #p值不显著（p=0.246）说明无自相关性，误差项之间独立。
#滞后项（lag=1）表明数据集中每个数据都是与其后一个数据进行比较的。
#线性检验
crPlots(fit)
#同方差性检验
ncvTest(fit) #零假设为误差方差不变；计分检验不显著(p=0.19)说明满足方差不变假设
spreadLevelPlot(fit)
#多重共线性判断
vif(fit)
sqrt(vif(fit)) > 2
