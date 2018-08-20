fit <- lm(weight ~ height, data = women)
summary(fit)
AIC(fit)
plot(women$height, women$weight,
     main = "Height to Weight",
     xlab = "Height",
     ylab = "Weight")
abline(fit, col = "Darkblue", lwd = 2)
#拟合出的直线看起来还行，但是会发现如果用曲线会更吻合，所以再次调整提高回归精度

fit2 <- lm(weight ~ height + I(height^2), data = women)
summary(fit2)
AIC(fit2)
plot(women$height, women$weight,
     main = "Newplot of Height VS Weight",
     xlab = "Height",
     ylab = "Weight")
lines(women$height,fitted(fit2))
#可以看到这个模型吻合得特别好，而且ACI值较上一个模型显著减小，从R^2、P值也可
#以看出来这个模型更优