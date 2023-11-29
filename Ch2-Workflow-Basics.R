1 / 200 * 3
class(.015)

sin(pi / 2)

x <- 3 * 4

primes <- c (2,3,5,7,11,13)

class(primes)

primes[0] # numeric(0)
primes[1] # 2
primes[8] # NA

primes * 2

this_is_a_really_long_name <- 2.5

library(tidyverse)
ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy)
) + 
  geom_point() +
  geom_smooth(method = "lm")