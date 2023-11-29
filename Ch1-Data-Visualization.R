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
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm, color = species)
) +
geom_point() +
geom_smooth(method = "lm") +
labs(
  title = "Species and Bill Depth",
  subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
  caption = "Data came from the palmerpenguins package",
  x = "Species", y = "Bill Depth (mm)",
  color = "Species", shape = "Species"
)
  
# Why does the following give an error and how would you fix it?
ggplot(data = penguins) + 
geom_point()
# -> `geom_point()` requires the following missing aesthetics: x and y

# What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.
# If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.	

# Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().
# use caption arg in labs()

# Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?
ggplot(
  data = penguins,
  mapping = aes(x= flipper_length_mm, y = body_mass_g, color = bill_depth_mm)
) +
geom_point() + 
geom_smooth(method = 'gam') +
labs(
  title = "Flipper Length and Body Mass",
  subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
  caption = "Data came from the palmerpenguins package"
)

# Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# Will these two graphs look different? Why/why not?
# > providing the attributes to ggplot is passed down to the downstream functions, therefore both plots are equivalent
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
geom_point(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
geom_smooth(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

### Visualizing Distributions

### 1.4.1 Categorical Variables
# bar chart

ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()


### 1.4.2 Numerical Variables
# histogram

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 20)

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 2000)

# density plot
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_density()


# Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()


# How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

ggplot(penguins, aes(x = species)) +
geom_bar(color = "red") # only colors the box outline
 
ggplot(penguins, aes(x = species)) +
geom_bar(fill = "red") # better, fills in the total area of the bar
 
# What does the bins argument in geom_histogram() do?
# > Number of bins. Overridden by binwidth. Defaults to 30.

# Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. 
#Experiment with different binwidths. What binwidth reveals the most interesting patterns?
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = .2)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = .1)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = .05)



### 1.5 Visualizing Relationships
# 1.5.1 A numerical and a categorical variable

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

# 1.5.2 Two categorical variables
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")


# 1.5.3 Two numerical variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()


# 1.5.4 Three or more variables 
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

# using facets
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)