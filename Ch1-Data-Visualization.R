# library(tidyverse)
# library(palmerpenguins)
# library(ggthemes)

# penguins

# see all variables and a few rows
# glimpse(penguins)

# open an interactive window in R Studio
# View(penguins)

# 1.2.3 Creating the ggplot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
geom_point(mapping = aes(color = species, shape=species)) +
geom_smooth(method = "lm") +
labs(
  title = "Body mass and flipper length",
  subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
  x = "Flipper length (mm)", y = "Body mass (g)",
  color = "Species", shape = "Species"
) +
scale_color_colorblind()


# 1.2.5 Exercises
# How many rows are in penguins? How many columns?
# 334
#   
# What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
# a number denoting bill depth (millimeters)
#
# Make a scatterplot of bill_depth_mm vs. bill_length_mm. That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. Describe the relationship between these two variables.
ggplot(
  data = penguins,
  mapping = aes(x = bill_depth_mm, y = bill_length_mm, color = species)
) +
geom_point(mapping = aes()) +
geom_smooth(method = "lm") +
labs(
  title = "Bill Depth and Bill Length",
  subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
  x = "Bill Depth (mm)", y = "Bill Length (mm)",
  color = "Species", shape = "Species"
)


# What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
#   
# Why does the following give an error and how would you fix it?
