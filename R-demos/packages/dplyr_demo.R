library(dplyr)
head(mtcars)
dim(mtcars)

#select: return a subset of the columns of a data frame
head(select(mtcars, 1:5)) # select 1 to 5 columns of mtcars

names(mtcars)[1:3]
head(select(mtcars, mpg:disp)) 
#you can refer to columns in the data frame directly without using the $ operator

head(select(mtcars, -(mpg:disp)))
# use "-" to exclude the columns
#Equivalent Base R
i <- match("mpg", names(mtcars))
j <- match("disp", names(mtcars))
head(mtcars[, -(i:j)])


#filter: extract a subset of rows from a data frame based on logical conditions
mtcar_f <- filter(mtcars, mpg > 16)
head(select(mtcar_f, 2:4, mpg), 10)
head(select(mtcar_f, 1:4 ), 10) #just like the last column, only "mpg"'s position is different
head(select(mtcar_f, 2:4, 1), 10) 
all.equal(head(select(mtcar_f, 2:4, mpg), 10), head(select(mtcar_f, 2:4, 1), 10))

mtcar_f1 <- filter(mtcars, mpg > 16 & hp > 100)
head(select(mtcar_f1, 2:3, 1, 4), 10)
head(select(mtcar_f1, 1:4), 10)

#arrange: reorder rows of a data frame
mtcar_a <- arrange(mtcars, carb)
head(select(mtcar_a, carb, mpg:disp), 4)
tail(select(mtcar_a, carb, mpg:disp), 4)

#Columns can be arranged in descending order too.
mtcar_a1 <- arrange(mtcars, desc(carb))
head(select(mtcar_a1, carb, mpg, disp), 3)
tail(select(mtcar_a1, carb, mpg, disp), 3)

mtcar_a12 <- arrange(mtcars, desc(carb, cyl)) # both desc carb and cyl 
head(select(mtcar_a12, carb, cyl, mpg, hp), 3)
mtcar_a13 <- arrange(mtcars, carb, desc(cyl)) # asc by carb and desc by cyl
head(select(mtcar_a13, carb, cyl, mpg, hp), 10)
tail(select(mtcar_a13, carb, cyl, mpg, hp), 10)

#mutate: add new variables/columns or transform existing variables
mtcar_m <- mutate(mtcars, mpg_sub = mpg - mean(mpg, na.rm = TRUE))
head(select(mtcar_m, mpg, mpg_sub))

#group_by  summarise() is typically used on grouped data created by group_by(). 
#The output will have one row for each group.
mtcar_s <- mutate(mtcars, mpg_new = factor(1 * (mpg >20), labels = c("slow", "fast")))
slowfast <- group_by(mtcar_s, mpg_new)
summarise(slowfast, mpg_mean = mean(mpg, na.rm = TRUE), hp_max = max(hp), wt_median = median(wt))
