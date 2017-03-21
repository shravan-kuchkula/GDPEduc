# CleanData1.R
cat("***************************** \n")
cat("CleanData1.R \n")
cat("***************************** \n")

# Find the number of observations for which CountryCode is NA.
gdpData %>%
  count(is.na(CountryCode))

# Remove all observations where CountryCode is NA.
gdpData <- gdpData %>%
  filter(!is.na(CountryCode))

