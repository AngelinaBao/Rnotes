library(data.table)
DF <- data.table(id=1:5, code=c("abc", "abd", "abd", "apq", "apq"), valA=c(0.2, 1.3, 2.4, 0.9, 1.1),
                 valB=c(3, 4.5, 6.5, 7.2, 9.1))
DF
DF[code != "abd", sum(valA)]
DF[code != "abd", .(sumA = sum(valA), sumB = sum(valB)), by = id]
DF[code == "abd", valA := NA];DF
DF[id == 2]
DF[, valA]
DF[, .(valA, valB)]
DF[, mean(valB)]

DT <- data.table(id = c(1, 2, 2), code = c("abc", "abd", "abd"), mul = c(5, 8, 2))
setkey(DF, id, code)
setkey(DT, id, code)
setkey(DF, NULL)
setkey(DT, NULL)
haskey(DF)
DF[DT, on = .(id, code), valA := valA * mul]
DF
DT[DF, on = .(id, code), mul := valA * mul]
x <- runif(100000000)
sort1 <- data.table::fsort(x)
sort0 <- base::sort(x, method = "quick")
identical(sort1, sort0)
system.time(data.table::fsort(x))
system.time(base::sort(x, method = "quick"))
DT[DF, on = .(id, mul < valB, mul > valA), mul := valB * mul]
