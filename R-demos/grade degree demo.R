#将学生的各科考试成绩组合为单一的成绩衡量指标，基于相对名次
#（前20%、下20%、等等）给出从A到F的评分，根据学生姓氏和名字的首字母对花名册进行排序。
rm(list = ls())
gc()
getwd()
setwd("G:/数据分析/R-Demos")
options(digits=2)
Student <- c("John Davis", "Angela Williams", "Bullwinkle Moose",
             "David Jones", "Janice Markhammer", "Cheryl Cushing",
             "Reuven Ytzrhak", "Greg Knox", "Joel England",
             "Mary Rayburn")
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(Student, Math, Science, English, stringsAsFactors = F)
head(roster)
#计算标准得分
z <- scale(roster[,2:4])
score <- apply(z, 1, mean)
roster <- cbind(roster, score)
#计算分数等级
y <- quantile(score, c(.8, .6, .4, .2))
roster$grade[score >= y[1]] <- "A"
roster$grade[score < y[1] & score >= y[2]] <- "B"
roster$grade[score < y[2] & score >= y[3]] <- "C"
roster$grade[score < y[3] & score >= y[4]] <- "D"
roster$grade[score < y[4]] <- "F"
#抽取姓氏和名字
name <- strsplit(roster$Student, " ")
Lastname <- sapply(name, "[", 2)  #"["是一个可以提取某个对象的一部分的函数——在这里它是用来提取列表name各成分中的第一
#个或第二个元素的
Firstname <- sapply(name, "[", 1)
roster <- cbind(Lastname, Firstname, roster[, -1])
roster <- roster[order(Lastname, Firstname),]
roster

