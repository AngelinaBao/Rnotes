#Graphics for communication
library(ggrepel)
library(viridis)
library(tidyverse)
library(data.table)
# Label
df <- tibble(
  x = runif(10),
  y = runif(10)
)
ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(sum(x[i]^2, i == 1, n)),
    y = quote(alpha + beta + frac(alpha, theta) )
  )

#28.2.1 exercise
data("economics")
ggplot(economics, aes(x = date, y = unemploy, color = pce)) +
  geom_point() +
  labs(
    title = "unemploy by date",
    subtitle = "unemploy details by date",
    caption = "http://research.stlouisfed.org/fred2",
    color = "pce"
  )

# Annotations
best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(hwy) == 1)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_text(aes(label = model), data = best_in_class)

# geom_label draw a rectangle behind the text
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5)
# labels overlapped, use ggrepel package will peformance better
library(ggrepel)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  geom_label_repel(aes(label = model), data = best_in_class)

#You can sometimes use the same idea to replace the legend with labels placed directly on the plot
class_avg <- mpg %>%
  group_by(class) %>%
  summarise(
    displ = median(displ),
    hwy = median(hwy)
  ) # class_avg is used for comfirm the label position
ggplot(mpg, aes(displ, hwy, color = class)) +
  geom_point() +
  geom_label_repel(
    aes(label = class),
    data = class_avg,
    size = 6,
    label.size = 0,
    segment.color = NA
  ) +
  theme(legend.position = "none") # with this condition, labels will not overlap

#you might just want to add a single label to the plot
label <- mpg %>%
  summarise(
    displ = max(displ),
    hwy = max(hwy),
    label = "Increasing engine size is \nrelated to decreasing fuel economy"
  )
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_label_repel(
    aes(label = label),
    data = label,
    direction = "y"
  )
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_label_repel(
    aes(label = label),
    data = label,
    hjust = "right",
    vjust = "top"
  )

# used \n to return, anotherway: stringr::str_wrap()
library(stringr)
"Increasing engine size is related to decreasing fuel economy" %>%
str_wrap(width = 40) %>%
  writeLines()

#Scales
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(10, 40, by = 10)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2))
#you can also set it to NULL to suppress the labels altogether.
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

#plot transformations of your variable
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d()
ggplot(diamonds, aes(log10(carat), log10(price))) +
  geom_bin2d()

#However, the disadvantage of this transformation is that the axes are now labelled 
#with the transformed values, making it hard to interpret the plot
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() +
  scale_x_log10() +
  scale_y_log10()

#Another scale that is frequently customised is colour
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "Set1")

#If there are just a few colours, you can add a redundant shape mapping. 
#This will also help ensure your plot is interpretable in black and white
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  scale_color_brewer(palette = "Set1")

#When you have a predefined mapping between values and colours, use scale_colour_manual()
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, color = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_color_manual(values = c(Republican = "blue", Democratic = "red"))

#continuous analog of the categorical ColorBrewer scales
df <- tibble(
  x = rnorm(10000),
  y = rnorm(10000)
)

#install.packages("hexbin")  
library(hexbin)
ggplot(df, aes(x, y)) +
  geom_hex() +
  coord_fixed()

ggplot(df, aes(x, y)) +
  geom_hex() +
  scale_fill_viridis() +
  coord_fixed()

ggplot(diamonds, aes(carat, price)) +
  geom_point(aes(color = cut), alpha = 1/10) 

# Zooming
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth() +
  coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))
mpg %>%
  filter(displ >= 5, displ <= 7, hwy >= 10, hwy <=30) %>%
  ggplot(aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()

#Reducing the limits is basically equivalent to subsetting the data
mpg <- as.data.table(mpg)
compact <- mpg[class == "compact"]
#or
#compact <- mpg %>% filter(class == "compact")
suv <- mpg %>% filter(class == "suv")
ggplot(compact, aes(displ, hwy, color = drv)) +
  geom_point() 
ggplot(suv, aes(displ, hwy, color = drv)) +
  geom_point()
#it's difficult to compare the plots because all three scales 
#(the x-axis, the y-axis, and the colour aesthetic) have different ranges.

#One way to overcome this problem is to share scales across multiple plots, 
#training the scales with the limits of the full data
x_scale <- scale_x_continuous(limits = range(mpg$displ))
y_scale <- scale_y_continuous(limits = range(mpg$hwy))
color_scale <- scale_color_discrete(limits = unique(mpg$drv))
ggplot(suv, aes(displ, hwy, color = drv)) +
  geom_point() +
  x_scale +
  y_scale +
  color_scale
ggplot(compact, aes(displ, hwy, color = drv)) +
  geom_point() +
  x_scale +
  y_scale +
  color_scale
#or display 2 plots together
mpg1 <- mpg[class %in% c("compact", "suv")]
ggplot(mpg1, aes(displ, hwy, color = drv)) +
  geom_point() +
  facet_wrap(~ class, nrow = 1)


#Themes
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_classic()
# there are 8 themes built in ggplot2, Many more are included in add-on packages like 
#ggthemes (https://github.com/jrnold/ggthemes), by Jeffrey Arnold


#Saving your plots
#There are two main ways to get your plots out of R and into your final write-up: 
#ggsave() and knitr. ggsave() will save the most recent plot to disk

ggsave("C:\\Users\\1000257489\\Documents\\Angelina\\GitHub\\Rnotes\\R-demos\\packages\\my_plot.pdf")

