#################################################################
# Merge the GDP and EDUC data sets.
# Author: Shravan Kuchkula
# Date Modified: 03/13/2017
################################################################

# Merge the two datasets using an inner_join
gdpEduc <- gdpData %>%
    inner_join(educData, c = "CountryCode") %>%
    write_csv("MergedData.csv")