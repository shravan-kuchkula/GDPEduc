#################################################################
# Analysis 
# Author: Shravan Kuchkula
# Date Modified: 03/13/2017
#################################################################

## Question 1: Merge the data based on the country shortcode. 
# How many of the IDs match?

# Answer: 224 matches were found.

# Use an inner_join to merge GDP and EDUC datasets
gdp %>%
  inner_join(educ, c = "CountryCode") %>%
  summarise(matches = n())



## Question 2: Sort the data frame in ascending order by GDP (so United States is last). 
# What is the 13th country in the resulting data frame?

#Answer:KNA (St. Kitts and Nevis) with a GDP of 767 million US dollars.

#To do this, we need to first clean the GDP data.
# Remove NA's from GDP column and Ranking column. This leaves us with 189 countries.
# Format GDP data such that comma's are removed.
# Convert GDP data to numeric

gdp <- gdp %>%
  inner_join(educ, c = "CountryCode") %>%
  filter(!is.na(MillionsOfUSDollars), !is.na(Ranking))

gdp$MillionsOfUSDollars <- as.numeric(gsub(",", "", gdp$MillionsOfUSDollars))

gdpSorted <- gdp %>%
      arrange(MillionsOfUSDollars) %>%
      select(CountryCode, MillionsOfUSDollars, Economy)

head(gdpSorted, n=13)
View(gdpSorted)

## Question 3: What are the average GDP rankings for the "High income: OECD"
# and "High income: nonOECD" groups? 

# Answer:
#High income: OECD  32.96667
#High income: nonOECD  91.91304


# Convert Rankings to numeric
gdp$Ranking <- as.numeric(gdp$Ranking)

# Group observations by 'Income Group' and calculate the average Rankings for the groups
gdp %>%
    group_by(`Income Group`) %>%
    summarise(avg = mean(Ranking))

## Question 4: Show the distribution of GDP value for all the countries and color plots
# by income group. Use ggplot2 to create your plot.

library("ggplot2")

ggplot(gdp, aes(x = log10(MillionsOfUSDollars), fill = factor(`Income Group`))) +
  geom_histogram(binwidth = 0.7)

# Draw a density curve
fun_args <- list(mean = mean(log10(gdp$MillionsOfUSDollars)),
                 sd = sd(log10(gdp$MillionsOfUSDollars)))
ggplot(gdp, aes(x = log10(MillionsOfUSDollars))) + 
  geom_histogram(aes(y = ..density..)) +
  geom_density(color = "red") +
  stat_function(fun = dnorm, args = fun_args, color = "blue") + 
  theme_classic()

View(gdp)

# Use col instead of fill
# USE THIS
ggplot(gdp, aes(x = log10(MillionsOfUSDollars), col = factor(`Income Group`), 
                fill = factor(`Income Group`))) +
  geom_histogram(binwidth = 0.7, alpha = 0.5) +
  facet_grid(.~ factor(`Income Group`)) + 
  theme_dark() +
  theme(legend.position = "none", strip.text = element_text(size = rel(0.4))) +
  labs(x = "GDP in log10(MillionsOfUSDollars)")

# Overlay multiple density plots

ggplot(gdp, aes(x = log10(MillionsOfUSDollars), fill = factor(`Income Group`))) + 
  geom_density(col = NA, alpha = 0.35) +
  theme_light() +
  theme(legend.text = element_text(size=rel(0.5))) + 
  labs(x = "GDP log transformed") +
  scale_fill_discrete(name = "Income Group")

# Generate Violin plots
ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  geom_violin()

# Box plots with varying width
ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  geom_boxplot(varwidth = TRUE)

ggplot(gdp, aes(factor(`Income Group`))) +
  geom_bar()

ggplot(gdp, aes(x = log10(MillionsOfUSDollars), col = factor(`Income Group`), fill = factor(`Income Group`))) +
  stat_bin()

# Build the data layer, asthetic layer, geom layer, statistic layer
# Load the Hmisc package since stat_ functions are part of it.
library("Hmisc")
install.packages("Hmisc")
p <- ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  geom_point(position = position_jitter(0.2)) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), position = position_jitter(0.2), col = "blue")

# This plot shows the mean of each income group along with 1 sd deviation.
ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  #geom_point(position = position_jitter(0.2)) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), col = "blue")

# This plot shows the mean of each income group along with 1 sd deviation.
ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  #geom_point(position = position_jitter(0.2)) +
  stat_summary(geom = "point", fun.y = mean, col = "blue") +
  stat_summary(geom = "errorbar", fun.data = mean_sdl, fun.args = list(mult = 1), col = "blue", width = 0.1)

# Get a normal distribution curve on the log GDP data for all countries
ggplot(gdp, aes(x = log10(MillionsOfUSDollars))) +
  geom_histogram(aes(y = ..density..)) + 
  geom_rug() + 
  geom_density(col = "blue") +
  stat_function(fun = dnorm, col = "red", 
                args = list(mean = mean(log10(gdp$MillionsOfUSDollars)),
                            sd = sd(log10(gdp$MillionsOfUSDollars))))

ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  geom_point(position = position_jitter(0.2))

ggplot(gdp, aes(x = log10(MillionsOfUSDollars), fill = factor(`Income Group`))) +
  geom_()

View(gdp)

# Add a theme layer to modify the axis text and add a legend.
# This plot shows the mean of each income group along with 1 sd deviation.
pp <- ggplot(gdp, aes(x = factor(`Income Group`), y = log10(MillionsOfUSDollars))) +
  #geom_point(position = position_jitter(0.2)) +
  stat_summary(geom = "point", fun.y = mean, col = "blue") +
  stat_summary(geom = "errorbar", fun.data = mean_sdl, fun.args = list(mult = 1), col = "blue", width = 0.1)

pp + theme(axis.text = element_text(angle = 45, hjust = c(1), size = rel(0.6)))

# Add a theme layer to stats_bin and geom_histogram.

ggplot(gdp, aes(factor(`Income Group`))) +
  geom_bar() + theme(axis.text = element_text(angle = 45, hjust = c(1), size = rel(0.6)))

ggplot(gdp, aes(log10(MillionsOfUSDollars))) +
  geom_histogram() +
  facet_grid(. ~ factor(`Income Group`)) +
  theme(strip.text = element_text(size = rel(0.4), color = "red"))

ggplot(gdp, aes(log10(MillionsOfUSDollars))) +
  geom_histogram(aes(y = ..density..)) +
  facet_grid(. ~ factor(`Income Group`)) + 
  theme(strip.text = element_text(size = rel(0.4)))
  
# Adding the labs function
ggplot(gdp, aes(log10(MillionsOfUSDollars))) +
  geom_histogram(aes(y = ..density..)) +
  facet_grid(. ~ factor(`Income Group`)) + 
  theme(strip.text = element_text(size = rel(0.4), color = "red")) + 
  labs(x = "GDP in log10(MillionsOfUSDollars)")