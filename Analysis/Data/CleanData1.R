# CleanData1.R

# Find the number of observations for which CountryCode is NA.
countNAs <- gdpData %>%
  filter(is.na(CountryCode))

cat(dim(countNAs)[1], " observations with NA's in CountryCode are removed")


# Remove all observations where CountryCode is NA.
gdpData <- gdpData %>%
  filter(!is.na(CountryCode))

