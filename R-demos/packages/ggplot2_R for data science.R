<<<<<<< HEAD
install.packages("tidyverse")
library(tidyverse)
library(data.table)

# mpg:hwy-highway miles per gallon  displ-engine displacement, in litres
ggplot(data=mpg) + geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cyl))

#ae(color/size/shape/alpha)
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year, size = year))

# stroke used for shape 21-24 and defined the size of outer cirle 
sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) + 
  geom_abline(slope = -1, intercept = 6, colour = "white", size = 6) + 
  geom_point(shape = 21, fill = "red") +
  scale_size_identity()
 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ <5))

# below is wrong! "+" should be placed at the end of a line 
ggplot(data = mpg)
  + geom_point(mapping = aes(x = displ, y = hwy, color = displ <5))

#The first argument of facet_wrap() should be a formula, which you create
#with ~ followed by a variable name (here "formula" is the name of a data structure 
#in R, not a synonym for "equation"). The variable that you pass to facet_wrap() should be discrete.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

#To facet your plot on the combination of two variables, add facet_grid() to your plot call.
#this  time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#If you prefer to not facet in the rows or columns dimension, use a . instead of a variable name
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl, nrow = 1)
#above two just the same plots!

ggplot(data = mpg) +
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

par(mfrow = c(2,2))
# same data, different plots
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = F)

#To display multiple geoms in the same plot, add multiple geom functions to ggplot()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#another way to get same plot above
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#If you place mappings in a geom function, ggplot2 will treat them as local mappings for the exact layer.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

#You can use the same idea to specify different data for each layer
mpp <- as.data.table(mpg)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = mpp[class == "subcompact"], se = FALSE)

#OR (differs in the way to get mpg subset)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
               geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#the syntax equals one below
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv), se = FALSE)


# different syntax but same plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


#https://r4ds.had.co.nz/data-visualisation.html 3.6.1 exercise 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)

#Note that shapes 21-24 have both stroke colour and a fill. 
#The size of the filled part is controlled by size, the size of the stroke is controlled by stroke.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(fill = drv), shape = 21, color = "white", size = 5, stroke = 5)


#statistical transformations
#bar chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
#geom_bar use stat_count by default, so the syntax above equals the following
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

ggplot(data = diamonds) +
  geom_col(mapping = aes(x = cut, y = price))


#stat_ has corresponding geom_
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) +
  geom_pointrange(mapping = aes(ymin = min(depth), ymax = max(depth)))#didn't got stat_summary & geom_pointrange



#geom_bar ## group=1 then the sum prop is 1
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., fill = color))


#geom_bar fill/color: fill define the inner color, color define the outline color
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

#map the fill aesthetic to another variable
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

#he stacking is performed automatically by the position adjustment specified by the position argument. 
#If you don't want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill"

#position = "identity" will place each object exactly where it falls in the context of the 
#graph. This is not very useful for bars, because it overlaps them.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 0.2, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

#position = "fill" works like stacking, but makes each set of stacked bars the same height. 
#This makes it easier to compare proportions across groups.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill" )
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))#position defalut "stack" for geom_bar

#position = "dodge" places overlapping objects directly beside one another. 
#This makes it easier to compare individual values.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#position="jitter" in geom_point to avoid "overplotting"
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))#default position is "identity"
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#ggplot2 comes with a shorthand for geom_point(position = "jitter"): geom_jitter()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_jitter()


# Exercise 3.8.1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()   #overplotting
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")
#geom_jitter() is a shorthand of geom_point(position = "jitter")
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(width = 0.25)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(height = 0.25)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(width = 0.25, height = 0.25)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

#default position="dodge2" for geom_boxplot
ggplot(data = mpg, mapping = aes(x = class, y = hwy, color = class)) +
  geom_boxplot() 
ggplot(data = mpg, mapping = aes(x = class, y = hwy, color = class)) +
  geom_boxplot(position = "identity") # same as above



# Coordinate System
#coor_flip switches the x & y axes
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

ggplot(data = mpg, mapping = aes(x = class, fill = manufacturer)) +
  geom_bar(position = "dodge")
ggplot(data = mpg, mapping = aes(x = class, fill = manufacturer)) +
  geom_bar(position = "dodge") +
  coord_flip()

install.packages("maps")
county <- map_data("county")
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon()
#coord_quickmap sets the aspect ratio correctly for maps.
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_quickmap()


#coord_polar() uses polar coordinates. Polar coordinates reveal an interesting connection 
#between a bar chart and a Coxcomb chart.
# theme(aspect.ratio=1) makes the plot panel a square
# labs(x = NULL, y = NULL) remove the name of x&y axis
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
  
bar + coord_flip()
bar + coord_polar()


# 3.9.1 Exercise
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity)) +
  coord_polar() +
  labs(title = "Coxcomb Plot for diamonds by cut", caption = "(based on data from diamonds)")

#Map projections do not, in general, preserve straight lines, so this requires 
#considerable computation. coord_quickmap is a quick approximation that does preserve 
#straight lines. It works best for smaller areas closer to the equator.
install.packages("mapproj")
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_quickmap()
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_map()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()


=======
install.packages("tidyverse")
library(tidyverse)
library(data.table)

# mpg:hwy-highway miles per gallon  displ-engine displacement, in litres
ggplot(data=mpg) + geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = hwy, y = cyl))

#ae(color/size/shape/alpha)
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
ggplot(data=mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year, size = year))

# stroke used for shape 21-24 and defined the size of outer cirle 
sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) + 
  geom_abline(slope = -1, intercept = 6, colour = "white", size = 6) + 
  geom_point(shape = 21, fill = "red") +
  scale_size_identity()
 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ <5))


#The first argument of facet_wrap() should be a formula, which you create
#with ~ followed by a variable name (here "formula" is the name of a data structure 
#in R, not a synonym for "equation"). The variable that you pass to facet_wrap() should be discrete.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

#To facet your plot on the combination of two variables, add facet_grid() to your plot call.
#this  time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#If you prefer to not facet in the rows or columns dimension, use a . instead of a variable name
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl, nrow = 1)
#above two just the same plots!

ggplot(data = mpg) +
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

par(mfrow = c(2,2))
# same data, different plots
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = F)

#To display multiple geoms in the same plot, add multiple geom functions to ggplot()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#another way to get same plot above
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

#If you place mappings in a geom function, ggplot2 will treat them as local mappings for the exact layer.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

#You can use the same idea to specify different data for each layer
mpp <- as.data.table(mpg)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = mpp[class == "subcompact"], se = FALSE)

#OR (differs in the way to get mpg subset)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
               geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#the syntax equals one below
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv), se = FALSE)


# different syntax but same plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


#https://r4ds.had.co.nz/data-visualisation.html 3.6.1 exercise 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)

#Note that shapes 21-24 have both stroke colour and a fill. 
#The size of the filled part is controlled by size, the size of the stroke is controlled by stroke.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(aes(fill = drv), shape = 21, color = "white", size = 5, stroke = 5)


#statistical transformations
#bar chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
#geom_bar use stat_count by default, so the syntax above equals the following
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

ggplot(data = diamonds) +
  geom_col(mapping = aes(x = cut, y = price))


#stat_ has corresponding geom_
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) +
  geom_pointrange(mapping = aes(ymin = min(depth), ymax = max(depth)))#didn't got stat_summary & geom_pointrange



#geom_bar ## group=1 then the sum prop is 1
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., fill = color))


#geom_bar fill/color: fill define the inner color, color define the outline color
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

#map the fill aesthetic to another variable
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

#he stacking is performed automatically by the position adjustment specified by the position argument. 
#If you don't want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill"

#position = "identity" will place each object exactly where it falls in the context of the 
#graph. This is not very useful for bars, because it overlaps them.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 0.2, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

#position = "fill" works like stacking, but makes each set of stacked bars the same height. 
#This makes it easier to compare proportions across groups.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill" )
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))#position defalut "stack" for geom_bar

#position = "dodge" places overlapping objects directly beside one another. 
#This makes it easier to compare individual values.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#position="jitter" in geom_point to avoid "overplotting"
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))#default position is "identity"
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#ggplot2 comes with a shorthand for geom_point(position = "jitter"): geom_jitter()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_jitter()


# Exercise 3.8.1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()   #overplotting
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")
#geom_jitter() is a shorthand of geom_point(position = "jitter")
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(width = 0.25)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(height = 0.25)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter(width = 0.25, height = 0.25)

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

#default position="dodge2" for geom_boxplot
ggplot(data = mpg, mapping = aes(x = class, y = hwy, color = class)) +
  geom_boxplot() 
ggplot(data = mpg, mapping = aes(x = class, y = hwy, color = class)) +
  geom_boxplot(position = "identity") # same as above



# Coordinate System
#coor_flip switches the x & y axes
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

ggplot(data = mpg, mapping = aes(x = class, fill = manufacturer)) +
  geom_bar(position = "dodge")
ggplot(data = mpg, mapping = aes(x = class, fill = manufacturer)) +
  geom_bar(position = "dodge") +
  coord_flip()

install.packages("maps")
county <- map_data("county")
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon()
#coord_quickmap sets the aspect ratio correctly for maps.
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_quickmap()


#coord_polar() uses polar coordinates. Polar coordinates reveal an interesting connection 
#between a bar chart and a Coxcomb chart.
# theme(aspect.ratio=1) makes the plot panel a square
# labs(x = NULL, y = NULL) remove the name of x&y axis
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
  
bar + coord_flip()
bar + coord_polar()


# 3.9.1 Exercise
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity)) +
  coord_polar() +
  labs(title = "Coxcomb Plot for diamonds by cut", caption = "(based on data from diamonds)")

#Map projections do not, in general, preserve straight lines, so this requires 
#considerable computation. coord_quickmap is a quick approximation that does preserve 
#straight lines. It works best for smaller areas closer to the equator.
install.packages("mapproj")
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_quickmap()
ggplot(county, aes(long, lat, fill = region)) +
  geom_polygon() +
  coord_map()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()


>>>>>>> 99acb1b720441a168bb21dd643e767059277ef1d
