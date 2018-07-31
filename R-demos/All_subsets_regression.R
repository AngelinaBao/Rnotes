library(leaps)
leap <- regsubsets(Murder ~ Population + Illiteracy + Income + Frost, data = states, nbest = 4)
plot(leap, scale = "adjr2")

library(car)
subsets(leap, statistic = "cp", main = "Cp Plot for All Subsets Regression")
abline(1,1, lty = 2, col = "red")
