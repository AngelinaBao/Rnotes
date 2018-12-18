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
install.packages("doBy")
library(doBy)
summaryBy(mpg+hp+wt ~ am, data = mtcars, FUN = myfun)
library(psych)
car <- c("mpg","hp","wt")
describeBy(mtcars[car], list(am = mtcars$am))
#summaryBy可以指定函数，而describeBy不可以，所以前者更适用