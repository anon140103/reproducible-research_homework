library(janitor)
library(dplyr)
library(ggplot2)

viral_data <- read.csv("question-5-data/Cui_etal2014.csv")

head(viral_data)

#Question 5b and 5c
# log-transform the data
log_viral_data <- viral_data %>%
  mutate(log_V = log(virion_volume_nm_nm_nm)) %>%
  mutate(log_L = log(genome_length_kb))

# Fit a linear model to the log-transformed data
model1 <- lm(log_V ~ log_L, log_viral_data)

summary(model1)

#Question 5d
# Create a plot of the log-transformed data with the fitted linear model
log_viral_data %>%
  ggplot(aes(x = log_L, y = log_V)) +
  geom_point() + 
  geom_smooth(method = "lm", linewidth = 0.8) +
  labs(x = "log[Genome length (kb)]", y = "log[Virion volume (nm³)]") +
  theme(axis.title = element_text(face = "bold")) +
  theme_bw()

#Question 5e
# Define the coefficients from our linear model
intercept <- 7.0748   
slope <- 1.5152       

# Define the genome length (L) in kb
L <- 300

# Calculate log(L)
log_L <- log(L)

# Use the model equation to calculate log(V)
log_V <- intercept + slope * log_L

# Convert log(V) to V
V <- exp(log_V)

V
