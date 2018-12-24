library(ggplot2)
mpg <- mpg %>% filter(class %in% c("suv", "compact", "subcompact"))
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE) +
  coord_cartesian(xlim = c(1.5, 7), ylim = c(10, 45)) +
  facet_wrap(~ class, nrow = 3) +
  labs(title = "displ vs hwy in mpg",
       x = "displ(in litres)",
       y = "hwy(highway miles per gallon)",
       caption = "based on data from mpg in ggplot2 package",
       color = "DRV") +
  theme_bw()
  