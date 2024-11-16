library(janitor)
library(dplyr)
library(ggplot2)


#Read in the data
viral_data <- read.csv("question-5-data/Cui_etal2014.csv")


# Check the first few rows to confirm successful import and cleaning
head(viral_data)

# Transform the data by applying log transformation
log_viral_data <- viral_data %>%
  mutate(log_V = log(virion_volume_nm_nm_nm)) %>%
  mutate(log_L = log(genome_length_kb))

# Fit a linear model to the log-transformed data
model1 <- lm(log_V ~ log_L, log_viral_data)

# Display the summary of the model to analyze the results
summary(model1)

# Code to create a plot of the log-transformed data with the fitted linear model
log_viral_data %>%
  ggplot(aes(x = log_L, y = log_V)) +
  geom_point() + 
  geom_smooth(method = "lm", linewidth = 0.8) +
  labs(x = "log[Genome length (kb)]", y = "log[Virion volume (nm³)]") +
  theme(axis.title = element_text(face = "bold")) +
  theme_bw()

# Define the coefficients from your fitted linear model
intercept <- 7.0748   
slope <- 1.5152       

# Define the genome length (L) in kb
L <- 300

# Calculate log(L)
log_L <- log(L)

# Use the model equation to compute log(V)
log_V <- intercept + slope * log_L

# Convert log(V) to V using the exponential function
V <- exp(log_V)

#Print answer
V
