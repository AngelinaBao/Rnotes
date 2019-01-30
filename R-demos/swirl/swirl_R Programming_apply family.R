# lapply and sapply
head(flags)
dim(flags)
viewinfo()
class(flags)
#apply the class() function to each column of the flags dataset
cls_list <- lapply(flags, class) # just like str(flags)
cls_list
class(cls_list)
as.character(cls_list)
# use sapply("simplify apply")
cls_vect <- sapply(flags, class)
class(cls_vect)
#In general, if the result is a list where every element is of length one, then sapply()
#returns a vector. If the result is a list where every element is a vector of the same
#length (> 1), sapply() returns a matrix. If sapply() can't figure things out, then it
#just returns a list, no different from what lapply() would give you.
sum(flags$orange)
flag_colors <- flags[, 11:17]
head(flag_colors)
lapply(flag_colors, sum)
sapply(flag_colors, sum)
sapply(flag_colors, mean)
flag_shapes <- flags[, 19:23]
lapply(flag_shapes, range)
shape_mat <- sapply(flag_shapes, range)
shape_mat
class(shape_mat)

unique(c(3, 4, 5, 5, 5, 6, 6))
unique_vals <- lapply(flags, unique)
unique_vals
sapply(unique_vals, length)
sapply(flags, unique)
lapply(unique_vals, function(x) x[2])

##################################
# vapply and tapply
sapply(flags, unique)
#Whereas sapply() tries to 'guess' the correct format of the result, vapply() allows you
#to specify it explicitly. If the result doesn't match the format you specify, vapply()
#will throw an error, causing the operation to stop. This can prevent significant
#problems in your code that might be caused by getting unexpected return values from sapply()
vapply(flags, unique, numeric(1))
ok()
sapply(flags, class)
vapply(flags, class, character(1)) #The 'character(1)' argument tells R that we expect
#the class function to return a character vector of length 1 when applied to EACH column
# of the flags dataset

# tapply()
#As a data analyst, you'll often wish to split your data up into groups based on the
#value of some variable, then apply a function to the members of each group. The next
#function we'll look at, tapply(), does exactly that.
?tapply
table(flags$landmass)
viewinfo()
table(flags$animate)
tapply(flags$animate, flags$landmass, mean) #caculate prop of animate group by landmass
tapply(flags$population, flags$red, summary)
tapply(flags$population, flags$landmass, summary)
