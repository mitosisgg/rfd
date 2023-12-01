library(tidyverse)

students <- read_csv("data/students.csv", na = c("N/A", ""))

# students |> 
#   rename(
#     student_id = `Student ID`,
#     full_name = `Full Name`,
#     favourite_food = "favourite.food",
#     meal_plan = "mealPlan",
#     age = "AGE"
#   )

students |> 
  janitor::clean_names() |>
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age)
  )
    )


read_csv(
  "1,2,3
  4,5,6",
  col_names = c("x", "y", "z")
)

read_csv("x,y\n1,'a,b'", quote = "\'")

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

ggplot(annoying, aes(x = `2`, y = `1`)) +
  geom_point()

annoying |> mutate(`3` = (`2` / `1`))
