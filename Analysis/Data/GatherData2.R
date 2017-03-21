#################################################################
# Download and clean EDUC data set.
# Author: Shravan Kuchkula
# Date Modified: 03/13/2017
# The data is gathered from the Educ link :
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
################################################################

# Store the source URL
educ_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Download the file locally
download.file(educ_url, "EDUC.csv")

# Use read_csv to read the data into a dataframe
educData <- read_csv("EDUC.csv")



