#DT[i, j, by] -- Take DT, subset rows use i, then caculate j grouped by 'by'
library(data.table)
set.seed(45L)
DT <- data.table(V1 = c(1L, 2L), 
                 V2 = letters[1:3],
                 V3 = round(rnorm(4), 2),
                 V4 = 1:12)
# Subsetting rows using i
DT[3:5,] #select third to fifth row
DT[3:5] # same as above

DT[V2 == "a"]
DT[V2 %in% c("a", "c")]

# Manipulating on columns in j
DT[, V2]  # select 1 col in j, and it returns a vector
DT[, .(V2, V3)] #select several cols inj, and it returns a data.table
# .() is an alias to list().If .() is used, the returned value is a 
#data.table. If .() is not used, the result is a vector.

#call function in j
DT[, sum(V1)]
DT[, .(sum(V1), sd(V3))]
#assigning colnames to computed columns
DT[, .(sum.v1 = sum(V1), sd_V3 = sd(V3))]

#Multiple expressions can be wrapped in curly braces.
DT[, {print(V2)
  plot(V3)
  NULL}]


# Doing j by group
DT[, .(sum_V4 = sum(V4)), by = V1]
DT[, .(sum_V4 = sum(V4)), by = .(V1, V2)]
#call functions in by
DT[, .(sum_V4 = sum(V4)), by = sign(V1-1)]
#assign new colnames in by
DT[, .(sum_V4 = sum(V4)), by = .(V1_1 = sign(V1-1))]
#grouping only a subset by specifying i
DT[1:5, .(sum_V4 = sum(V4)), by = V1]
#use .N to get total number of observations of each group
DT[, .N, by = V1] #count the number of rows for every group in V1

#Adding/updating columns by reference in j using :=
#Watch Out: extra assign is a redundant DT <- DT[...]
DT[, V1 := round(exp(V1), 2)] # V1 changed into what is after :=
DT[, ":=" (V1 = round(exp(V1), 2), V2 = LETTERS[4:6])]
DT[, ":=" (V1 = round(exp(V1), 2), V2 = LETTERS[4:6])][] #[] will display the result on screen

