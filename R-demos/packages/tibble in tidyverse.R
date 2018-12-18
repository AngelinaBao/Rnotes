library(tidyverse)
tibble(x = letters)
tibble(x = 1:3, y = list(1:5, 2:17, 3:7))
names(data.frame('crazy name' = 1))
names(tibble('crazy name' = 1))
tibble(x = 1:5, y = x^2) # it evaluates sequentially
data.frame(x = 1:5, y = x^2) # this is wrong for data.frame

df1 <- data.frame(x = 1:3, y = 3:1)
class(df1[, 1:2])
class(df1[, 1])

df1 <- tibble(x = 1:3, y = 3:1)
class(df1[, 1:2])
class(df1[, 1])

#Tibbles are also stricter with $
df <- data.frame(abc = 1)
df$b
df <- tibble(abc = 1)
df$b

tb <- tibble(
  ':)' = "smile",
  ' ' = "space",
  '2000' = "number"
)

tribble(
  ~x, ~y, ~z,
  #--/--/----
  "a", 3, 2.1,
  "b", 7, 0.9
)

library(lubridate)
date <- tibble(
  a = now() + runif(1e3) * 86400,
  b = today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  f = sample(letters, 1e3, replace = TRUE)
)

# test if the object is a tibble
is.tibble(mtcars)

df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

df <- tibble(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]
df[[2]]
df$xyz


var <- "mpg"
df <- tibble(mpg = 1:3, abc = 6:8)
df[[var]] # Right !
df$var #it's wrong

df <- tibble(
  '1' = 1:4,
  '2' = 3:6
)
df$`1`
df[[1]]
ggplot(df, aes(df$`1`, df$`2`)) +
  geom_point()
ggplot(df, aes(df[[1]], df[[2]])) +
  geom_point(color = "red") +
  labs(x = "x", y = "y")

df$'3' = df$`2`/df$`1`

a = c("Skip", "Skip1", "Skip2")
b = c(0.213, 0.564, 0.42)
enframe(c(a, b))
enframe(c(Skip = 0.213, Skip1 = 0.564, Skip2 = 0.42))
options(tibble.print_min = Inf)

