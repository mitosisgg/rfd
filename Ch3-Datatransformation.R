library(nycflights13)
library(tidyverse)

### 3.2 Rows

flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# filtering dataframe
flights |>
  filter(carrier == "AA")

flights |>
  filter(month == 10 & day == 28)

flights |>
  filter(month %in% c(1,2))

# arranging 
flights |> 
  arrange(year, month, day, dep_time)

flights |>
  arrange(desc(dep_delay))

flights |>
  distinct()

flights |>
  distinct(origin, dest)

flights |>
  distinct(origin, dest, .keep_all = TRUE)

# 3.2.5 Exercises

# 1. In a single pipeline for each condition, find all flights that meet the condition:

# Had an arrival delay of two or more hours
flights |>
  filter(arr_delay >= 120) |>
  arrange(desc(arr_delay))

# Flew to Houston (IAH or HOU)
flights |>
  filter(dest == "HOU" | dest == "IAH")

# Were operated by United, American, or Delta
flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

# Departed in summer (July, August, September)
flights |>
  filter(month %in% 7:9)

# Arrived more than two hours late, but didn't leave late
flights |>
  filter(arr_delay >= 120 & dep_delay <= 0)

# Were delayed by at least an hour, but made up over 30 minutes in flight
flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# 2. Sort flights to find the flights with longest departure delays. Find the flights that left earliest in the morning
flights |>
  arrange(desc(dep_delay)) |> 
  arrange(sched_dep_time)

# 3. Sort flights to find the fastest flights
flights |>
  mutate(speed = distance / (air_time / 60)) |> 
  arrange(desc(speed)) |>
  relocate(speed)

# 4. Was there a light on every day of 2013?
flights |>
  filter(year == 2013) |>
  count(month, day)

flights |> 
  distinct(year, month, day) |> 
  nrow()
# Yes!

# 5. Which flights traveled the farthest distance? Which traveled the least?
flights |>
  arrange(desc(distance))

flights |>
  arrange(distance)

# Does it matter what order you used filter() and arrange() if you’re using both? Why/why not? 
# It's faster to filter first before sorting since there will be less to sort once the initial dataset is filtered down


### Columns

# 3.3.1 mutate()

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .keep = "used"
  )

# 3.3.2 select()

flights |>
  select(year, month, day)

flights |>
  select(year:day)

flights|>
  select(!year:day)

flights |>
  select(where(is.character))

flights |>
  select(starts_with("d"))

flights |>
  select(ends_with("time"))

flights |>
  select(contains("arr"))

flights |>
  select(arrival_time = arr_time)

flights |>
  rename(arrival_time = arr_time)

flights |>
  relocate(time_hour, air_time)

# 3.3.5 Exercises

# 1. Compare dep_time, sched_dep_time and dep_delay. How would you expect those three numbers to be related?
# A. dep_delay =  dep_time - sched_dep_time

# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time and arr_delay from flights.

flights |>
  select(ends_with("time") | ends_with("delay"))

flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)

# 3. What happens if you specify the name of the same variables multiple times in a select() call?
# A. It only returns that column once 
flights |>
  select(dep_time, dep_time, arr_time)

# 4. What does the any_of() function do? Why might it be helpful in conjuction with this vector?

variables <- c("year", "month", "day", "dep_delay", "arr_delay")
flights |>
  select(any_of(variables))

variables <- c("year", "month", "day", "dep_delay", "arr_delay")
flights |>
  select(-any_of(variables))

# 5. Does the result of running the following code surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?

flights |> select(contains("TIME", ignore.case = FALSE))

# 6. Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.
flights |>
  rename(air_time_min = air_time) |>
  relocate(air_time_min)


# 7. Why doesn’t the following work, and what does the error mean?
flights |> 
  select(tailnum) |> 
  arrange(arr_delay)
#> Error in `arrange()`:
#> ℹ In argument: `..1 = arr_delay`.
#> Caused by error:
#> ! object 'arr_delay' not found
# A. select(tailnum) returns a dataframe with only the tailnum column, so arrange cannot find arr_delay to sort by


### 3.5 Groups

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), # ignore rows with NA
    n = n()
  )

# 3.5.3 slice_ functions

# most delayed flight for each destination
flights |> 
  group_by(dest) |>
  slice_max(arr_delay, n = 1, with_ties = FALSE) |> 
  relocate(dest) |> 
  arrange(desc(arr_delay))

daily <- flights |>  
  group_by(year, month, day)
daily

daily_flights <- daily |> 
  summarize(
    n = n(),
    .groups = "drop_last")
daily_flights


flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

# 3.5.7 Exercises

# Which carrier has the worst average delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights |> group_by(carrier, dest) |> summarize(n()))
# A. F9
flights |> 
  group_by(carrier) |> 
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |> 
  arrange(desc(avg_dep_delay))

# Find the flights that are most delayed upon departure from each destination.
# A. 
flights |> 
  group_by(dest) |> 
  arrange(dest, desc(dep_delay)) |> 
  slice_head(n = 5) |> 
  relocate(dest, dep_delay)

flights |> 
  group_by(origin) |> 
  arrange(origin, desc(dep_delay)) |> 
  slice_head(n = 5) |> 
  relocate(origin, dep_delay)


# How do delays vary over the course of the day. Illustrate your answer with a plot.
# A. 
flights_by_sched_dep_time <- flights |> 
  group_by(sched_dep_time) |> 
  mutate(avg_dep_delay = mean(dep_delay, na.rm=TRUE)) |>
  relocate(avg_dep_delay, hour)


ggplot(
  data = flights_by_sched_dep_time,
  mapping = aes(x = sched_dep_time, y = avg_dep_delay)
) +
  geom_point() +
  geom_smooth()

flights |>
  group_by(hour) |> 
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |> 
  ggplot(aes(x = hour, y = avg_dep_delay)) +
  geom_smooth()


# What happens if you supply a negative n to slice_min() and friends?
flights |> 
  slice_min(dep_delay, n = 5, with_ties = FALSE) |> 
  relocate(carrier, dep_delay)
# returns 5 rows
  
flights |> 
  slice_min(dep_delay, n = -5, with_ties = FALSE) |> 
  relocate(carrier, dep_delay)
# orders the data frame from least to greatest of the given variable, but returns entire dataset instead of the desired 5 rows

#   Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?
#   A. count() 
flights |> 
  group_by(carrier) |> 
  count(sort = TRUE)

flights |> 
  group_by(carrier) |> 
  summarize(
    n = n()
  ) |> 
  arrange(n)

#   Suppose we have the following tiny data frame:
#   
  df <- tibble(
    x = 1:5,
    y = c("a", "b", "a", "a", "b"),
    z = c("K", "K", "L", "L", "K")
  )

# Write down what you think the output will look like, then check if you were correct, and describe what group_by() does.
# 
df |>
  group_by(y)
# 
# Write down what you think the output will look like, then check if you were correct, and describe what arrange() does. Also comment on how it’s different from the group_by() in part (a)?
#   
  df |>
  arrange(y)
# 
# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does.
# 
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
# 
# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. Then, comment on what the message says.
# 
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
# 
# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. How is the output different from the one in part (d).
# 
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
# 
# Write down what you think the outputs will look like, then check if you were correct, and describe what each pipeline does. How are the outputs of the two pipelines different?
#   
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
# 
df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))

install.packages("Lahman")
library(Lahman)

batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) /sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )

batters |>
  filter(performance > .100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) +
  geom_smooth(se = FALSE)
  geom_smooth()
