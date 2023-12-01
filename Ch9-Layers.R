library(tidyverse)

# 9.2 Aesthetic Mappings --------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

# having more than 6 discrete class of cars causes data to go unplotted
ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()

# bad idea to use size
ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()

# worse idea to use alpha
ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()


ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "blue")

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(shape = 24)


# 9.2.1 Exercises ---------------------------------------------------------

# 1. Create a scatterplot of hwy vs. displ where the points are pink filled in triangles.

ggplot(mpg, aes(x = hwy, y = displ)) +
  geom_point(shape = 17, color = "pink")

# 2. Why did the following code not result in a plot with blue points?
# A. color = "blue" needs to be outside aes()
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, color = "blue"))

# 3. What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
# A. for shapes with a border, stroke modifies the width of the border

# 4. What happens if you map an aesthetic to something other than a variable name, like aes(color = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(mpg, aes(x = hwy, y = displ, color = displ < 5)) +
  geom_point()


# 9.3 Geometric Objects ---------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# Left
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# Right
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()


ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(aes(line_type = drv))

# Left
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

# Middle
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv))

# Right
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = TRUE)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    shape = "circle open", size = 3, color = "red"
  )


# Left
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2)

# Middle
ggplot(mpg, aes(x = hwy)) +
  geom_density()

# Right
ggplot(mpg, aes(x = hwy)) +
  geom_boxplot()


# 9.3.1 Exercises ---------------------------------------------------------

# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
#A. geom_line, geom_boxplot, geom_histogram, geom_area

# 2. What does show.legend = FALSE do here? What happens if you remove it?
# A. removes the legend
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)

# 3. What does the se argument to geom_smooth() do?
# A. Removes the confidence interval bands 

# Recreate the following graphs

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(line_type = drv), color = "blue", se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(color = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point( size = 3, color = "white") +
  geom_point(aes(color = drv)) 
  

# 9.4 Facets --------------------------------------------------------------

# one subset of data based on a categorical variable
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)

# facet plot with two variables
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)

# free the axis scaling between facet plots
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl, scales = "free_y")



ggplot(mpg) + 
  geom_point(aes(x = drv, y = cyl))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


ggplot(mpg, aes(x = displ)) + 
  geom_histogram() + 
  facet_grid(drv ~ .)

ggplot(mpg, aes(x = displ)) + 
  geom_histogram() +
  facet_grid(. ~ drv)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(drv ~ .)


# 9.5 Statistical Transformations -----------------------------------------

ggplot(diamonds, aes(x = cut)) +
  geom_bar()

diamonds |>
  count(cut) |>
  ggplot(aes(x = cut, y = n)) +
  geom_bar(stat = "identity")


ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar() 
ggplot(diamonds, aes(x = cut, fill = color, y = after_stat(prop), group = color)) + 
  geom_bar() 


# 9.6 Position Adjustments -----------------------------------------------

ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_jitter(width = .5)



# 9.7 Coordinate systems --------------------------------------------------

nz <- map_data("nz")

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()


bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = clarity, fill = clarity), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1)

bar
bar + coord_flip()
bar + coord_polar()

ggplot(diamonds, aes(x = "", fill = cut)) + 
  geom_bar() +
  coord_polar()
