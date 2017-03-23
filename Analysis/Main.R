# Author: Shravan Kuchkula
# Main Script - The answers will be written to the console.

# rootDir is the root directory
rootDir <- getwd()
analysisDir <- paste0(rootDir, '/Analysis')
 
#setwd to Data
setwd('Analysis/Data')
  
#run the makefile
source('Makefile.txt')
  
#setwd to Analysis
setwd(analysisDir)
  
#load all the libraries
source('libraries.R')
  
#Load the required analysis functions
source('Analysis.R')
  
#  Answer the below analysis questions
  
#Question1
num_id_matches <- idMatches()
num_id_matches
paste("The number of ID matched by joining GDP and EdStats datasets is ",
        num_id_matches)
  
#Question2
gdpRank(13)
paste("The 13th smallest GDP country is: ", gdpRank(13))
  
#Question3
# Average group rankings for High income OECD and nonOECD groups.
paste("Average group rankings for High income OECD and nonOECD groups")
grpAvgs <- groupRankAverages()
grpAvgs[grepl(".*OECD$", grpAvgs$`Income Group`),]
  
  #Question4
  # Draw a density curve
  cols <- c("Emperical"="#f04546","Theoritical"="#3591d1")
  fun_args <- list(mean = mean(log10(gdpEduc$Gdp)),
                   sd = sd(log10(gdpEduc$Gdp)))
  ggplot(gdpEduc, aes(x = log10(gdpEduc$Gdp))) + 
    geom_histogram(aes(y = ..density..)) +
    geom_density(aes(col = "Emperical")) +
    stat_function(fun = dnorm, args = fun_args, aes(col = "Theoritical")) + 
    theme_classic() +
    scale_color_manual(name = "Normal Curves", values = cols) +
    labs(x = "log GDP") +
    ggtitle("Log transformed GDP density plot") +
    theme(plot.title = element_text(hjust = 0.5, face="bold.italic",
                                    size = rel(0.8), color = "darkblue"))
  
  # Draw the histogram of count vs log10(GDP) faceted by Income Groups
  ggplot(gdpEduc, aes(x = log10(Gdp), col = factor(`Income Group`), 
                  fill = factor(`Income Group`))) +
    geom_histogram(binwidth = 0.7, alpha = 0.5) +
    facet_grid(.~ factor(`Income Group`)) + 
    theme_dark() +
    theme(legend.position = "none", strip.text = element_text(size = rel(0.4))) +
    labs(x = "log10(Gdp)") +
    ggtitle("count vs log GDP faceted by Income groups") +
    theme(plot.title = element_text(hjust = 0.5, face="bold.italic",
                                    size = rel(0.8), color = "darkblue"))
  
  # Overlay multiple density plots
  ggplot(gdpEduc, aes(x = log10(Gdp), fill = factor(`Income Group`))) + 
    geom_density(col = NA, alpha = 0.35) +
    theme_light() +
    theme(legend.text = element_text(size=rel(0.5))) + 
    labs(x = "GDP log transformed") +
    scale_fill_discrete(name = "Income Group") +
    ggtitle("Overlaying density plots for log GDP") +
    theme(plot.title = element_text(hjust = 0.5, face="bold.italic",
                                    size = rel(0.8), color = "darkblue"))
  
  # Put Income Groups on X-axis
  # Display mean and 1 sd
  ggplot(gdpEduc, aes(x = factor(`Income Group`), y = log10(Gdp))) +
    stat_summary(geom = "point", fun.y = mean, col = "blue") +
    stat_summary(geom = "errorbar", fun.data = mean_sdl,
                 fun.args = list(mult = 1), col = "blue", width = 0.1) +
    theme(axis.text = element_text(angle = 45, hjust = c(1), size = rel(0.6))) +
    labs(x = "Income Groups") +
    ggtitle("mean and 1 SD from mean") +
    theme(plot.title = element_text(hjust = 0.5, face="bold.italic",
                                    size = rel(0.8), color = "darkblue"))
  
  # Box plots with data overlayed to get an idea of the distribution of GDP
  ggplot(gdpEduc, aes(x = factor(`Income Group`), y = log10(Gdp))) +
  geom_point(colour="lightblue", alpha=0.9, position="identity") +
    geom_boxplot(outlier.size=0, alpha=0.2) +
    theme_light() +
    theme(axis.text = element_text(angle = 45, hjust = c(1), size = rel(0.6))) +
    labs(x = "Income Groups") +
    ggtitle("Box plot overlayed with actual values") +
    theme(plot.title = element_text(hjust = 0.5, face="bold.italic",
                                    size = rel(0.8), color = "darkblue"))
  
  # Descriptive statistics using psych package.
  descStatsGDP <- describeBy(gdpEduc$Gdp, gdpEduc$`Income Group`, mat=TRUE)
  descStatsGDP %>%
    select(-item, -vars, -mad) %>%
    print(row.names = FALSE)
  
  # QuantileCut to divide the GDP rankings into 5 quantile groups
  gdpEducTemp <- gdpEduc
  gdpEducTemp %>%
    mutate(quantiles = quantileCut(gdpEduc$Ranking,5,
                                   labels=c("Q1","Q2","Q3","Q4","Q5"))) %>%
    filter(as.character(quantiles) == "Q1", `Income Group` == "Lower middle income") %>%
    select(CountryCode, Economy, Ranking, `Income Group`, quantiles)

setwd(rootDir)

