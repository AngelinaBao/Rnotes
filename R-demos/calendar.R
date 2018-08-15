library(lubridate)
n <- c(0:1094)
d <- as.Date("20181231", "%Y %m %d") - n
y <- year(d)
mon <- month(d)
date <- mday(d)
wd <- wday(d + 1)
filedate1 <- format(d, format = "%Y%m%d")
filedate2 <- format(d, format = "%Y%m")
filedate3 <- format(d, format = "%Y-%m-%d")
wk <- week(d + 2)
wk[y == 2018 & mon == 12 & wk == 1] <- 53
wkdate <- data.frame(d, n, y, mon, date, wd, filedate1, filedate2, filedate3, wk)
View(wkdate)