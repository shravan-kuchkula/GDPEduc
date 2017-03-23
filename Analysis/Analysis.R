#################################################################
# Analysis 
# Author: Shravan Kuchkula
# Date Modified: 03/13/2017
#################################################################

# Use an inner_join to merge GDP and EDUC datasets
# Return the number of matches.
idMatches <- function(){
  gdpEduc <- gdpData %>%
    inner_join(educData, c = "CountryCode") %>%
    summarise(matches = n())
  
  return(gdpEduc$matches)
}

# Before we proceed further, we should remove the NA and
# convert the Ranking and Gdp columns to numeric.
# The cleaned data set will be called: gdpEduc

# Remove obs containing NA's
gdpEduc <- gdpEduc %>%
  filter(!is.na(Gdp), !is.na(Ranking))

# Format the Gdp column
gdpEduc$Gdp <- as.numeric(gsub(",", "", gdpEduc$Gdp))

# Convert Rankings to numeric
gdpEduc$Ranking <- as.numeric(gdpEduc$Ranking)

# sortByGdp
gdpRank <- function(n = 1){

  # Sort the gdp column
  gdpEducSorted <- gdpEduc %>%
  arrange(Gdp) %>%
  select(CountryCode, Gdp, Economy)
  
  # Return the n-th value
  return(gdpEducSorted$Economy[n])
}

groupRankAverages <- function(){
  
  # Group observations by 'Income Group' and calculate the average Rankings
  # for the groups
  gdpEduc %>%
    group_by(`Income Group`) %>%
    summarise(avg = mean(Ranking))
  
}
