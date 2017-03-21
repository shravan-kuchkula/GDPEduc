# Load all the libraries
libs <- c("readr", "dplyr", "tidyr", "ggplot2",
          "magrittr", "markdown", "knitr", "Hmisc",
          "repmis", "yaml", "psych", "lsr")

lapply(libs, require, character.only = TRUE)
