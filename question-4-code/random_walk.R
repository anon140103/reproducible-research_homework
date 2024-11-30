library(ggplot2)
library(gridExtra)


# The parameter 'seed = NULL' allows the function to be flexible
# If a seed value is provided when calling the function,
#   that seed is used to generate reproducible random steps.
# If no seed is provided, 
#   the function will not set a seed, resulting in non-reproducible random walks.
# This flexibility means we can choose to either get the same results each time
# (by providing a seed) or get different results each time (by leaving it as NULL).

random_walk <- function(n_steps, seed = NULL) {
  set.seed(seed)
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  df[1, ] <- c(0, 0, 1) 
  for (i in 2:n_steps) {
    h <- 0.25 
    angle <- runif(1, min = 0, max = 2 * pi)  
    df[i, 1] <- df[i - 1, 1] + cos(angle) * h 
    df[i, 2] <- df[i - 1, 2] + sin(angle) * h 
    df[i, 3] <- i 
  }
  return(df)
}

#Generate first random walk with seed 37
data1 <- random_walk(500, seed = 37)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  geom_path(aes(colour = time)) +
  theme_bw() +
  xlab("x-coordinate") +
  ylab("y-coordinate")

# Generate second random walk with seed 55
data2 <- random_walk(500, seed = 55)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  geom_path(aes(colour = time)) +
  theme_bw() +
  xlab("x-coordinate") +
  ylab("y-coordinate")


grid.arrange(plot1, plot2, ncol = 2)
