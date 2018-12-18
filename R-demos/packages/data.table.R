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
DT[, ":=" (V1 = round(exp(V1), 2), V2 = LETTERS[4:6], V5 = letters[2:4])][] #[] will display the result on screen
#remove a column also can use :=
DT[, V5 := NULL]
DT[, ":=" (V1 = NULL, V5 = NULL)]
DT
#Delete several cols together
Cols.choose = c("V1", "V5")
DT[, Cols.choose := NULL] # delete the col names Cols.choose, and this data.table don't has corresponding col, will get warning
DT[, (Cols.choose) := NULL]


# Indexing and keys
setkey(DT, V2)
haskey(DT) # check if a data.table has key
setkey(DT, NULL) # remove key

setkey(DT, V2)
DT["a"] #returns all the rows where key col(V2) has letter 'a', a little like attach()
DT[c("a", "c")] # returns all the rows where key col has 'a'&'c'
DT[V2 %in% c("a", "c")] # same as above, but above one is better

#The mult argument is used to control which row that i matches to isreturned, default is all.
DT["a", mult = "first"] #Returns first row of all rows that match the value A in the key column (V2).
DT[c("a", "c"), mult = "last"]

#nomatch argument is used to control the value if no match situation
#default is NA, but can be changed to 0
#means no rows will be returned for that non-matched row of i.
DT[c("a", "d")]
DT[c("a", "d"), nomatch = 0]

#by=.EACHI allows to group by each subset of known groups in i. 
#A key needs to be set to use by=.EACHI.
DT[c("a", "c"), sum(V4)]
DT[c("a", "c"), sum(V4), by = .EACHI]

#Any number of columns can be set as key using setkey(). This way rows can 
#be selected on 2 keys which is an equijoin.
setkey(DT, V1, V2)
DT[.(2, "c")] # select cols in which V1=2 & V2=c
DT[.(2, c("a", "c"))] # select cols in which V1=2 & V2=a or V2=c
DT[.(c(2, 1), "b")]
DT[.(1:2, "a")]


#advanced data table operations
# .N contains the number of rows or the last row
DT[.N] # return the last row
DT[.N-1] # return the penultimate row
DT[.N-2]
# usable in j
DT[, .N] #return the number of rows
DT[, .N-1] 

#.() is an alias to list() and means the same. The .() notation is not
#needed when there is only one item in by or j.
DT[, .(V2, V3)]
DT[, list(V2, V3)] # same as above
DT[, sum(V4), by = .(V1, V2)] #usage in by, by 'by', calculate j

# .SD is a data.table and holds all the values of all columns, except the 
#one specified in by. It reduces programming time but keeps
# readability. .SD is only accessible in j.
DT[, print(.SD), by = V2]
DT[, .SD[c(1, .N)], by = V2] #Selects the first and last row grouped by column V2.
DT[, .SD[c(1, 3)], by = V2] # select 1&3 rows after group by V2
DT[, lapply(.SD, sum), by = V2]

#.SDcols is used together with .SD, to specify a subset of the columns of 
#.SD to be used in j.
DT[, lapply(.SD, sum), by = V2, .SDcols = c("V3", "V4")]
#.SDcols can be the result of a function call.
DT[, lapply(.SD, sum), by = V2, .SDcols = paste0("V", 3:4)] #same as above


#Do 2 (or more) sets of statements at once by chaining them in one statement. This
#corresponds to having in SQL.
DT <- DT[, .(sum.V4 = sum(V4)), by = V1]
DT[sum.V4 > 40]
DT[, .(sum.V4 = sum(V4)), by = V1][sum.V4 > 40]
DT[, .(sum.V4 = sum(V4)), by = V1][order(-V1)]


#set() family
#setnames() is used to create or update column names by reference.
setnames(DT, "old", "new")
setnames(DT, "V1", "Number")
DT
setnames(DT, c("V2", "V3"), c("Rank", "Rating"))[]

#setcolorder() is used to reorder columns by reference.
setcolorder(DT, "neworder")
setcolorder(DT, c("V4", "V1", "V3", "V2"))
