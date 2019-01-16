library(tidyverse)

# Tidy Data
# Spreading and gathering

# Gathering
table1 <- tibble(
  country = c("America", "Brizal", "British"),
  '1999' = c(345, 6785, 33321),
  '2000' = c(2000, 443211, 678392)
)
table2 <- tibble(
  country = c("America", "Brizal", "British", "China"),
  '1999' = c(34521, 678521, 3453321, 4782143),
  '2000' = c(2001210, 44133211, 678356392, 10000000)
)

# Tidy table1 & table2, then join them

table1 <- table1 %>% 
  gather('1999', '2000', key = "year", value = "case")
table2 <- table2 %>%
  gather('1999', '2000', key = "year", value = "population")

left_join(table1, table2)
right_join(table1, table2)


# Spreading
#Spreading is the opposite of gathering. You use it when an observation is 
#scattered across multiple rows

table3 <- tibble(
  country = c("America", "America", "America", "America", "Brizal", "Brizal", "Brizal", "Brizal"),
  year = c(1999, 1999, 2000, 2000, 1999, 1999, 2000, 2000),
  type = c("cases", "population", "cases", "population", "cases", "population", "cases", "population"),
  count = c(2314, 2789114, 3000, 67589322, 1829, 5723116, 1000, 2311111)
)
table3 <- table3 %>%
  spread(key = type, value = count)



