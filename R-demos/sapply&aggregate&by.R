myfun <- function(x, na.omit = FALSE){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n-3
  return(c(n = n, mean = m, sd = s, skew = skew, kurt = kurt))
  
}
car <- c("mpg","hp","wt")
sapply(mtcars[car], myfun)

dstats <- function(x) sapply(x, myfun)
aggregate(mtcars[car], by = list(am = mtcars$am), myfun)
by(mtcars[car], mtcars$am, dstats)

#先定义一个描述性统计的函数，然后直接用sapply可以得出一系列统计量，但是sapply
#是不能分组的；aggregate可以在第三个参数直接使用自定义函数，但是结果呈现的模
#式不太友好，by()需要把自定义函数再定义到函数中，然后再使用(by()中的FUN参数需
#要使用在数据框上，而自定义函数myfun只能作用在单个向量上，所以需要用sapply再
#定义一个函数。）呈现效果很棒。