# Case Study
## GDP and Income groups of nations
Shravan Kuchkula

Gross Domestic Product and Income groups of nations are analysed in this project using R. The research and analysis is reproducible and extendable. A good starting point would be to take a look at the Report.md file - which contains the data gathering, cleaning, merging, analysis and reporting all in one place. For those, who want to reproduce the analysis done here, can start with `Instructions to run the code` section in Report.md file.

A quick glance of the project structure and a brief description of the files is given below:

### Project Structure

```{}
GDPEduc  
|_  
  Analysis  
  |_  
    Data  
    |_  
      Makefile.txt
      CleanData1.R  
      GatherData1.R
      GatherData2.R
      MergeData.R
      EDUC.csv
      GDP.csv
      MergedData.csv
  |_
    Analysis.R
    libraries.R
    Main.R
|_
  Paper
    |_
      Report.html
      Report.pdf
      Report.Rmd
      Report.md
```

  * `Makefile.txt`  - Downloads the two data sets, cleans and merges them.
  * `CleanData1.R`  - Cleans the GDP Rank table data set.
  * `GatherData1.R` - Downloads the GDP Rank table data set.
  * `GatherData2.R` - Downloads the EducStats data set.
  * `MergeData.R`   - Merges GDP and EducStats based on CountryCode.
  * `libraries.R`   - Downloads and loads the packages required.
  * `Analysis.R`    - Contains functions used in the analysis.
  * `Main.R`        - Main script that ties everything together.
  * `Report.Rmd`    - RMarkdown file that ties data gathering and analysis.
  * `Report.md`     - Markdown file that renders on Github as a webpage.


