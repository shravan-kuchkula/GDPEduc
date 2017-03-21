#################################################################
# Download and clean GDP data set.
# Author: Shravan Kuchkula
# Date Modified: 03/13/2017
# The data is gathered from the GDP link :
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
################################################################

# When you download this repo, the current working directory will be root.
getwd()

# Navigate to Analysis/Data
#setwd("./Analysis/Data")

# Store the source URL
gdp_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

# Download the file locally
#download.file(gdp_url, '../Analysis/Data/GDP.csv')
download.file(gdp_url, 'GDP.csv')

# Load the readr library since we will be using read_csv
library("readr")

# Use read_csv to read the data into a dataframe
# columnNames are explicitly mentioned since we are using skip argument
# col_types argument skips reading in column 3, which is an empty column. 
columnNames <- c("CountryCode", "Ranking", "Economy", "Gdp")
gdpData <- read_csv(gdp_url, col_names = columnNames, col_types = "ci_cc", 
                    skip=5, n_max = 231, na = c("..", "NA", ""))
