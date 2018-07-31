#条形图
library(vcd)
data("Arthritis")
plot(Arthritis$Improved, main = "Barplot of Improved", xlab = "Improved Status",
     ylab = "Frequency", col = "Lightblue", horiz = T)
counts <- table(Arthritis$Improved, Arthritis$Treatment)
barplot(counts, col = c("Yellow", "Red", "Lightblue"), main = "Second Barplot", xlab = "Treatment", ylab = "Improved", legend.text = c("None", "Some", "Marked"), args.legend = "topleft")
barplot(counts, main = "Another Barplot", xlab = "Treatment", ylab = "Improved", col = c("Red", "Yellow", "Lightblue"), legend = rownames(counts), args.legend = list(x = "top"), beside = T)       

states <- data.frame(state.region, state.x77)
head(states)
head(state.region)
head(state.x77)
Mean <- aggregate(states$Illiteracy, by = list(state.region), FUN = mean)
means <- Mean[order(Mean$x),]
means
barplot(means$x, names.arg = means$Group.1, col = "Lightgreen", cex.names = .8, horiz = T)
title("Mean Illiteracy Rate")
par(las = 2)

#棘状图
library(vcd)
attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main = "Spine Example")
detach(Arthritis)