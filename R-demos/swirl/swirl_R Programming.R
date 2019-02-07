library(swirl)
swirl()
Angelina

# Workspace and Files
setwd("testdir") # create a new directory named 'testdir'
file.create("mytest.R") #create R file
list.files()  # display all files
file.exists("mytest.R") # check if a file exists
file.info("mytest.R") # view the infomation of R file
file.info("mytest.R")$mode # view specific info of R file
file.rename("mytest.R", "mytest2.R") # change file name
file.copy("mytest2.R", "mytest3.R")  #copy a file
file.path("mytest3.R")
file.path("folder1", "folder2")
?dir.create
dir.create(file.path("testdir2", "testdir3"), recursive = TRUE) # create file and subfile
setwd(old.dir)

# Sequences of Numbers
1:20
pi:10
15:1
?':'
seq(1, 20)
seq(0, 10, by = 0.5)
my_seq <- seq(5, 10, length = 30)
length(my_seq)
1:length(my_seq)
seq(along.with = my_seq)
seq_along(my_seq)
rep(0, times = 40)
rep(c(0, 1, 2), times = 10)
rep(c(0, 1, 2), each = 10)

#Vectors
num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
tf
num_vect >= 6
my_char <- c("My", "name", "is")
my_char
paste(my_char, collapse = " ") # separte the result by space
my_name <- c(my_char, "Angelina")
my_name
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ")
paste(1:3, c("x", "Y", "Z"), sep = "")
paste(LETTERS, 1:4, sep = "-")

# Missing Values
x <- c(44, NA, 5, NA)
x * 3
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y, z), 100)
my_na <- is.na(my_data)
my_na
z
my_data == NA
sum(my_na)
my_data
0 / 0
Inf / Inf
Inf - Inf

#Subsetting Vectors
#three types of index vectors -- logical, positive integer, and negative integer
x[1:10]
x[is.na(x)]
y <- x[!is.na(x)]
y[y > 0]
x[x > 0]
x[!is.na(x) & x > 0]
x[c(3, 5, 7)] #subsetting the 3rd, 5th, 7th element of x
x[0] # R uses 'one-based indexing'
x[3000] # x only has 40 numbers, so get NA
x[c(-2, -10)] # get x except the 2nd, 10th numbers
x[-c(2, 10)] # same as above
vect <- c(foo = 11, bar = 2, norf = NA)
names(vect)
vect2 <- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf")
identical(vect, vect2)
vect["bar"]
vect[c("foo", "bar")]

#Matrices and Data Frames
my_vector <- 1:20
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4, 5)
dim(my_vector)
attributes(my_vector)
my_vector
class(my_vector)
my_matrix <- my_vector
my_matrix2 <- matrix(1:20, nrow = 4)
identical(my_matrix, my_matrix2)
patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix)
my_data <- data.frame(patients, my_matrix)
class(my_data)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames

########
#Logic
(FALSE == TRUE) == FALSE
6 == 7
6 < 7
10 <= 10
5 != 7
!(5 == 7)
FALSE & FALSE
# You can use the `&` operator to evaluate AND across a vector. The `&&` version of AND
# only evaluates the first member of a vector
TRUE & c(TRUE, FALSE, FALSE) # left 'TRUE' is recycled
TRUE && c(TRUE, FALSE, FALSE) # left 'TRUE' only compared with first element of the right vector
TRUE | c(TRUE, FALSE, FALSE)
TRUE || c(TRUE, FALSE, FALSE)
# AND operators are evaluated before OR operators
5 > 8 || 6 != 8 && 4 > 3.9 # TRUE, first AND, then OR
#logical expressions
isTRUE(6 > 4)
identical('twins', 'twins')

# The xor() function stands for exclusive OR. If one argument evaluates to TRUE and one
# argument evaluates to FALSE, then this function will return TRUE, otherwise it will 
# return FALSE.
# exclusive OR : two sides are same then get 1 (TRUE); two sides are different, get 0 (FALSE)
xor(5 == 6, !FALSE)
ints <- sample(10)
ints
ints > 5
#The which() function takes a logical vector as an argument and returns the indices of 
#the vector that are TRUE. For example which(c(TRUE, FALSE, TRUE)) would return the 
#vector c(1, 3)
which(ints > 7)
# Like the which() function, the functions any() and all() take logical vectors as 
#their argument. The any() function will return TRUE if one or more of the elements 
#in the logical vector is TRUE. The all() function will return TRUE if every element 
#in the logical vector is TRUE.
any(ints < 0)
all(ints > 0)

#Looking at data
ls()
class(plants)
dim(plants)
nrow(plants)
ncol(plants)
object.size(plants)
names(plants)
head(plants)
head(plants, 10)
tail(plants, 15)
summary(plants)
table(plants$Active_Growth_Period)
str(plants)


##########################################
# Simulation
?sample
sample(1:6, 4, replace = TRUE)
sample(1:20, 10)
LETTERS
sample(LETTERS)
flips <- sample(c(0, 1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips
sum(flips)
?rbinom
# Each probability distribution in R has an r*** function (for "random"), a d*** function (for
#"density"), a p*** (for "probability"), and q*** (for "quantile").
rbinom(1, size = 100, prob = 0.7)
flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2
sum(flips2)
?rnorm
rnorm(10)
rnorm(10, mean = 100, sd = 25)
?rpois
rpois(5, 10) # Generate 5 random values from a Poisson distribution with mean 10
my_pois <- replicate(100, rpois(5, 10)) # perform this operation 100 times
cm <- colMeans(my_pois)
hist(cm)

########################
# Date and Times
#Internally, dates are stored as the number of days since 1970-01-01
d1 <- Sys.Date()
class(d1)
unclass(d1)
d1
d2 <- as.Date("1969-01-01")
unclass(d2)
t1 <- Sys.time()
t1
class(t1)
unclass(t1)
t2 <- as.POSIXlt(Sys.time())
class(t2)
t2
unclass(t2)
str(unclass(t2))
t2$min
weekdays(d1)
months(t1)
quarters(t2)

# strptime() converts character vectors to POSIXlt. In that sense, it is similar to
# as.POSIXlt(), except that the input doesn't have to be in a particular format (YYYY-MM-DD).
t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M")
t4
class(t4)
Sys.time() > t1
Sys.time() - t1
difftime(Sys.time(), t1, units = 'days')
# lubridate package for dates and times


#####################
#Base Graphics
# http://varianceexplained.org/r/teach_ggplot2_to_beginners/
data(cars)
help(cars)
head(cars)
plot(cars)
help(plot)
plot(x = cars$speed, y = cars$dist)
plot(x = cars$dist, y = cars$speed)
plot(x = cars$speed, y = cars$dist, xlab = "Speed")
plot(x = cars$speed, y = cars$dist, ylab = "Stopping Distance")
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
plot(cars, main = "My Plot")
plot(cars, sub = "My Plot Subtitle")
plot(cars, col = 2)
plot(cars, xlim = c(10, 15))
plot(cars, pch = 2)

data(mtcars)
?boxplot
boxplot(mpg ~ cyl, data = mtcars)
hist(mtcars$mpg)
# more for base graphics: http://www.ling.upenn.edu/~joseff/rstudy/week4.html
