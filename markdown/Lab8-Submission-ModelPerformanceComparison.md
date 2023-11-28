Business Intelligence Lab Submission Markdown
================
\<\>
\<23/10/2023\>

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
  - [Milestone 1 out 0f 8](#milestone-1-out-0f-8)
- [Loading the Loan Status Train Imputed
  Dataset](#loading-the-loan-status-train-imputed-dataset)
  - [Milestone 1 out of 8](#milestone-1-out-of-8)
  - [\<Milestone 1 out of 3\>](#milestone-1-out-of-3)
  - [\<Milestone 2 out of 8\>](#milestone-2-out-of-8)
- [STEP 4./<Use the MICE package to perform data imputation/>](#step-4)
  - [\<Milestone 7 out of 8\>](#milestone-7-out-of-8)
  - [\<Milestone 8 out of 8\>](#milestone-8-out-of-8)
  - [\<Milestone 8 out of 8\>](#milestone-8-out-of-8-1)
  - [\<Milestone 8 out of 8\>](#milestone-8-out-of-8-2)
  - [\<Milestone 8 out of 8\>](#milestone-8-out-of-8-3)

# Student Details

<table>
<colgroup>
<col style="width: 23%" />
<col style="width: 76%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Numbers and Names of Group Members</strong></td>
<td><p><em>&lt;list one Student name, class group (just the letter; A,
B, or C), and ID per line, e.g., 123456 - A - John Leposo; you should be
between 2 and 5 members per group&gt;</em></p>
<ol type="1">
<li>128998 - B - Crispus Nzano |</li>
</ol></td>
</tr>
<tr class="even">
<td><strong>GitHub Classroom Group Name</strong></td>
<td>BI-Loan-Appraisal-Project |</td>
</tr>
<tr class="odd">
<td><strong>Course Code</strong></td>
<td>BBT4206</td>
</tr>
<tr class="even">
<td><strong>Course Name</strong></td>
<td>Business Intelligence II</td>
</tr>
<tr class="odd">
<td><strong>Program</strong></td>
<td>Bachelor of Business Information Technology</td>
</tr>
<tr class="even">
<td><strong>Semester Duration</strong></td>
<td>21<sup>st</sup> August 2023 to 28<sup>th</sup> November 2023</td>
</tr>
</tbody>
</table>

# Setup Chunk

We start by installing all the required packages, each Issue and
Milestone will have its own packages

``` r
## formatR - Required to format R code in the markdown ----

if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Introduction ----
# Resampling methods are techniques that can be used to improve the performance
# and reliability of machine learning algorithms. They work by creating
# multiple training sets from the original training set. The model is then
# trained on each training set, and the results are averaged. This helps to
# reduce overfitting and improve the model's generalization performance.

# Resampling methods include:
## Splitting the dataset into train and test sets ----
## Bootstrapping (sampling with replacement) ----
## Basic k-fold cross validation ----
## Repeated cross validation ----
## Leave One Out Cross-Validation (LOOCV) ----

# STEP 1. Install and Load the Required Packages ----
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## randomForest ----
if (require("randomForest")) {
  require("randomForest")
} else {
  install.packages("randomForest", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

------------------------------------------------------------------------

**Note:** the following “*KnitR*” options have been set as the defaults
in this markdown:  
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy.opts = list(width.cutoff = 80), tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

``` r
knitr::opts_chunk$set(
    eval = TRUE,
    echo = TRUE,
    warning = FALSE,
    collapse = FALSE,
    tidy = TRUE
)
```

------------------------------------------------------------------------

**Note:** the following “*R Markdown*” options have been set as the
defaults in this markdown:

> output:  
>   
> github_document:  
> toc: yes  
> toc_depth: 4  
> fig_width: 6  
> fig_height: 4  
> df_print: default  
>   
> editor_options:  
> chunk_output_type: console

## Milestone 1 out 0f 8

# Loading the Loan Status Train Imputed Dataset

Issue 1 Descriptive Statistics.

``` r
# 1 Descriptive Statistics ----

# Install renv:
if (!is.element("renv", installed.packages()[, 1])) {
    install.packages("renv", dependencies = TRUE)
}
require("renv")
```

    ## Loading required package: renv

    ## 
    ## Attaching package: 'renv'

    ## The following object is masked from 'package:languageserver':
    ## 
    ##     run

    ## The following objects are masked from 'package:stats':
    ## 
    ##     embed, update

    ## The following objects are masked from 'package:utils':
    ## 
    ##     history, upgrade

    ## The following objects are masked from 'package:base':
    ## 
    ##     autoload, load, remove

``` r
# Use renv::init() to initialize renv in a new or existing project.

# The prompt received after executing renv::init() is as shown below: This
# project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.  2: Discard the lockfile and
# re-initialize the project.  3: Activate the project without snapshotting or
# installing any packages.  4: Abort project initialization.

# Select option 1 to restore the project from the lockfile


# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall them)
# are recorded into a lockfile, renv.lock, and a .Rprofile ensures that the
# library is used every time you open that project.

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot() to record the packages and their sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# Execute the following code to reinstall the specific package versions
# recorded in the lockfile:

# One of the packages required to use R in VS Code is the 'languageserver'
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

# Loading Datasets ---- STEP 2: Load datasets ----

library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/loans_imputed.csv")
```

    ## Rows: 614 Columns: 12

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)

# Dimensions ---- STEP 3. Preview the Loaded Datasets ---- Dimensions refer to
# the number of observations (rows) and the number of
# attributes/variables/features (columns). Execute the following commands to
# display the dimensions of your datasets:

dim(loans)
```

    ## [1] 614  12

``` r
# Data Types ---- STEP 4. Identify the Data Types ---- Knowing the data types
# will help you to identify the most appropriate visualization types and
# algorithms that can be applied. It can also help you to identify the need to
# convert from categorical data (factors) to integers or vice versa where
# necessary. Execute the following command to identify the data types:
sapply(loans, class)
```

    ##            Gender           Married        Dependents         Education 
    ##       "character"       "character"       "character"       "character" 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##       "character"         "numeric"         "numeric"         "numeric" 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##         "numeric"         "numeric"       "character"       "character"

``` r
# Descriptive Statistics ----

# We will first understand the data before using it to design prediction models
# and to make generalizable inferences.

# 1. Measures of frequency (e.g., count, percent)

# 2. Measures of central tendency (e.g., mean, median, mode) Further reading:
# https://www.scribbr.com/statistics/central-tendency/

# 3. Measures of distribution/dispersion/spread/scatter/variability (e.g.,
# range, quartiles, interquartile range, standard deviation, variance,
# kurtosis, skewness) Further reading:
# https://www.scribbr.com/statistics/variability/ Further reading:
# https://digitaschools.com/descriptive-statistics-skewness-and-kurtosis/
# Further reading: https://www.scribbr.com/statistics/skewness/

# 4. Measures of relationship (e.g., covariance, correlation, ANOVA)

# Further reading: https://www.k2analytics.co.in/covariance-and-correlation/
# Further reading: https://www.scribbr.com/statistics/one-way-anova/ Further
# reading: https://www.scribbr.com/statistics/two-way-anova/

# Understanding your data can lead to: (i)\t Data cleaning: Removing bad data
# or imputing missing data.  (ii)\tData transformation: Reduce the skewness by
# applying the same function to all the observations.  (iii)\tData modelling:
# You may notice properties of the data such as distributions or data types
# that suggest the use (or not) of specific algorithms.

## Measures of Frequency ----

### STEP 5. Identify the number of instances that belong to each class. ---- It
### is more sensible to count categorical variables (factors or dimensions)
### than numeric variables, e.g., counting the number of male and female
### participants instead of counting the frequency of each participant’s
### height.
loans_freq <- loans$Education
cbind(frequency = table(loans_freq), percentage = prop.table(table(loans_freq)) *
    100)
```

    ##              frequency percentage
    ## Graduate           480    78.1759
    ## Not Graduate       134    21.8241

``` r
## Measures of Central Tendency ---- STEP 6. Calculate the mode ----
## Unfortunately, R does not have an in-built function for calculating the
## mode.  We, therefore, must manually create a function that can calculate the
## mode.

loans_Education_mode <- names(table(loans$Education))[which(table(loans$Education) ==
    max(table(loans$Education)))]
print(loans_Education_mode)
```

    ## [1] "Graduate"

``` r
## Measures of Distribution/Dispersion/Spread/Scatter/Variability ----

### STEP 7. Measure the distribution of the data for each variable ----
summary(loans)
```

    ##     Gender            Married           Dependents         Education        
    ##  Length:614         Length:614         Length:614         Length:614        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##  SelfEmployed       ApplicantIncome CoapplicantIncome   LoanAmount   
    ##  Length:614         Min.   :  150   Min.   :    0     Min.   :  150  
    ##  Class :character   1st Qu.: 2878   1st Qu.:    0     1st Qu.: 2875  
    ##  Mode  :character   Median : 3812   Median : 1188     Median : 3768  
    ##                     Mean   : 5403   Mean   : 1621     Mean   : 5371  
    ##                     3rd Qu.: 5795   3rd Qu.: 2297     3rd Qu.: 5746  
    ##                     Max.   :81000   Max.   :41667     Max.   :81000  
    ##  LoanAmountTerm  CreditHistory   PropertyArea          Status         
    ##  Min.   : 12.0   Min.   :0.000   Length:614         Length:614        
    ##  1st Qu.:360.0   1st Qu.:1.000   Class :character   Class :character  
    ##  Median :360.0   Median :1.000   Mode  :character   Mode  :character  
    ##  Mean   :342.3   Mean   :0.855                                        
    ##  3rd Qu.:360.0   3rd Qu.:1.000                                        
    ##  Max.   :480.0   Max.   :1.000

``` r
### STEP 8. Measure the standard deviation of each variable ---- Measuring the
### variability in the dataset is important because the amount of variability
### determines how well you can generalize results from the sample dataset to a
### new observation in the population.

# Low variability is ideal because it means that you can better predict
# information about the population based on sample data. High variability means
# that the values are less consistent, thus making it harder to make
# predictions.

# The format “dataset[rows, columns]” can be used to specify the exact rows and
# columns to be considered. “dataset[, columns]” implies all rows will be
# considered. Specifying “Loans[, -4]” implies all the columns except column
# number 4. This can also be stated as “Loans[,
# c(1,2,3,5,6,7,8,9,10,11,12,13,14)]”. This allows us to calculate the standard
# deviation of only columns that are numeric, thus leaving out the columns
# termed as “factors” (categorical) or those that have a string data type.

# check data types
str(loans)
```

    ## spc_tbl_ [614 × 12] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ Gender           : chr [1:614] "Male" "Male" "Male" "Male" ...
    ##  $ Married          : chr [1:614] "No" "Yes" "Yes" "Yes" ...
    ##  $ Dependents       : chr [1:614] "0" "1" "0" "0" ...
    ##  $ Education        : chr [1:614] "Graduate" "Graduate" "Graduate" "Not Graduate" ...
    ##  $ SelfEmployed     : chr [1:614] "No" "No" "Yes" "No" ...
    ##  $ ApplicantIncome  : num [1:614] 5849 4583 3000 2583 6000 ...
    ##  $ CoapplicantIncome: num [1:614] 0 1508 0 2358 0 ...
    ##  $ LoanAmount       : num [1:614] 2600 4583 3000 2583 6000 ...
    ##  $ LoanAmountTerm   : num [1:614] 360 360 360 360 360 360 360 360 360 360 ...
    ##  $ CreditHistory    : num [1:614] 1 1 1 1 1 1 1 0 1 1 ...
    ##  $ PropertyArea     : chr [1:614] "Urban" "Rural" "Urban" "Urban" ...
    ##  $ Status           : chr [1:614] "Y" "N" "Y" "Y" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   Gender = col_character(),
    ##   ..   Married = col_character(),
    ##   ..   Dependents = col_character(),
    ##   ..   Education = col_character(),
    ##   ..   SelfEmployed = col_character(),
    ##   ..   ApplicantIncome = col_double(),
    ##   ..   CoapplicantIncome = col_double(),
    ##   ..   LoanAmount = col_double(),
    ##   ..   LoanAmountTerm = col_double(),
    ##   ..   CreditHistory = col_double(),
    ##   ..   PropertyArea = col_character(),
    ##   ..   Status = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
sapply(loans[, 9], sd)
```

    ## LoanAmountTerm 
    ##       64.44741

``` r
sapply(loans[, c(6, 7, 8, 9, 10)], sd)
```

    ##   ApplicantIncome CoapplicantIncome        LoanAmount    LoanAmountTerm 
    ##      6109.0416734      2926.2483692      6088.9864510        64.4474059 
    ##     CreditHistory 
    ##         0.3523386

``` r
# The data type should be double (not numeric) so that it can be calculated.


### STEP 9. Measure the kurtosis of each variable ---- The Kurtosis informs you
### of how often outliers occur in the results.

# There are different formulas for calculating kurtosis.  Specifying “type = 2”
# allows us to use the 2nd formula which is the same kurtosis formula used in
# SPSS and SAS. More details about any function can be obtained by searching
# the R help knowledge base. The knowledge base says:

# In “type = 2” (used in SPSS and SAS): 1.\tKurtosis < 3 implies a low number
# of outliers 2.\tKurtosis = 3 implies a medium number of outliers 3.\tKurtosis
# > 3 implies a high number of outliers

if (!is.element("e1071", installed.packages()[, 1])) {
    install.packages("e1071", dependencies = TRUE)
}
require("e1071")
```

    ## Loading required package: e1071

``` r
sapply(loans[, 10], kurtosis, type = 2)
```

    ## CreditHistory 
    ##      2.095179

``` r
### STEP 10. Measure the skewness of each variable ----

# The skewness informs you of the asymmetry of the distribution of results.
# Similar to kurtosis, there are several ways of computing the skewness.  Using
# “type = 2” can be interpreted as:

# 1.\tSkewness between -0.4 and 0.4 (inclusive) implies that there is no skew
# in the distribution of results; the distribution of results is symmetrical;
# it is a normal distribution.  2.\tSkewness above 0.4 implies a positive skew;
# a right-skewed distribution.  3.\tSkewness below -0.4 implies a negative
# skew; a left-skewed distribution.

sapply(loans[, 10], skewness, type = 2)
```

    ## CreditHistory 
    ##     -2.021971

``` r
# Note, executing: skewness(loans$Dependents, type=2) computes the skewness for
# one variable called “Dependents” in theloans dataset. However, executing the
# following enables you to compute the skewness for all the variables in the
# “loans” dataset except variable number 12:


## Measures of Relationship ----

## STEP 11. Measure the covariance between variables ---- Note that the
## covariance and the correlation are computed for numeric values only, not
## categorical values.
loans_cov <- cov(loans[, 6:10])
View(loans_cov)

## STEP 12. Measure the correlation between variables ----
loans_cor <- cor(loans[, 6:10])
View(loans_cor)


# Inferential Statistics ---- Read the following article:
# https://www.scribbr.com/statistics/inferential-statistics/ Statistical tests
# (either for comparison, correlation, or regression) can be used to conduct
# *hypothesis testing*.

## Parametric versus Non-Parametric Statistical Tests ---- If all the 3 points
## below are true, then use parametric tests, else use non-parametric tests.
## (i)\t the population that the sample comes from follows a normal
## distribution of scores (ii) the sample size is large enough to represent the
## population (iii) the variances of each group being compared are similar

## Statistical tests for comparison ---- (i)\t t Test: parametric; compares
## means; uses 2 samples.  (ii)\tANOVA: parametric; compares means; can use
## more than 3 samples.  (iii)\tMood’s median: non-parametric; compares
## medians; can use more than 2 samples.  (iv)\tWilcoxon signed-rank:
## non-parametric; compares distributions; uses 2 samples.  (v)\t Wilcoxon
## rank-sum (Mann-Whitney U): non-parametric; compares sums of rankings; uses 2
## samples.  (vi)\tKruskal-Wallis H: non-parametric; compares mean rankings;
## can use more than 3 samples.

## Statistical tests for correlation ---- (i)\t Pearson’s r: parametric;
## expects interval/ratio variables.  (ii)\tSpearman’s r: non-parametric;
## expects ordinal/interval/ratio variables.  (iii)\tChi square test of
## independence: non-parametric; nominal/ordinal variables.

## Statistical tests for regression ---- (i)\t Simple linear regression:
## predictor is 1 interval/ratio variable; outcome is 1 interval/ratio
## variable.  (ii)\tMultiple linear regression: predictor can be more than 2
## interval/ratio variables; outcome is 1 interval/ratio variable.
## (iii)\tLogistic regression: predictor is 1 variable (any type); outcome is 1
## binary variable.  (iv)\tNominal regression: predictor can be more than 1
## variable; outcome is 1 nominal variable.  (v)\t Ordinal regression:
## predictor can be more than 1 variable; outcome is 1 ordinal variable.


# Qualitative Data Analysis ---- This can be done through either thematic
# analysis: https://www.scribbr.com/methodology/thematic-analysis/ or critical
# discourse analysis: https://www.scribbr.com/methodology/discourse-analysis/

# Basic Visualization for Understanding the Dataset ----

# Note: If you are using R Studio, ensure that the 'Plots' window on the bottom
# right of R Studio has enough space to display the chart.

# The fastest way to improve your understanding of the dataset is to visualize
# it. Visualization can help you to spot outliers and give you an idea of
# possible data transformations you can apply. The basic visualizations to
# understand your dataset can be univariate visualizations (helps you to
# understand a single attribute) or multivariate visualizations (helps you to
# understand the interaction between attributes). Packages used to create
# visualizations include: (i)\t Graphics package: Used to quickly create basic
# plots of data. This is the most appropriate to quickly understand the dataset
# before conducting further analysis.  (ii) Lattice package: Used to create
# more visually appealing plots of data.  (iii) ggplot2 package: Used to create
# even more visually appealing plots of data that can then be used to present
# the analysis results to the intended users. Given its complexity, it is not
# necessary to use ggplot2 to have a basic understanding of the dataset prior
# to further analysis.

# Note that the goal at this point is to understand your data, not to create
# visually appealing plots that are publicly shared. The visually appealing
# plots will be created much later after the best prediction model has been
# chosen.

## Univariate Plots ---- STEP 13. Create Histograms for Each Numeric Attribute
## ---- Histograms help in determining whether an attribute has a Gaussian
## distribution. They can also be used to identify the presence of outliers.

# Execute the following code to create histograms for the “loans” dataset:
# Assuming your dataset is named 'loans' (replace with the actual name of your
# dataset)
data_types <- sapply(loans, class)
print(data_types)
```

    ##            Gender           Married        Dependents         Education 
    ##       "character"       "character"       "character"       "character" 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##       "character"         "numeric"         "numeric"         "numeric" 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##         "numeric"         "numeric"       "character"       "character"

``` r
# Execute the following code to create one histogram for attribute 4 (the only
# numeric column was “final crop yield (in bushels per acre)”) in the “: The
# code below converts column number 4 into unlisted and numeric data first so
# that a histogram can be plotted. Further reading:
# https://www.programmingr.com/r-error-messages/x-must-be-numeric-error-in-r-histogram/
# )

Loans_status <- as.numeric(unlist(loans[, 9]))
hist(Loans_status, main = names(loans)[9])
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Load%20Datasets-1.png)<!-- -->

``` r
### STEP 14. Create Box and Whisker Plots for Each Numeric Attribute ---- Box
### and whisker plots are useful in understanding the distribution of data.
### Further reading: https://www.scribbr.com/statistics/interquartile-range/

# Execute the following code to create box and whisker plots for the “”
# dataset: This considers the first 3 attributes which are numeric. The fourth
# attribute in the dataset is of the type “factor”, i.e., categorical.

par(mar = c(3, 3, 2, 1))

par(mfrow = c(6, 7))
for (i in 6:7) {
    boxplot(loans[, i], main = names(loans)[i])
}

# This considers the 5th to the 14th attributes which are numeric.  The fourth
# attribute in the dataset is of the type “factor”, i.e., categorical


boxplot(loans[, 6], main = names(loans)[6])
boxplot(loans[, 7], main = names(loans)[7])
boxplot(loans[, 8], main = names(loans)[8])
boxplot(loans[, 9], main = names(loans)[9])
boxplot(loans[, 10], main = names(loans)[10])


### STEP 15. Create Bar Plots for Each Categorical Attribute ---- Categorical
### attributes (factors) can also be visualized. This is done using a bar chart
### to give an idea of the proportion of instances that belong to each
### category.


barplot(table(loans[, 12]), main = names(loans)[12])

# Execute the following to create a bar plot for the categorical attributes 1
# to 11 in the “loans” dataset:

par(mfrow = c(1, 11))
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Load%20Datasets-2.png)<!-- -->

``` r
for (i in 1:11) {
    barplot(table(loans[, i]), main = names(loans)[i])
}
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Load%20Datasets-3.png)<!-- -->

``` r
### STEP 16. Create a Missingness Map to Identify Missing Data ---- Some
### machine learning algorithms cannot handle missing data. A missingness map
### (also known as a missing plot) can be used to get an idea of the amount
### missing data in the dataset. The x-axis of the missingness map shows the
### attributes of the dataset whereas the y-axis shows the instances in the
### dataset.  Horizontal lines indicate missing data for an instance whereas
### vertical lines indicate missing data for an attribute. The missingness map
### requires the “Amelia” package.

# Execute the following to create a map to identify the missing data in each
# dataset:
if (!is.element("Amelia", installed.packages()[, 1])) {
    install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")
```

    ## Loading required package: Amelia
    ## Loading required package: Rcpp
    ## ## 
    ## ## Amelia II: Multiple Imputation
    ## ## (Version 1.8.1, built: 2022-11-18)
    ## ## Copyright (C) 2005-2023 James Honaker, Gary King and Matthew Blackwell
    ## ## Refer to http://gking.harvard.edu/amelia/ for more information
    ## ##

``` r
missmap(loans, col = c("red", "grey"), legend = TRUE)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Load%20Datasets-4.png)<!-- -->

``` r
# As shown in the results, the datasets that was loaded in this lab has no
# missing data.

## Multivariate Plots ----

### STEP 17. Create a Correlation Plot ---- Correlation plots can be used to
### get an idea of which attributes change together. The function “corrplot()”
### found in the package “corrplot” is required to perform this. The larger the
### dot in the correlation plot, the larger the correlation. Blue represents a
### positive correlation whereas red represents a negative correlation.

# Execute the following to create correlation plots for 3 of the datasets
# loaded in STEP 2 to STEP 4:
if (!is.element("corrplot", installed.packages()[, 1])) {
    install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")
```

    ## Loading required package: corrplot
    ## corrplot 0.92 loaded

``` r
corrplot(cor(loans[, 6:10]), method = "circle")


# Alternatively, the 'ggcorrplot::ggcorrplot()' function can be used to plot a
# more visually appealing plot.  The code below shows how to install a package
# in R:
if (!is.element("ggcorrplot", installed.packages()[, 1])) {
    install.packages("ggcorrplot", dependencies = TRUE)
}
require("ggcorrplot")
```

    ## Loading required package: ggcorrplot

``` r
ggcorrplot(cor(loans[, 6:10]))


# Alternatively, the ggcorrplot package can be used to make the plots more
# appealing:
ggplot(loans, aes(x = Dependents, y = Education, shape = Status, color = Status)) +
    geom_point() + geom_smooth(method = lm)
```

    ## `geom_smooth()` using formula = 'y ~ x'

``` r
### STEP 18. Create Multivariate Box and Whisker Plots by Class ---- This
### applies to datasets where the target (dependent) variable is categorical.
### Execute the following code:
if (!is.element("caret", installed.packages()[, 1])) {
    install.packages("caret", dependencies = TRUE)
}
require("caret")
featurePlot(x = loans[, 1:12], y = loans[, 12], plot = "box")
```

    ## NULL

``` r
# References ---- Bevans, R. (2023a). ANOVA in R | A Complete Step-by-Step
# Guide with Examples. Scribbr. Retrieved August 24, 2023, from
# https://www.scribbr.com/statistics/anova-in-r/ ----

## Bevans, R. (2023b). Sample Crop Data Dataset for ANOVA (Version 1)
## [Dataset]. Scribbr.
## https://www.scribbr.com/wp-content/uploads//2020/03/crop.data_.anova_.zip
## ----

## Fisher, R. A. (1988). Iris [Dataset]. UCI Machine Learning Repository.
## https://archive.ics.uci.edu/dataset/53/iris ----

## National Institute of Diabetes and Digestive and Kidney Diseases. (1999).
## Pima Indians Diabetes Dataset [Dataset]. UCI Machine Learning Repository.
## https://www.kaggle.com/datasets/uciml/ ----

## StatLib CMU. (1997). Boston Housing [Dataset]. StatLib Carnegie Mellon
## University. http://lib.stat.cmu.edu/datasets/boston_corrected.txt ----
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Load%20Datasets-5.png)<!-- -->

## Milestone 1 out of 8

Issue 2 Inferential Statistics .

``` r
# 2: Inferential Statistics ----

# STEP 1. Install and use renv ---- **Initialization: Install and use renv ----
# The renv package helps you create reproducible environments for your



# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot() to record the packages and their sources in the lockfile.

# One of the packages required to use R in VS Code is the 'languageserver'
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

# Loading Datasets ---- STEP 2: Load datasets ----

library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/loans_imputed.csv")
```

    ## Rows: 614 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)

## Step 1; Perform ANOVA on the “loans_imputed_dataset” dataset ---- ANOVA
## (Analysis of Variance) is a statistical test used to estimate how a
## quantitative dependent variable changes according to the levels of one or
## more categorical independent variables.

# The null hypothesis (H0) of the ANOVA is that “there is no difference in
# means”, and the alternative hypothesis (Ha) is that “the means are different
# from one another”.

# We can use the “aov()” function in R to calculate the test statistic for
# ANOVA. The test statistic is in turn used to calculate the p-value of your
# results. A p-value is a number that describes how likely you are to have
# found a particular set of observations if the null hypothesis were true. The
# smaller the p-value, the more likely you are to reject the null-hypothesis.

# The “crop_dataset” sample dataset loaded in STEP 4 contains observations from
# an imaginary study of the effects of fertilizer type and planting density on
# crop yield. In other words:

# Dependent variable:\tStatus


# One-Way ANOVA can be used to test the effect of the 3 types of Property Areas
# on Credit History whereas, Two-Way ANOVA can be used to test the effect of
# the 3 types of fertilizer and the 2 types of planting density on crop yield.
summary(loans$Status)
```

    ##    Length     Class      Mode 
    ##       614 character character

``` r
summary(loans$Gender)
```

    ##    Length     Class      Mode 
    ##       614 character character

``` r
loans_dataset_one_way_anova <- aov(CreditHistory ~ PropertyArea, data = loans)
summary(loans_dataset_one_way_anova)
```

    ##               Df Sum Sq Mean Sq F value Pr(>F)
    ## PropertyArea   2    0.1 0.04966   0.399  0.671
    ## Residuals    611   76.0 0.12439

``` r
# This shows the result of each variable and the residual. The residual refers
# to all the variation that is not explained by the independent variable. The
# list below is a description of each column in the result:

# 1.  Df column: Displays the degrees of freedom for the independent variable
# (the number of levels (categories) in the variable minus 1), and the degrees
# of freedom for the residuals (the total number of observations minus the
# number of variables being estimated + 1, i.e., (df(Residuals)=n-(k+1)).

# 2.\tSum Sq column: Displays the sum of squares (a.k.a. the total variation
# between the group means and the overall mean). It is better to have a lower
# Sum Sq value for residuals.

# 3.  Mean Sq column: The mean of the sum of squares, calculated by dividing
# the sum of squares by the degrees of freedom for each parameter.

# 4.\tF value column: The test statistic from the F test. This is the mean
# square of each independent variable divided by the mean square of the
# residuals. The larger the F value, the more likely it is that the variation
# caused by the independent variable is real and not due to chance.

# 5.\tPr(>F) column: The p-value of the F statistic. This shows how likely it
# is that the F value calculated from the test would have occurred if the null
# hypothesis of “no difference among group means” were true.

# The three asterisk symbols (***) implies that the p-value is less than 0.001.
# P<0.001 can be interpreted as “the type of fertilizer used has an impact on
# the final crop yield”.

# We can also have a situation where the Credit History depends not only on the
# type of Property Area used but also on the Dependents. A two-way ANOVA can
# then be used to confirm this. Execute the following for a two-way ANOVA (two
# independent variables):

loans_dataset_additive_two_way_anova <- aov(CreditHistory ~ PropertyArea + Dependents,
    data = loans)
summary(loans_dataset_additive_two_way_anova)
```

    ##               Df Sum Sq Mean Sq F value Pr(>F)
    ## PropertyArea   2   0.10 0.04966   0.399  0.671
    ## Dependents     3   0.28 0.09362   0.752  0.522
    ## Residuals    608  75.72 0.12454

``` r
# Specifying an asterisk (*) instead of a plus (+) between the two independent
# variables (fertilizer * density) implies that they have an interaction effect
# rather than an additive effect.

# For example, an interaction effect would be that the fertilizer uptake by
# plants is affected by how close the plants are planted (density). An additive
# effect would be that the fertilizer uptake by plants is NOT affected by how
# close the plants are planted (density).

# Execute the following to perform a two-way ANOVA with the assumption that
# Credit History and Dependents have an interaction effect:

loans_dataset_interactive_two_way_anova <- aov(CreditHistory ~ PropertyArea * Dependents,
    data = loans)
summary(loans_dataset_interactive_two_way_anova)
```

    ##                          Df Sum Sq Mean Sq F value Pr(>F)
    ## PropertyArea              2   0.10 0.04966   0.400  0.670
    ## Dependents                3   0.28 0.09362   0.754  0.520
    ## PropertyArea:Dependents   6   1.01 0.16885   1.361  0.228
    ## Residuals               602  74.71 0.12410

``` r
# This can be interpreted as follows: The additive two-way ANOVA shows that the
# Credit History is affected by both the Property Area and the Dependents
# (P<0.001 for both independent variables).  The interactive two-way ANOVA also
# shows that the Credit History is affected by both the Property Area and the
# Dependents (P<0.001 for both independent variables).


# Qualitative Data Analysis ---- This can be done through either thematic
# analysis: https://www.scribbr.com/methodology/thematic-analysis/ or critical
# discourse analysis: https://www.scribbr.com/methodology/discourse-analysis/

# Basic Visualization for Understanding the Dataset ----

# Note: If you are using R Studio, ensure that the 'Plots' window on the bottom
# right of R Studio has enough space to display the chart.

# The fastest way to improve your understanding of the dataset is to visualize
# it. Visualization can help you to spot outliers and give you an idea of
# possible data transformations you can apply. The basic visualizations to
# understand your dataset can be univariate visualizations (helps you to
# understand a single attribute) or multivariate visualizations (helps you to
# understand the interaction between attributes). Packages used to create
# visualizations include: (i)\t Graphics package: Used to quickly create basic
# plots of data. This is the most appropriate to quickly understand the dataset
# before conducting further analysis.  (ii) Lattice package: Used to create
# more visually appealing plots of data.  (iii) ggplot2 package: Used to create
# even more visually appealing plots of data that can then be used to present
# the analysis results to the intended users. Given its complexity, it is not
# necessary to use ggplot2 to have a basic understanding of the dataset prior
# to further analysis.
```

## \<Milestone 1 out of 3\>

Issue 3 Basic Visualization.

``` r
# *****************************************************************************
# 3: Basic Visualization ----


# One of the packages required to use R in VS Code is the 'languageserver'
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

# Loading Datasets ---- STEP 2: Load datasets ----

library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/loans_imputed.csv")
```

    ## Rows: 614 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)

## Univariate Plots ---- STEP 1. Create Histograms for Each Numeric Attribute
## ---- Histograms help in determining whether an attribute has a Gaussian
## distribution. They can also be used to identify the presence of outliers.

# Execute the following code to create histograms for the “loans” dataset:
# Assuming your dataset is named 'loans' (replace with the actual name of your
# dataset)
data_types <- sapply(loans, class)
print(data_types)
```

    ##            Gender           Married        Dependents         Education 
    ##       "character"       "character"       "character"       "character" 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##       "character"         "numeric"         "numeric"         "numeric" 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##         "numeric"         "numeric"       "character"       "character"

``` r
# Execute the following code to create one histogram for attribute 4 (the only
# numeric column was “final crop yield (in bushels per acre)”) in the “: The
# code below converts column number 4 into unlisted and numeric data first so
# that a histogram can be plotted. Further reading:
# https://www.programmingr.com/r-error-messages/x-must-be-numeric-error-in-r-histogram/
# )


# Loans_status <- as.numeric(unlist(loans[, 6:7])) hist(Loans_status, main =
# names(loans)[, 6:7])



### STEP 2. Create Box and Whisker Plots for Each Numeric Attribute ---- Box
### and whisker plots are useful in understanding the distribution of data.
### Further reading: https://www.scribbr.com/statistics/interquartile-range/

class(loans)
```

    ## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"

``` r
summary(loans)
```

    ##     Gender            Married           Dependents         Education        
    ##  Length:614         Length:614         Length:614         Length:614        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##  SelfEmployed       ApplicantIncome CoapplicantIncome   LoanAmount   
    ##  Length:614         Min.   :  150   Min.   :    0     Min.   :  150  
    ##  Class :character   1st Qu.: 2878   1st Qu.:    0     1st Qu.: 2875  
    ##  Mode  :character   Median : 3812   Median : 1188     Median : 3768  
    ##                     Mean   : 5403   Mean   : 1621     Mean   : 5371  
    ##                     3rd Qu.: 5795   3rd Qu.: 2297     3rd Qu.: 5746  
    ##                     Max.   :81000   Max.   :41667     Max.   :81000  
    ##  LoanAmountTerm  CreditHistory   PropertyArea          Status         
    ##  Min.   : 12.0   Min.   :0.000   Length:614         Length:614        
    ##  1st Qu.:360.0   1st Qu.:1.000   Class :character   Class :character  
    ##  Median :360.0   Median :1.000   Mode  :character   Mode  :character  
    ##  Mean   :342.3   Mean   :0.855                                        
    ##  3rd Qu.:360.0   3rd Qu.:1.000                                        
    ##  Max.   :480.0   Max.   :1.000

``` r
colnames(loans)
```

    ##  [1] "Gender"            "Married"           "Dependents"       
    ##  [4] "Education"         "SelfEmployed"      "ApplicantIncome"  
    ##  [7] "CoapplicantIncome" "LoanAmount"        "LoanAmountTerm"   
    ## [10] "CreditHistory"     "PropertyArea"      "Status"

``` r
par(mar = c(3, 3, 2, 1))

par(mfrow = c(6, 7))
for (i in 6:7) {
    boxplot(loans[, i], main = names(loans)[i])
}

# This considers the 6th to the 7th attributes which are numeric.  The fourth
# attribute in the dataset is of the type “factor”, i.e., categorical

boxplot(loans[, 6], main = names(loans)[6])
boxplot(loans[, 7], main = names(loans)[7])
boxplot(loans[, 8], main = names(loans)[8])
boxplot(loans[, 9], main = names(loans)[9])
boxplot(loans[, 10], main = names(loans)[10])



### STEP 3. Create Bar Plots for Each Categorical Attribute ---- Categorical
### attributes (factors) can also be visualized. This is done using a bar chart
### to give an idea of the proportion of instances that belong to each
### category.


barplot(table(loans[, 10]), main = names(loans)[10])

# Execute the following to create a bar plot for the categorical attributes 1
# to 11 in the “loans” dataset:
par(mar = c(3, 3, 2, 1))

par(mfrow = c(1, 5))
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Fifth%20Code%20Chunk-1.png)<!-- -->

``` r
for (i in 1:5) {
    barplot(table(loans[, i]), main = names(loans)[i])
}
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Fifth%20Code%20Chunk-2.png)<!-- -->

``` r
### STEP 4. Create a Missingness Map to Identify Missing Data ---- Some machine
### learning algorithms cannot handle missing data. A missingness map (also
### known as a missing plot) can be used to get an idea of the amount missing
### data in the dataset. The x-axis of the missingness map shows the attributes
### of the dataset whereas the y-axis shows the instances in the dataset.
### Horizontal lines indicate missing data for an instance whereas vertical
### lines indicate missing data for an attribute. The missingness map requires
### the “Amelia” package.

# Execute the following to create a map to identify the missing data in each
# dataset:
if (!is.element("Amelia", installed.packages()[, 1])) {
    install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")

missmap(loans, col = c("red", "grey"), legend = TRUE)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Fifth%20Code%20Chunk-3.png)<!-- -->

``` r
# As shown in the results, the datasets that was loaded in this lab has no
# missing data.

## Multivariate Plots ----

### STEP 5. Create a Correlation Plot ---- Correlation plots can be used to get
### an idea of which attributes change together. The function “corrplot()”
### found in the package “corrplot” is required to perform this. The larger the
### dot in the correlation plot, the larger the correlation. Blue represents a
### positive correlation whereas red represents a negative correlation.

# Execute the following to create correlation plots for 3 of the datasets
# loaded in STEP 2 to STEP 4:
if (!is.element("corrplot", installed.packages()[, 1])) {
    install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")
corrplot(cor(loans[, 6:10]), method = "circle")


# Alternatively, the 'ggcorrplot::ggcorrplot()' function can be used to plot a
# more visually appealing plot.  The code below shows how to install a package
# in R:
if (!is.element("ggcorrplot", installed.packages()[, 1])) {
    install.packages("ggcorrplot", dependencies = TRUE)
}
require("ggcorrplot")
ggcorrplot(cor(loans[, 6:10]))


# Alternatively, the ggcorrplot package can be used to make the plots more
# appealing:
ggplot(loans, aes(x = Dependents, y = Education, shape = Status, color = Status)) +
    geom_point() + geom_smooth(method = lm)
```

    ## `geom_smooth()` using formula = 'y ~ x'

``` r
### STEP 6. Create Multivariate Box and Whisker Plots by Class ---- This
### applies to datasets where the target (dependent) variable is categorical.
### Execute the following code:
if (!is.element("caret", installed.packages()[, 1])) {
    install.packages("caret", dependencies = TRUE)
}
require("caret")
featurePlot(x = loans[, 1:12], y = loans[, 12], plot = "box")
```

    ## NULL

``` r
# References ---- Bevans, R. (2023a). ANOVA in R | A Complete Step-by-Step
# Guide with Examples. Scribbr. Retrieved August 24, 2023, from
# https://www.scribbr.com/statistics/anova-in-r/ ----

## Bevans, R. (2023b). Sample Crop Data Dataset for ANOVA (Version 1)
## [Dataset]. Scribbr.
## https://www.scribbr.com/wp-content/uploads//2020/03/crop.data_.anova_.zip
## ----

## Fisher, R. A. (1988). Iris [Dataset]. UCI Machine Learning Repository.
## https://archive.ics.uci.edu/dataset/53/iris ----

## National Institute of Diabetes and Digestive and Kidney Diseases. (1999).
## Pima Indians Diabetes Dataset [Dataset]. UCI Machine Learning Repository.
## https://www.kaggle.com/datasets/uciml/ ----

## StatLib CMU. (1997). Boston Housing [Dataset]. StatLib Carnegie Mellon
## University. http://lib.stat.cmu.edu/datasets/boston_corrected.txt ----


# Upload *the link* to 'Lab-Submission-Markdown.md' (not .Rmd) markdown file
# hosted on Github (do not upload the .Rmd or .md markdown files) through the
# submission link provided on eLearning.
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Fifth%20Code%20Chunk-4.png)<!-- -->

## \<Milestone 2 out of 8\>

Issue 5 Processing and Data Transformation.

``` r
# 5: Data Imputation ----

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("languageserver")

# Introduction ---- Data imputation, also known as missing data imputation, is
# a technique used in data analysis and statistics to fill in missing values in
# a dataset.  Missing data can occur due to various reasons, such as equipment
# malfunction, human error, or non-response in surveys.

# Imputing missing data is important because many statistical analysis methods
# and Machine Learning algorithms require complete datasets to produce accurate
# and reliable results. By filling in the missing values, data imputation helps
# to preserve the integrity and usefulness of the dataset.

## Data Imputation Methods ----

### 1. Mean/Median Imputation ----

# This method involves replacing missing values with the mean or median value
# of the available data for that variable. It is a simple and quick approach
# but does not consider any relationships between variables.

# Unlike the recorded values, mean-imputed values do not include natural
# variance. Therefore, they are less “scattered” and would technically minimize
# the standard error in a linear regression. We would perceive our estimates to
# be more accurate than they actually are in real-life.

### 2. Regression Imputation ---- In this approach, missing values are
### estimated by regressing the variable with missing values on other variables
### that are known. The estimated values are then used to fill in the missing
### values.

### 3. Multiple Imputation ---- Multiple imputation involves creating several
### plausible imputations for each missing value based on statistical models
### that capture the relationships between variables. This technique recognizes
### the uncertainty associated with imputing missing values.

### 4. Machine Learning-Based Imputation ---- Machine learning algorithms can
### be used to predict missing values based on the patterns and relationships
### present in the available data. Techniques such as K-Nearest Neighbours
### (KNN) imputation or decision tree-based imputation can be employed.

### 5. Hot Deck Imputation ---- This method involves finding similar cases
### (referred to as donors) that have complete data and using their values to
### impute missing values in other cases (referred to as recipients).

### 6. Multiple Imputation by Chained Equations (MICE) ---- MICE is flexible
### and can handle different variable types at once (e.g., continuous, binary,
### ordinal etc.). For each variable containing missing values, we can use the
### remaining information in the data to train a model that predicts what could
### have been recorded to fill in the blanks.  To account for the statistical
### uncertainty in the imputations, the MICE procedure goes through several
### rounds and computes replacements for missing values in each round. As the
### name suggests, we thus fill in the missing values multiple times and create
### several complete datasets before we pool the results to arrive at more
### realistic results.

## Types of Missing Data ---- 1. Missing Not At Random (MNAR) ---- Locations of
## missing values in the dataset depend on the missing values themselves. For
## example, students submitting a course evaluation tend to report positive or
## neutral responses and skip questions that will result in a negative
## response. Such students may systematically leave the following question
## blank because they are uncomfortable giving a bad rating for their lecturer:
## “Classes started and ended on time”.

### 2. Missing At Random (MAR) ---- Locations of missing values in the dataset
### depend on some other observed data. In the case of course evaluations,
### students who are not certain about a response may feel unable to give
### accurate responses on a numeric scale, for example, the question 'I
### developed my oral and writing skills ' may be difficult to measure on a
### scale of 1-5. Subsequently, if such questions are optional, they rarely get
### a response because it depends on another unobserved mechanism: in this
### case, the individual need for more precise self-assessments.

### 3. Missing Completely At Random (MCAR) ---- In this case, the locations of
### missing values in the dataset are purely random and they do not depend on
### any other data.

# In all the above cases, removing the entire response because one question has
# missing data may distort the results.

# If the data are MAR or MNAR, imputing missing values is advisable.

# STEP 1. Install and Load the Required Packages ---- The following packages
# should be installed and loaded before proceeding to the subsequent steps.

## NHANES ---- The dataset we will use (for educational purposes) is the US
## National Health and Nutrition Examination Study (NHANES) dataset created
## from 1999 to 2004.

# Documentation of NHANES: https://cran.r-project.org/package=NHANES or
# https://cran.r-project.org/web/packages/NHANES/NHANES.pdf or
# http://www.cdc.gov/nchs/nhanes.htm

# This requires the 'NHANES' package available in R

if (!is.element("NHANES", installed.packages()[, 1])) {
    install.packages("NHANES", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("NHANES")
```

    ## Loading required package: NHANES

``` r
## dplyr ----
if (!is.element("dplyr", installed.packages()[, 1])) {
    install.packages("dplyr", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("dplyr")
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following object is masked from 'package:randomForest':
    ## 
    ##     combine

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
## naniar ---- Documentation: https://cran.r-project.org/package=naniar or
## https://www.rdocumentation.org/packages/naniar/versions/1.0.0
if (!is.element("naniar", installed.packages()[, 1])) {
    install.packages("naniar", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("naniar")
```

    ## Loading required package: naniar

``` r
## ggplot2 ---- We require the 'ggplot2' package to create more appealing
## visualizations
if (!is.element("ggplot2", installed.packages()[, 1])) {
    install.packages("ggplot2", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("ggplot2")

## MICE ---- We use the MICE package to perform data imputation
if (!is.element("mice", installed.packages()[, 1])) {
    install.packages("mice", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("mice")
```

    ## Loading required package: mice

    ## 
    ## Attaching package: 'mice'

    ## The following object is masked from 'package:kernlab':
    ## 
    ##     convergence

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following objects are masked from 'package:base':
    ## 
    ##     cbind, rbind

``` r
## Amelia ----
if (!is.element("Amelia", installed.packages()[, 1])) {
    install.packages("Amelia", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("Amelia")

# STEP 2. We Load the dataset ----
library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/Loans.csv")
```

    ## Rows: 614 Columns: 12

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)

# STEP 3. Confirm the 'missingness' in the Dataset before Imputation ---- Are
# there missing values in the dataset?
any_na(loans)
```

    ## [1] TRUE

``` r
# How many?
n_miss(loans)
```

    ## [1] 110

``` r
# What is the percentage of missing data in the entire dataset?
prop_miss(loans)
```

    ## [1] 0.01492942

``` r
# How many missing values does each variable have?
loans %>%
    is.na() %>%
    colSums()
```

    ##            Gender           Married        Dependents         Education 
    ##                10                 2                13                 0 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##                27                 0                 0                 5 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##                 8                45                 0                 0

``` r
# What is the number and percentage of missing values grouped by each variable?
miss_var_summary(loans)
```

    ## # A tibble: 12 × 3
    ##    variable          n_miss pct_miss
    ##    <chr>              <int>    <dbl>
    ##  1 CreditHistory         45    7.33 
    ##  2 SelfEmployed          27    4.40 
    ##  3 Dependents            13    2.12 
    ##  4 Gender                10    1.63 
    ##  5 LoanAmountTerm         8    1.30 
    ##  6 LoanAmount             5    0.814
    ##  7 Married                2    0.326
    ##  8 Education              0    0    
    ##  9 ApplicantIncome        0    0    
    ## 10 CoapplicantIncome      0    0    
    ## 11 PropertyArea           0    0    
    ## 12 Status                 0    0

``` r
# What is the number and percentage of missing values grouped by each
# observation?
miss_case_summary(loans)
```

    ## # A tibble: 614 × 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1   229      2    16.7 
    ##  2   237      2    16.7 
    ##  3   336      2    16.7 
    ##  4   412      2    16.7 
    ##  5   436      2    16.7 
    ##  6   461      2    16.7 
    ##  7   601      2    16.7 
    ##  8     1      1     8.33
    ##  9    17      1     8.33
    ## 10    25      1     8.33
    ## # ℹ 604 more rows

``` r
# Which variables contain the most missing values?
gg_miss_var(loans)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Sixth%20Code%20Chunk-1.png)<!-- -->

``` r
# Where are missing values located (the shaded regions in the plot)?
vis_miss(loans) + theme(axis.text.x = element_text(angle = 80))
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Sixth%20Code%20Chunk-2.png)<!-- -->

``` r
# Which combinations of variables are missing together?
gg_miss_upset(loans)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Sixth%20Code%20Chunk-3.png)<!-- -->

``` r
# Create a heatmap of 'missingness' broken down by 'SelfEmployed' First,
# confirm that the 'SelfEmployed' variable is a categorical variable
data_types <- sapply(loans, class)
print(data_types)
```

    ##            Gender           Married        Dependents         Education 
    ##       "character"       "character"       "character"       "character" 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##       "character"         "numeric"         "numeric"         "numeric" 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##         "numeric"         "numeric"       "character"       "character"

``` r
is.factor(loans$SelfEmployed)
```

    ## [1] FALSE

``` r
# Second, create the visualization
gg_miss_fct(loans, fct = SelfEmployed)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Sixth%20Code%20Chunk-4.png)<!-- -->

``` r
# We can also create a heatmap of 'missingness' broken down by 'Dependents'
# First, confirm that the 'Dependents' variable is a categorical variable
is.factor(loans$Dependents)
```

    ## [1] FALSE

``` r
# Second, create the visualization
gg_miss_fct(loans, fct = Dependents)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Sixth%20Code%20Chunk-5.png)<!-- -->

# STEP 4./<Use the MICE package to perform data imputation/>

Issue 5 Processing and Data Transformation.

``` r
# 5b: Data Imputation ----

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("languageserver")

# Introduction ---- Data imputation, also known as missing data imputation, is
# a technique used in data analysis and statistics to fill in missing values in
# a dataset.  Missing data can occur due to various reasons, such as equipment
# malfunction, human error, or non-response in surveys.

# Imputing missing data is important because many statistical analysis methods
# and Machine Learning algorithms require complete datasets to produce accurate
# and reliable results. By filling in the missing values, data imputation helps
# to preserve the integrity and usefulness of the dataset.

## Data Imputation Methods ----

### 1. Mean/Median Imputation ----

# This method involves replacing missing values with the mean or median value
# of the available data for that variable. It is a simple and quick approach
# but does not consider any relationships between variables.

# Unlike the recorded values, mean-imputed values do not include natural
# variance. Therefore, they are less “scattered” and would technically minimize
# the standard error in a linear regression. We would perceive our estimates to
# be more accurate than they actually are in real-life.

### 2. Regression Imputation ---- In this approach, missing values are
### estimated by regressing the variable with missing values on other variables
### that are known. The estimated values are then used to fill in the missing
### values.

### 3. Multiple Imputation ---- Multiple imputation involves creating several
### plausible imputations for each missing value based on statistical models
### that capture the relationships between variables. This technique recognizes
### the uncertainty associated with imputing missing values.

### 4. Machine Learning-Based Imputation ---- Machine learning algorithms can
### be used to predict missing values based on the patterns and relationships
### present in the available data. Techniques such as K-Nearest Neighbours
### (KNN) imputation or decision tree-based imputation can be employed.

### 5. Hot Deck Imputation ---- This method involves finding similar cases
### (referred to as donors) that have complete data and using their values to
### impute missing values in other cases (referred to as recipients).

### 6. Multiple Imputation by Chained Equations (MICE) ---- MICE is flexible
### and can handle different variable types at once (e.g., continuous, binary,
### ordinal etc.). For each variable containing missing values, we can use the
### remaining information in the data to train a model that predicts what could
### have been recorded to fill in the blanks.  To account for the statistical
### uncertainty in the imputations, the MICE procedure goes through several
### rounds and computes replacements for missing values in each round. As the
### name suggests, we thus fill in the missing values multiple times and create
### several complete datasets before we pool the results to arrive at more
### realistic results.

## Types of Missing Data ---- 1. Missing Not At Random (MNAR) ---- Locations of
## missing values in the dataset depend on the missing values themselves. For
## example, students submitting a course evaluation tend to report positive or
## neutral responses and skip questions that will result in a negative
## response. Such students may systematically leave the following question
## blank because they are uncomfortable giving a bad rating for their lecturer:
## “Classes started and ended on time”.

### 2. Missing At Random (MAR) ---- Locations of missing values in the dataset
### depend on some other observed data. In the case of course evaluations,
### students who are not certain about a response may feel unable to give
### accurate responses on a numeric scale, for example, the question 'I
### developed my oral and writing skills ' may be difficult to measure on a
### scale of 1-5. Subsequently, if such questions are optional, they rarely get
### a response because it depends on another unobserved mechanism: in this
### case, the individual need for more precise self-assessments.

### 3. Missing Completely At Random (MCAR) ---- In this case, the locations of
### missing values in the dataset are purely random and they do not depend on
### any other data.

# In all the above cases, removing the entire response because one question has
# missing data may distort the results.

# If the data are MAR or MNAR, imputing missing values is advisable.

# STEP 1. Install and Load the Required Packages ---- The following packages
# should be installed and loaded before proceeding to the subsequent steps.

## NHANES ---- The dataset we will use (for educational purposes) is the US
## National Health and Nutrition Examination Study (NHANES) dataset created
## from 1999 to 2004.

# Documentation of NHANES: https://cran.r-project.org/package=NHANES or
# https://cran.r-project.org/web/packages/NHANES/NHANES.pdf or
# http://www.cdc.gov/nchs/nhanes.htm

# This requires the 'NHANES' package available in R

if (!is.element("NHANES", installed.packages()[, 1])) {
    install.packages("NHANES", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("NHANES")

## dplyr ----
if (!is.element("dplyr", installed.packages()[, 1])) {
    install.packages("dplyr", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("dplyr")

## naniar ---- Documentation: https://cran.r-project.org/package=naniar or
## https://www.rdocumentation.org/packages/naniar/versions/1.0.0
if (!is.element("naniar", installed.packages()[, 1])) {
    install.packages("naniar", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("naniar")

## ggplot2 ---- We require the 'ggplot2' package to create more appealing
## visualizations
if (!is.element("ggplot2", installed.packages()[, 1])) {
    install.packages("ggplot2", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("ggplot2")

## MICE ---- We use the MICE package to perform data imputation
if (!is.element("mice", installed.packages()[, 1])) {
    install.packages("mice", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("mice")

## Amelia ----
if (!is.element("Amelia", installed.packages()[, 1])) {
    install.packages("Amelia", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("Amelia")

# STEP 2. We Load the dataset ----
library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/Loans.csv")
```

    ## Rows: 614 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)

# We can use the dplyr::mutate() function inside the dplyr package to add new
# variables that are functions of existing variables


# We finally begin to make use of Multivariate Imputation by Chained Equations
# (MICE). We use 11 multiple imputations.

# To arrive at good predictions for each variable containing missing values, we
# save the variables that are at least 'somewhat correlated' (r > 0.3).
somewhat_correlated_variables <- quickpred(loans, mincor = 0.3)

# m = 11 Specifies that the imputation (filling in the missing data) will be
# performed 11 times (multiple times) to create several complete datasets
# before we pool the results to arrive at a more realistic final result. The
# larger the value of 'm' and the larger the dataset, the longer the data
# imputation will take.  seed = 7 Specifies that number 7 will be used to
# offset the random number generator used by mice. This is so that we get the
# same results each time we run MICE.  meth = 'pmm' Specifies the imputation
# method. 'pmm' stands for 'Predictive Mean Matching' and it can be used for
# numeric data.  Other methods include: 1. 'logreg': logistic regression
# imputation; used for binary categorical data 2. 'polyreg': Polytomous
# Regression Imputation for unordered categorical data with more than 2
# categories, and 3. 'polr': Proportional Odds model for ordered categorical
# data with more than 2 categories.


loans_mice <- mice(loans, m = 20, method = "pmm", seed = 7, predictorMatrix = somewhat_correlated_variables)
```

    ## 
    ##  iter imp variable
    ##   1   1  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   2  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   3  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   4  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   5  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   6  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   7  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   8  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   9  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   10  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   11  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   12  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   13  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   14  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   15  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   16  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   17  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   18  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   19  LoanAmount  LoanAmountTerm  CreditHistory
    ##   1   20  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   1  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   2  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   3  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   4  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   5  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   6  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   7  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   8  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   9  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   10  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   11  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   12  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   13  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   14  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   15  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   16  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   17  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   18  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   19  LoanAmount  LoanAmountTerm  CreditHistory
    ##   2   20  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   1  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   2  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   3  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   4  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   5  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   6  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   7  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   8  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   9  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   10  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   11  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   12  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   13  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   14  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   15  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   16  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   17  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   18  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   19  LoanAmount  LoanAmountTerm  CreditHistory
    ##   3   20  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   1  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   2  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   3  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   4  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   5  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   6  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   7  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   8  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   9  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   10  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   11  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   12  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   13  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   14  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   15  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   16  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   17  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   18  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   19  LoanAmount  LoanAmountTerm  CreditHistory
    ##   4   20  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   1  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   2  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   3  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   4  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   5  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   6  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   7  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   8  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   9  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   10  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   11  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   12  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   13  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   14  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   15  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   16  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   17  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   18  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   19  LoanAmount  LoanAmountTerm  CreditHistory
    ##   5   20  LoanAmount  LoanAmountTerm  CreditHistory

``` r
# One can then train a model to predict MAP using BMI and PhysActiveDays or to
# identify the p-Value and confidence intervals between MAP and BMI and
# PhysActiveDays


## Impute the missing data ---- We then create imputed data for the final
## dataset using the mice::complete() function in the mice package to fill in
## the missing data.
loans_imputed <- mice::complete(loans_mice, 1)

# STEP 5. Confirm the 'missingness' in the Imputed Dataset ---- A textual
# confirmation that the dataset has no more missing values in any feature:
miss_var_summary(loans_imputed)
```

    ## # A tibble: 12 × 3
    ##    variable          n_miss pct_miss
    ##    <chr>              <int>    <dbl>
    ##  1 SelfEmployed          27    4.40 
    ##  2 Dependents            13    2.12 
    ##  3 Gender                10    1.63 
    ##  4 Married                2    0.326
    ##  5 Education              0    0    
    ##  6 ApplicantIncome        0    0    
    ##  7 CoapplicantIncome      0    0    
    ##  8 LoanAmount             0    0    
    ##  9 LoanAmountTerm         0    0    
    ## 10 CreditHistory          0    0    
    ## 11 PropertyArea           0    0    
    ## 12 Status                 0    0

``` r
# A visual confirmation that the dataset has no more missing values in any
# feature:
Amelia::missmap(loans_imputed)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Seventh%20Code%20Chunk-1.png)<!-- -->

``` r
######################### Are there missing values in the dataset?
any_na(loans_imputed)
```

    ## [1] TRUE

``` r
# How many?
n_miss(loans_imputed)
```

    ## [1] 52

``` r
# What is the percentage of missing data in the entire dataset?
prop_miss(loans_imputed)
```

    ## [1] 0.007057546

``` r
# How many missing values does each variable have?
loans_imputed %>%
    is.na() %>%
    colSums()
```

    ##            Gender           Married        Dependents         Education 
    ##                10                 2                13                 0 
    ##      SelfEmployed   ApplicantIncome CoapplicantIncome        LoanAmount 
    ##                27                 0                 0                 0 
    ##    LoanAmountTerm     CreditHistory      PropertyArea            Status 
    ##                 0                 0                 0                 0

``` r
# What is the number and percentage of missing values grouped by each variable?
miss_var_summary(loans_imputed)
```

    ## # A tibble: 12 × 3
    ##    variable          n_miss pct_miss
    ##    <chr>              <int>    <dbl>
    ##  1 SelfEmployed          27    4.40 
    ##  2 Dependents            13    2.12 
    ##  3 Gender                10    1.63 
    ##  4 Married                2    0.326
    ##  5 Education              0    0    
    ##  6 ApplicantIncome        0    0    
    ##  7 CoapplicantIncome      0    0    
    ##  8 LoanAmount             0    0    
    ##  9 LoanAmountTerm         0    0    
    ## 10 CreditHistory          0    0    
    ## 11 PropertyArea           0    0    
    ## 12 Status                 0    0

``` r
# What is the number and percentage of missing values grouped by each
# observation?
miss_case_summary(loans_imputed)
```

    ## # A tibble: 614 × 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1   229      2    16.7 
    ##  2   436      2    16.7 
    ##  3    96      1     8.33
    ##  4   108      1     8.33
    ##  5   112      1     8.33
    ##  6   115      1     8.33
    ##  7   121      1     8.33
    ##  8   159      1     8.33
    ##  9   171      1     8.33
    ## 10   189      1     8.33
    ## # ℹ 604 more rows

``` r
# Which variables contain the most missing values?
gg_miss_var(loans_imputed)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Seventh%20Code%20Chunk-2.png)<!-- -->

``` r
# We require the 'ggplot2' package to create more appealing visualizations

# Where are missing values located (the shaded regions in the plot)?
vis_miss(loans_imputed) + theme(axis.text.x = element_text(angle = 80))
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Seventh%20Code%20Chunk-3.png)<!-- -->

``` r
# Which combinations of variables are missing together?

# Note: The following command should give you an error stating that at least 2
# variables should have missing data for the plot to be created.
# gg_miss_upset(loans_imputed)
```

## \<Milestone 7 out of 8\>

Issue 7 Hyper Parameter Tuning and Ensembles.

``` r
# 7. Hyper Parameter Tuning and Ensemble Methods ----


# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
    require("languageserver")
} else {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# Introduction ---- In addition to hyperparameter tuning, you can also combine
# the predictions of multiple different models together. This is called an
# 'ensemble prediction'.

## Ensemble Methods ---- (1) Bagging (Bootstrap Aggregation) ---- Building
## multiple models (typically models of the same type) from different
## subsamples of the training dataset.

### (2) Boosting ---- Building multiple models (typically models of the same
### type) each of which learns to fix the prediction errors of a prior model in
### the chain.

### (3) Stacking ---- Building multiple models (typically models of differing
### types) and a supervised model that learns how to best combine the
### predictions of the primary models.

# STEP 1. Install and Load the Required Packages ---- mlbench ----
if (require("mlbench")) {
    require("mlbench")
} else {
    install.packages("mlbench", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
    require("caret")
} else {
    install.packages("caret", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## caretEnsemble ----
if (require("caretEnsemble")) {
    require("caretEnsemble")
} else {
    install.packages("caretEnsemble", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: caretEnsemble

    ## 
    ## Attaching package: 'caretEnsemble'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     autoplot

``` r
## C50 ----
if (require("C50")) {
    require("C50")
} else {
    install.packages("C50", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: C50

``` r
## adabag ----
if (require("adabag")) {
    require("adabag")
} else {
    install.packages("adabag", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: adabag

    ## Loading required package: rpart

    ## Loading required package: foreach

    ## Loading required package: doParallel

    ## Loading required package: iterators

    ## Loading required package: parallel

``` r
## randomForest ----
if (require("randomForest")) {
    require("randomForest")
} else {
    install.packages("randomForest", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## mlbench ----
if (require("mlbench")) {
    require("mlbench")
} else {
    install.packages("mlbench", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
    require("caret")
} else {
    install.packages("caret", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## RRF ----
if (require("RRF")) {
    require("RRF")
} else {
    install.packages("RRF", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: RRF

    ## Registered S3 method overwritten by 'RRF':
    ##   method      from        
    ##   plot.margin randomForest

    ## RRF 1.9.4

    ## Type rrfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'RRF'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    ## The following objects are masked from 'package:randomForest':
    ## 
    ##     classCenter, combine, getTree, grow, importance, margin, MDSplot,
    ##     na.roughfix, outlier, partialPlot, treesize, varImpPlot, varUsed

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

``` r
if (!requireNamespace("gbm", quietly = TRUE)) {
    install.packages("gbm")
}


# STEP 2. Load the Dataset ----
library(readr)
loans <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/loans_imputed.csv")
```

    ## Rows: 614 Columns: 12

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans)


# 1. Bagging ---- Two popular bagging algorithms are: 1. Bagged CART 2. Random
# Forest

# Example of Bagging algorithms
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
seed <- 7
metric <- "Accuracy"

## 2.a. Bagged CART ----
set.seed(seed)
loans_model_bagged_cart <- train(Status ~ ., data = loans, method = "treebag", metric = metric,
    trControl = train_control)

## 2.b. Random Forest ----
set.seed(seed)
loans_model_rf <- train(Status ~ ., data = loans, method = "rf", metric = metric,
    trControl = train_control)

# Summarize results
bagging_results <- resamples(list(`Bagged Decision Tree` = loans_model_bagged_cart,
    `Random Forest` = loans_model_rf))

summary(bagging_results)
```

    ## 
    ## Call:
    ## summary.resamples(object = bagging_results)
    ## 
    ## Models: Bagged Decision Tree, Random Forest 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##                           Min.   1st Qu.    Median      Mean   3rd Qu.
    ## Bagged Decision Tree 0.6557377 0.7377049 0.7704918 0.7626969 0.7928187
    ## Random Forest        0.7377049 0.7877446 0.8064516 0.8050728 0.8225806
    ##                           Max. NA's
    ## Bagged Decision Tree 0.8387097    0
    ## Random Forest        0.8524590    0
    ## 
    ## Kappa 
    ##                            Min.   1st Qu.    Median      Mean   3rd Qu.
    ## Bagged Decision Tree 0.07775378 0.3332556 0.4249484 0.4041174 0.4958678
    ## Random Forest        0.23390895 0.4331779 0.4728576 0.4699364 0.5240579
    ##                           Max. NA's
    ## Bagged Decision Tree 0.5656051    0
    ## Random Forest        0.6047516    0

``` r
dotplot(bagging_results)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-1.png)<!-- -->

``` r
# 2. Boosting ---- Three popular boosting algorithms are: 1. AdaBoost.M1 2.
# C5.0 3. Stochastic Gradient Boosting

# Example of Boosting Algorithms
train_control <- trainControl(method = "cv", number = 5)
seed <- 7
metric <- "Accuracy"

## 1.a. Boosting with C5.0 ---- C5.0
set.seed(seed)
loans_model_c50 <- train(Status ~ ., data = loans, method = "C5.0", metric = metric,
    trControl = train_control)

## 1.b. Boosting with Stochastic Gradient Boosting ----
set.seed(seed)
loans_model_gbm <- train(Status ~ ., data = loans, method = "gbm", metric = metric,
    trControl = train_control, verbose = FALSE)


# 3. Stacking ---- The 'caretEnsemble' package allows you to combine the
# predictions of multiple caret models.

## caretEnsemble::caretStack() ---- Given a list of caret models, the
## 'caretStack()' function (in the 'caretEnsemble' package) can be used to
## specify a higher-order model to learn how to best combine together the
## predictions of sub-models.

## caretEnsemble::caretList() ---- The 'caretList()' function provided by the
## 'caretEnsemble' package can be used to create a list of standard caret
## models.

# Example of Stacking algorithms
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = TRUE,
    classProbs = TRUE)
set.seed(seed)

algorithm_list <- c("glm", "lda", "rpart", "knn", "svmRadial")
models <- caretList(Status ~ ., data = loans, trControl = train_control, methodList = algorithm_list)

# Summarize results before stacking
results <- resamples(models)
summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: glm, lda, rpart, knn, svmRadial 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##                Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## glm       0.7377049 0.7868852 0.8196721 0.8120402 0.8380487 0.8571429    0
    ## lda       0.7419355 0.7909836 0.8196721 0.8131331 0.8380487 0.8571429    0
    ## rpart     0.7419355 0.7704918 0.7950820 0.7979722 0.8319672 0.8524590    0
    ## knn       0.5806452 0.6154151 0.6371324 0.6449577 0.6760973 0.7377049    0
    ## svmRadial 0.7419355 0.7868852 0.8196721 0.8077383 0.8225806 0.8524590    0
    ## 
    ## Kappa 
    ##                 Min.    1st Qu.      Median         Mean   3rd Qu.      Max.
    ## glm        0.2606061  0.4185118  0.50037230  0.488780836 0.5767215 0.6467290
    ## lda        0.2883788  0.4185118  0.50037230  0.490406183 0.5767215 0.6467290
    ## rpart      0.2945258  0.3977580  0.46117990  0.463905092 0.5627234 0.6047516
    ## knn       -0.1757903 -0.0797002 -0.04902565 -0.006883191 0.0666972 0.2052117
    ## svmRadial  0.2883788  0.4170230  0.50037230  0.473356452 0.5312050 0.6047516
    ##           NA's
    ## glm          0
    ## lda          0
    ## rpart        0
    ## knn          0
    ## svmRadial    0

``` r
dotplot(results)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-2.png)<!-- -->

``` r
# The predictions made by the sub-models that are combined using stacking
# should have a low-correlation (for diversity amongst the sub-models, i.e.,
# different sub-models are accurate in different ways). If the predictions for
# the sub-models were highly correlated (> 0.75) then they would be making the
# same or very similar predictions most of the time reducing the benefit of
# combining the predictions.

# correlation between results
modelCor(results)
```

    ##                 glm       lda     rpart       knn svmRadial
    ## glm       1.0000000 0.9827723 0.7868395 0.1169668 0.9355483
    ## lda       0.9827723 1.0000000 0.7953293 0.1590473 0.9280996
    ## rpart     0.7868395 0.7953293 1.0000000 0.1801689 0.7424085
    ## knn       0.1169668 0.1590473 0.1801689 1.0000000 0.2280942
    ## svmRadial 0.9355483 0.9280996 0.7424085 0.2280942 1.0000000

``` r
splom(results)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-3.png)<!-- -->

``` r
## 3.a. Stack using glm ----
stack_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = TRUE,
    classProbs = TRUE)
set.seed(seed)
loans_model_stack_glm <- caretStack(models, method = "glm", metric = "Accuracy",
    trControl = stack_control)
print(loans_model_stack_glm)
```

    ## A glm ensemble of 5 base models: glm, lda, rpart, knn, svmRadial
    ## 
    ## Ensemble results:
    ## Generalized Linear Model 
    ## 
    ## 1842 samples
    ##    5 predictor
    ##    2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 1657, 1658, 1657, 1658, 1658, 1658, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.8127081  0.4919081

``` r
## 3.b. Stack using random forest ----
set.seed(seed)
loans_model_stack_rf <- caretStack(models, method = "rf", metric = "Accuracy", trControl = stack_control)
print(loans_model_stack_rf)
```

    ## A rf ensemble of 5 base models: glm, lda, rpart, knn, svmRadial
    ## 
    ## Ensemble results:
    ## Random Forest 
    ## 
    ## 1842 samples
    ##    5 predictor
    ##    2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 1657, 1658, 1657, 1658, 1658, 1658, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa    
    ##   2     0.8083523  0.4979652
    ##   3     0.8083523  0.4992015
    ##   5     0.8081712  0.5001011
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.

``` r
# 4 Hyperparameter Tuning ----

# Introduction ---- Hyperparameter tuning involves identifying and applying the
# best combination of algorithm parameters. Only the algorithm parameters that
# have a significant effect on the model's performance are available for
# tuning.


# STEP 3. Train the Model ---- The default random forest algorithm exposes the
# 'mtry' parameter to be tuned.

## The 'mtry' parameter ---- Number of variables randomly sampled as candidates
## at each split.

# This can be confirmed from here:
# https://topepo.github.io/caret/available-models.html or by executing the
# following command: names(getModelInfo())

# We start by identifying the accuracy by using the recommended defaults for
# each parameter, i.e., mtry=floor(sqrt(ncol(sonar_independent_variables))) or
# mtry=7

seed <- 7
metric <- "Accuracy"

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(seed)
mtry <- sqrt(ncol(loans))
tunegrid <- expand.grid(.mtry = mtry)
loans_model_default_rf <- train(Status ~ ., data = loans, method = "rf", metric = metric,
    tuneGrid = tunegrid, trControl = train_control)
print(loans_model_default_rf)
```

    ## Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.8018208  0.4712284
    ## 
    ## Tuning parameter 'mtry' was held constant at a value of 3.464102

``` r
# STEP 4. Apply a 'Random Search' to identify the best parameter value ---- A
# random search is good if we are unsure of what the value might be and we want
# to overcome any biases we may have for setting the parameter value (like the
# suggested 'mtry' equation above).

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, search = "random")
set.seed(seed)
mtry <- sqrt(ncol(loans))

loans_model_random_search_rf <- train(Status ~ ., data = loans, method = "rf", metric = metric,
    tuneLength = 12, trControl = train_control)

print(loans_model_random_search_rf)
```

    ## Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa    
    ##    2    0.8045263  0.4679203
    ##    3    0.8039713  0.4774923
    ##    6    0.7795310  0.4346134
    ##    7    0.7795222  0.4345172
    ##    8    0.7708231  0.4153193
    ##   10    0.7697214  0.4125276
    ##   12    0.7654027  0.4044407
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.

``` r
plot(loans_model_random_search_rf)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-4.png)<!-- -->

``` r
# STEP 5. Apply a 'Grid Search' to identify the best parameter value ---- Each
# axis of the grid is an algorithm parameter, and points on the grid are
# specific combinations of parameters.

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, search = "grid")
set.seed(seed)

getModelInfo("RRFglobal")
```

    ## $RRFglobal
    ## $RRFglobal$label
    ## [1] "Regularized Random Forest"
    ## 
    ## $RRFglobal$library
    ## [1] "RRF"
    ## 
    ## $RRFglobal$loop
    ## NULL
    ## 
    ## $RRFglobal$type
    ## [1] "Regression"     "Classification"
    ## 
    ## $RRFglobal$parameters
    ##   parameter   class                         label
    ## 1      mtry numeric #Randomly Selected Predictors
    ## 2   coefReg numeric          Regularization Value
    ## 
    ## $RRFglobal$grid
    ## function (x, y, len = NULL, search = "grid") 
    ## {
    ##     if (search == "grid") {
    ##         out <- expand.grid(mtry = caret::var_seq(p = ncol(x), 
    ##             classification = is.factor(y), len = len), coefReg = seq(0.01, 
    ##             1, length = len))
    ##     }
    ##     else {
    ##         out <- data.frame(mtry = sample(1:ncol(x), size = len, 
    ##             replace = TRUE), coefReg = runif(len, min = 0, max = 1))
    ##     }
    ##     out
    ## }
    ## 
    ## $RRFglobal$fit
    ## function (x, y, wts, param, lev, last, classProbs, ...) 
    ## {
    ##     RRF::RRF(x, y, mtry = param$mtry, coefReg = param$coefReg, 
    ##         ...)
    ## }
    ## 
    ## $RRFglobal$predict
    ## function (modelFit, newdata, submodels = NULL) 
    ## predict(modelFit, newdata)
    ## 
    ## $RRFglobal$prob
    ## function (modelFit, newdata, submodels = NULL) 
    ## predict(modelFit, newdata, type = "prob")
    ## 
    ## $RRFglobal$varImp
    ## function (object, ...) 
    ## {
    ##     varImp <- RRF::importance(object, ...)
    ##     if (object$type == "regression") 
    ##         varImp <- data.frame(Overall = varImp[, "%IncMSE"])
    ##     else {
    ##         retainNames <- levels(object$y)
    ##         if (all(retainNames %in% colnames(varImp))) {
    ##             varImp <- varImp[, retainNames]
    ##         }
    ##         else {
    ##             varImp <- data.frame(Overall = varImp[, 1])
    ##         }
    ##     }
    ##     out <- as.data.frame(varImp, stringsAsFactors = TRUE)
    ##     if (dim(out)[2] == 2) {
    ##         tmp <- apply(out, 1, mean)
    ##         out[, 1] <- out[, 2] <- tmp
    ##     }
    ##     out
    ## }
    ## 
    ## $RRFglobal$levels
    ## function (x) 
    ## x$obsLevels
    ## 
    ## $RRFglobal$tags
    ## [1] "Random Forest"              "Ensemble Model"            
    ## [3] "Bagging"                    "Implicit Feature Selection"
    ## [5] "Regularization"            
    ## 
    ## $RRFglobal$sort
    ## function (x) 
    ## x[order(x$coefReg), ]

``` r
# The Regularized Random Forest algorithm exposes the 'coefReg' parameter in
# addition to the 'mtry' parameter for tuning.  The 'mtry' parameter ----
# Number of variables randomly sampled as candidates at each split.

## The 'coefReg' parameter ---- It stands for coefficient(s) of regularization.
## A smaller coefficient may lead to a smaller feature subset, i.e., there are
## fewer variables with non-zero importance scores. coefReg must be either a
## single value (all variables have the same coefficient) or a numeric vector
## of length equal to the number of predictor variables. default: 0.8

tunegrid <- expand.grid(.mtry = c(1:10), .coefReg = seq(from = 0.1, to = 1, by = 0.1))

loans_model_grid_search_rrf_global <- train(Status ~ ., data = loans, method = "RRFglobal",
    metric = metric, tuneGrid = tunegrid, trControl = train_control)
print(loans_model_grid_search_rrf_global)
```

    ## Regularized Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  coefReg  Accuracy   Kappa    
    ##    1    0.1      0.7490877  0.3779218
    ##    1    0.2      0.7583074  0.3989046
    ##    1    0.3      0.7582633  0.3945359
    ##    1    0.4      0.7565986  0.3986669
    ##    1    0.5      0.7523945  0.3783282
    ##    1    0.6      0.7669539  0.4152272
    ##    1    0.7      0.7686461  0.4139478
    ##    1    0.8      0.7664779  0.4090405
    ##    1    0.9      0.7675444  0.4080530
    ##    1    1.0      0.7697478  0.4156015
    ##    2    0.1      0.7405038  0.3556486
    ##    2    0.2      0.7523672  0.3913850
    ##    2    0.3      0.7572497  0.3988650
    ##    2    0.4      0.7545266  0.3918324
    ##    2    0.5      0.7572318  0.3970357
    ##    2    0.6      0.7587839  0.4052189
    ##    2    0.7      0.7637633  0.4036724
    ##    2    0.8      0.7681085  0.4107795
    ##    2    0.9      0.7659053  0.4058152
    ##    2    1.0      0.7681173  0.4132699
    ##    3    0.1      0.7615864  0.4067717
    ##    3    0.2      0.7544643  0.3947414
    ##    3    0.3      0.7577879  0.3996656
    ##    3    0.4      0.7588274  0.4017437
    ##    3    0.5      0.7507711  0.3840043
    ##    3    0.6      0.7713340  0.4311461
    ##    3    0.7      0.7697390  0.4155437
    ##    3    0.8      0.7626528  0.3983443
    ##    3    0.9      0.7675973  0.4100462
    ##    3    1.0      0.7675532  0.4110335
    ##    4    0.1      0.7572583  0.3962856
    ##    4    0.2      0.7485074  0.3782360
    ##    4    0.3      0.7593736  0.4044182
    ##    4    0.4      0.7475018  0.3732134
    ##    4    0.5      0.7638247  0.4162105
    ##    4    0.6      0.7620802  0.4102128
    ##    4    0.7      0.7675882  0.4120125
    ##    4    0.8      0.7659403  0.4085487
    ##    4    0.9      0.7691840  0.4164565
    ##    4    1.0      0.7653762  0.4036270
    ##    5    0.1      0.7599555  0.4072146
    ##    5    0.2      0.7555319  0.3925749
    ##    5    0.3      0.7571525  0.4023121
    ##    5    0.4      0.7512030  0.3845527
    ##    5    0.5      0.7615340  0.4093256
    ##    5    0.6      0.7642484  0.4144601
    ##    5    0.7      0.7664603  0.4086835
    ##    5    0.8      0.7653850  0.4061506
    ##    5    0.9      0.7680908  0.4127933
    ##    5    1.0      0.7653762  0.4059993
    ##    6    0.1      0.7632436  0.4112904
    ##    6    0.2      0.7604841  0.4091690
    ##    6    0.3      0.7653669  0.4186704
    ##    6    0.4      0.7571795  0.4003302
    ##    6    0.5      0.7560951  0.3992575
    ##    6    0.6      0.7750983  0.4365077
    ##    6    0.7      0.7653762  0.4041517
    ##    6    0.8      0.7680732  0.4123879
    ##    6    0.9      0.7670332  0.4085133
    ##    6    1.0      0.7653850  0.4060358
    ##    7    0.1      0.7523320  0.3913853
    ##    7    0.2      0.7621411  0.4107272
    ##    7    0.3      0.7626437  0.4156168
    ##    7    0.4      0.7669894  0.4211991
    ##    7    0.5      0.7638245  0.4184038
    ##    7    0.6      0.7653853  0.4128226
    ##    7    0.7      0.7670332  0.4107846
    ##    7    0.8      0.7686288  0.4138641
    ##    7    0.9      0.7664956  0.4083607
    ##    7    1.0      0.7680997  0.4125427
    ##    8    0.1      0.7626696  0.4165443
    ##    8    0.2      0.7587481  0.4082678
    ##    8    0.3      0.7626972  0.4149211
    ##    8    0.4      0.7626437  0.4123091
    ##    8    0.5      0.7605100  0.4113312
    ##    8    0.6      0.7577874  0.3992001
    ##    8    0.7      0.7692102  0.4146067
    ##    8    0.8      0.7637545  0.4005511
    ##    8    0.9      0.7653850  0.4044895
    ##    8    1.0      0.7670070  0.4083417
    ##    9    0.1      0.7599203  0.4079152
    ##    9    0.2      0.7604659  0.4085950
    ##    9    0.3      0.7626264  0.4116051
    ##    9    0.4      0.7626960  0.4111481
    ##    9    0.5      0.7638245  0.4164444
    ##    9    0.6      0.7587927  0.4002655
    ##    9    0.7      0.7675620  0.4108690
    ##    9    0.8      0.7675708  0.4092840
    ##    9    0.9      0.7653850  0.4056802
    ##    9    1.0      0.7659227  0.4075146
    ##   10    0.1      0.7577262  0.4071059
    ##   10    0.2      0.7566331  0.3985721
    ##   10    0.3      0.7571616  0.4045030
    ##   10    0.4      0.7577086  0.4059484
    ##   10    0.5      0.7604576  0.4100483
    ##   10    0.6      0.7642916  0.4112054
    ##   10    0.7      0.7643010  0.4043159
    ##   10    0.8      0.7659227  0.4054709
    ##   10    0.9      0.7659665  0.4066739
    ##   10    1.0      0.7680908  0.4149045
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were mtry = 6 and coefReg = 0.6.

``` r
plot(loans_model_grid_search_rrf_global)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-5.png)<!-- -->

``` r
# STEP 6. Apply a 'Manual Search' to identify the best parameter value ----
# Manual Search The 'mtry' parameter ---- Number of variables randomly sampled
# as candidates at each split.

## The 'ntree' parameter ---- Number of trees to grow. It is limited by the
## amount of compute time available.

# We randomly search for a value for the mtry parameter but we manually search
# for a value for the ntree parameter.

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, search = "random")

tunegrid <- expand.grid(.mtry = c(1:5))

modellist <- list()
for (ntree in c(500, 800, 1000)) {
    set.seed(seed)
    loans_model_manual_search_rf <- train(Status ~ ., data = loans, method = "rf",
        metric = metric, tuneGrid = tunegrid, trControl = train_control, ntree = ntree)
    key <- toString(ntree)
    modellist[[key]] <- loans_model_manual_search_rf
}

# Lastly, we compare results to find which parameters gave the highest accuracy
print(modellist)
```

    ## $`500`
    ## Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa      
    ##   1     0.6894885  0.009491513
    ##   2     0.8045263  0.467304813
    ##   3     0.8007279  0.470197930
    ##   4     0.7903718  0.452882949
    ##   5     0.7876660  0.452909505
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`800`
    ## Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa      
    ##   1     0.6889421  0.007122647
    ##   2     0.8056192  0.470373772
    ##   3     0.8023496  0.473479065
    ##   4     0.7925576  0.457014412
    ##   5     0.7876660  0.453165553
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.
    ## 
    ## $`1000`
    ## Random Forest 
    ## 
    ## 614 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 552, 553, 552, 553, 552, 553, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa      
    ##   1     0.6894885  0.009491513
    ##   2     0.8045263  0.466775858
    ##   3     0.8034337  0.476495853
    ##   4     0.7909183  0.454307793
    ##   5     0.7871196  0.451884901
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 2.

``` r
results <- resamples(modellist)
summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: 500, 800, 1000 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##           Min.   1st Qu.    Median      Mean   3rd Qu.     Max. NA's
    ## 500  0.7377049 0.7868852 0.8064516 0.8045263 0.8225806 0.852459    0
    ## 800  0.7377049 0.7868852 0.8064516 0.8056192 0.8225806 0.852459    0
    ## 1000 0.7377049 0.7868852 0.8064516 0.8045263 0.8225806 0.852459    0
    ## 
    ## Kappa 
    ##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## 500  0.2339089 0.4133117 0.4772699 0.4673048 0.5240579 0.6174216    0
    ## 800  0.2339089 0.4133117 0.4772699 0.4703738 0.5240579 0.6174216    0
    ## 1000 0.2339089 0.4133117 0.4772699 0.4667759 0.5240579 0.6047516    0

``` r
dotplot(results)
```

![](Lab8-Submission-ModelPerformanceComparison_files/figure-gfm/Your%20Eighth%20Code%20Chunk-6.png)<!-- -->

``` r
# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.  renv::snapshot() [OPTIONAL]
# **Deinitialization: Create a snapshot of the R environment ---- Lastly, as a
# follow-up to the initialization step, record the packages installed and their
# sources in the lockfile so that other team-members can use renv::restore() to
# re-install the same package version in their local machine during their
# initialization step.  renv::snapshot()
```

## \<Milestone 8 out of 8\>

Issue 8a Consolidation.

``` r
# *****************************************************************************
# 8: Consolidation ----

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall them)
# are recorded into a lockfile, renv.lock, and a .Rprofile ensures that the
# library is used every time you open the project.

# Consider a library as the location where packages are stored.  Execute the
# following command to list all the libraries available in your computer:
.libPaths()
```

    ## [1] "C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/markdown/renv/library/R-4.3/x86_64-w64-mingw32"
    ## [2] "C:/Users/Cris/AppData/Local/R/cache/R/renv/sandbox/R-4.3/x86_64-w64-mingw32/bd3f13aa"

``` r
# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)
```

    ## [[1]]
    ##   [1] "abind"          "adabag"         "Amelia"         "askpass"       
    ##   [5] "backports"      "base64enc"      "BH"             "bit"           
    ##   [9] "bit64"          "brew"           "brio"           "broom"         
    ##  [13] "broom.mixed"    "bslib"          "C50"            "cachem"        
    ##  [17] "callr"          "car"            "carData"        "caret"         
    ##  [21] "caretEnsemble"  "checkmate"      "chron"          "class"         
    ##  [25] "cli"            "clipr"          "clock"          "coda"          
    ##  [29] "codetools"      "collections"    "colorspace"     "commonmark"    
    ##  [33] "ConsRank"       "corrplot"       "covr"           "cpp11"         
    ##  [37] "crayon"         "Cubist"         "curl"           "cyclocomp"     
    ##  [41] "data.table"     "DBI"            "DEoptimR"       "desc"          
    ##  [45] "diagram"        "diffobj"        "digest"         "doParallel"    
    ##  [49] "doRNG"          "dplyr"          "e1071"          "ellipsis"      
    ##  [53] "evaluate"       "fansi"          "farver"         "fastmap"       
    ##  [57] "fontawesome"    "forcats"        "foreach"        "forecast"      
    ##  [61] "foreign"        "formatR"        "Formula"        "fracdiff"      
    ##  [65] "fs"             "furrr"          "future"         "future.apply"  
    ##  [69] "gbm"            "generics"       "ggcorrplot"     "ggformula"     
    ##  [73] "ggplot2"        "ggridges"       "ggtext"         "glmnet"        
    ##  [77] "globals"        "glue"           "gower"          "gridExtra"     
    ##  [81] "gridtext"       "gtable"         "gtools"         "hardhat"       
    ##  [85] "haven"          "here"           "highr"          "Hmisc"         
    ##  [89] "hms"            "htmlTable"      "htmltools"      "htmlwidgets"   
    ##  [93] "httpuv"         "httr"           "hunspell"       "imputeTS"      
    ##  [97] "inline"         "inum"           "ipred"          "isoband"       
    ## [101] "iterators"      "itertools"      "jomo"           "jpeg"          
    ## [105] "jquerylib"      "jsonlite"       "kernlab"        "KernSmooth"    
    ## [109] "knitr"          "labeling"       "labelled"       "laeken"        
    ## [113] "languageserver" "later"          "lattice"        "lava"          
    ## [117] "lazyeval"       "libcoin"        "lifecycle"      "lintr"         
    ## [121] "listenv"        "lme4"           "lmtest"         "loo"           
    ## [125] "lubridate"      "magrittr"       "markdown"       "MASS"          
    ## [129] "Matrix"         "MatrixModels"   "matrixStats"    "memoise"       
    ## [133] "mgcv"           "mice"           "miceadds"       "mime"          
    ## [137] "minqa"          "missForest"     "mitml"          "mitools"       
    ## [141] "mlbench"        "ModelMetrics"   "mosaic"         "mosaicCore"    
    ## [145] "mosaicData"     "munsell"        "mvtnorm"        "naniar"        
    ## [149] "NHANES"         "nlme"           "nloptr"         "nnet"          
    ## [153] "norm"           "numDeriv"       "openssl"        "ordinal"       
    ## [157] "pan"            "parallelly"     "partykit"       "pbapply"       
    ## [161] "pbkrtest"       "pillar"         "pkgbuild"       "pkgconfig"     
    ## [165] "pkgload"        "plumber"        "plyr"           "png"           
    ## [169] "praise"         "prettyunits"    "pROC"           "processx"      
    ## [173] "prodlim"        "progress"       "progressr"      "promises"      
    ## [177] "proxy"          "ps"             "purrr"          "quadprog"      
    ## [181] "quantmod"       "quantreg"       "QuickJSR"       "R.cache"       
    ## [185] "R.methodsS3"    "R.oo"           "R.utils"        "R6"            
    ## [189] "randomForest"   "ranger"         "rappdirs"       "RColorBrewer"  
    ## [193] "Rcpp"           "RcppArmadillo"  "RcppEigen"      "RcppParallel"  
    ## [197] "readr"          "recipes"        "rematch2"       "remotes"       
    ## [201] "renv"           "reshape2"       "rex"            "rgl"           
    ## [205] "rlang"          "rlist"          "rmarkdown"      "rngtools"      
    ## [209] "robustbase"     "roxygen2"       "rpart"          "rpart.plot"    
    ## [213] "rprojroot"      "RRF"            "rstan"          "rstudioapi"    
    ## [217] "sass"           "scales"         "shape"          "simputation"   
    ## [221] "sodium"         "sp"             "SparseM"        "spelling"      
    ## [225] "SQUAREM"        "StanHeaders"    "stinepack"      "stringi"       
    ## [229] "stringr"        "styler"         "survival"       "swagger"       
    ## [233] "sys"            "testthat"       "tibble"         "tidyr"         
    ## [237] "tidyselect"     "timechange"     "timeDate"       "tinytex"       
    ## [241] "tseries"        "TTR"            "tzdb"           "ucminf"        
    ## [245] "UpSetR"         "urca"           "utf8"           "vcd"           
    ## [249] "vctrs"          "vdiffr"         "VIM"            "viridis"       
    ## [253] "viridisLite"    "visdat"         "vroom"          "wakefield"     
    ## [257] "waldo"          "webutils"       "withr"          "xfun"          
    ## [261] "XML"            "xml2"           "xmlparsedata"   "xts"           
    ## [265] "yaml"           "zoo"           
    ## 
    ## [[2]]
    ##  [1] "base"       "boot"       "class"      "cluster"    "codetools" 
    ##  [6] "compiler"   "datasets"   "foreign"    "graphics"   "grDevices" 
    ## [11] "grid"       "KernSmooth" "lattice"    "MASS"       "Matrix"    
    ## [16] "methods"    "mgcv"       "nlme"       "nnet"       "parallel"  
    ## [21] "rpart"      "spatial"    "splines"    "stats"      "stats4"    
    ## [26] "survival"   "tcltk"      "tools"      "utils"

``` r
# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
    require("languageserver")
} else {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# Introduction ---- What do you do after you have designed a model that is
# accurate enough to use?  This is a critical question whose answer enables the
# gap between research and practice to be addressed.

# It is possible to discover the key internal representation of a model found
# by an algorithm (e.g., the coefficients in a linear model) and use them in a
# new implementation of the prediction algorithm in another program developed
# using a programming language other than R.

# This is easier to do for simpler algorithms that use a simple representation,
# e.g., a linear model, than for algorithms that use more complex
# representations.

# 'caret' provides access to 'the best' model from a training run in the
# 'finalModel' variable.  The 'predict()' function in the 'caret' package
# automatically uses the 'finalModel' to make predictions on a new dataset. The
# data provided as the 'new dataset' can be stored in a separate file and
# loaded as a data frame.

# STEP 1. Install and Load the Required Packages ---- caret ----
if (require("caret")) {
    require("caret")
} else {
    install.packages("caret", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## mlbench ----
if (require("mlbench")) {
    require("mlbench")
} else {
    install.packages("mlbench", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## plumber ----
if (require("plumber")) {
    require("plumber")
} else {
    install.packages("plumber", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: plumber

``` r
# STEP 2. Load the Dataset ----

library(readr)
loans_imputed <- read_csv("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/data/loans_imputed.csv")
```

    ## Rows: 614 Columns: 12

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): Gender, Married, Dependents, Education, SelfEmployed, PropertyArea,...
    ## dbl (5): ApplicantIncome, CoapplicantIncome, LoanAmount, LoanAmountTerm, Cre...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(loans_imputed)
# STEP 3. Train the Model ---- create an 80%/20% data split for training and
# testing datasets respectively
set.seed(9)
train_index <- createDataPartition(loans_imputed$Status, p = 0.8, list = FALSE)
loans_imputed_training <- loans_imputed[train_index, ]
loans_imputed_testing <- loans_imputed[-train_index, ]

set.seed(9)
train_control <- trainControl(method = "cv", number = 10)
loans_imputed_model_lda <- train(Status ~ ., data = loans_imputed_training, method = "lda",
    metric = "Accuracy", trControl = train_control)

# We print a summary of what caret has done
print(loans_imputed_model_lda)
```

    ## Linear Discriminant Analysis 
    ## 
    ## 492 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold) 
    ## Summary of sample sizes: 443, 443, 442, 442, 444, 442, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.8128214  0.4867037

``` r
# We then print the details of the model that has been created
print(loans_imputed_model_lda$finalModel)
```

    ## Call:
    ## lda(x, grouping = y)
    ## 
    ## Prior probabilities of groups:
    ##         N         Y 
    ## 0.3130081 0.6869919 
    ## 
    ## Group means:
    ##   GenderMale MarriedYes Dependents1 Dependents2 Dependents3+
    ## N  0.8181818  0.5974026   0.2012987   0.1298701    0.1103896
    ## Y  0.8343195  0.6982249   0.1656805   0.1893491    0.0887574
    ##   EducationNot Graduate SelfEmployedYes ApplicantIncome CoapplicantIncome
    ## N             0.2922078       0.1363636        5503.662          1936.734
    ## Y             0.1656805       0.1390533        5400.500          1488.355
    ##   LoanAmount LoanAmountTerm CreditHistory PropertyAreaSemiurban
    ## N   5394.370       340.7532     0.5844156             0.2792208
    ## Y   5390.893       340.4734     0.9852071             0.4230769
    ##   PropertyAreaUrban
    ## N         0.3441558
    ## Y         0.3224852
    ## 
    ## Coefficients of linear discriminants:
    ##                                 LD1
    ## GenderMale            -3.826180e-02
    ## MarriedYes             5.288644e-01
    ## Dependents1           -3.245753e-01
    ## Dependents2            1.695665e-01
    ## Dependents3+           4.753936e-02
    ## EducationNot Graduate -5.096103e-01
    ## SelfEmployedYes       -5.474336e-03
    ## ApplicantIncome       -2.229830e-04
    ## CoapplicantIncome     -5.319287e-05
    ## LoanAmount             2.222240e-04
    ## LoanAmountTerm        -8.777288e-04
    ## CreditHistory          3.208886e+00
    ## PropertyAreaSemiurban  7.473690e-01
    ## PropertyAreaUrban      3.365292e-01

``` r
# STEP 4. Test the Model ---- We can test the model
set.seed(9)

# Define the levels you expect in the Status variable
expected_levels <- c("Y", "N")

# Convert the Status variable to a factor with the defined levels
loans_imputed_testing[, 1:12]$Status <- factor(loans_imputed_testing[, 1:12]$Status,
    levels = expected_levels)

predictions <- predict(loans_imputed_model_lda, newdata = loans_imputed_testing)
confusionMatrix(predictions, loans_imputed_testing$Status)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  Y  N
    ##          Y 82 20
    ##          N  2 18
    ##                                           
    ##                Accuracy : 0.8197          
    ##                  95% CI : (0.7398, 0.8834)
    ##     No Information Rate : 0.6885          
    ##     P-Value [Acc > NIR] : 0.0007750       
    ##                                           
    ##                   Kappa : 0.5169          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.0002896       
    ##                                           
    ##             Sensitivity : 0.9762          
    ##             Specificity : 0.4737          
    ##          Pos Pred Value : 0.8039          
    ##          Neg Pred Value : 0.9000          
    ##              Prevalence : 0.6885          
    ##          Detection Rate : 0.6721          
    ##    Detection Prevalence : 0.8361          
    ##       Balanced Accuracy : 0.7249          
    ##                                           
    ##        'Positive' Class : Y               
    ## 

``` r
print(loans_imputed_testing)
```

    ## # A tibble: 122 × 12
    ##    Gender Married Dependents Education    SelfEmployed ApplicantIncome
    ##    <chr>  <chr>   <chr>      <chr>        <chr>                  <dbl>
    ##  1 Male   No      0          Graduate     No                      6000
    ##  2 Male   Yes     0          Not Graduate No                      2333
    ##  3 Female No      0          Graduate     No                      3510
    ##  4 Male   Yes     0          Not Graduate No                      7660
    ##  5 Male   Yes     1          Graduate     Yes                     3717
    ##  6 Male   No      0          Not Graduate No                      1442
    ##  7 Male   No      0          Graduate     No                      3167
    ##  8 Male   No      0          Graduate     No                      1800
    ##  9 Male   Yes     0          Graduate     No                      5821
    ## 10 Male   Yes     0          Graduate     No                      3366
    ## # ℹ 112 more rows
    ## # ℹ 6 more variables: CoapplicantIncome <dbl>, LoanAmount <dbl>,
    ## #   LoanAmountTerm <dbl>, CreditHistory <dbl>, PropertyArea <chr>, Status <fct>

``` r
print(predictions)
```

    ##   [1] Y Y N N Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y N N Y Y Y Y Y Y Y Y Y Y
    ##  [38] N Y Y Y Y Y Y Y Y N N Y Y Y Y Y Y N Y Y N Y N Y Y Y Y N Y Y N Y Y N Y Y Y
    ##  [75] Y Y N Y Y Y N Y Y Y Y Y Y N Y N Y Y Y Y Y Y Y N Y Y Y Y Y Y Y Y Y N N Y Y
    ## [112] Y Y Y Y Y Y Y Y Y Y Y
    ## Levels: N Y

``` r
# STEP 5. Save and Load your Model ---- Saving a model into a file allows you
# to load it later and use it to make predictions. Saved models can be loaded
# by calling the `readRDS()` function

saveRDS(loans_imputed_model_lda, "C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/models/saved_loans_model_lda.rds")
# The saved model can then be loaded later as follows:
loaded_loans_imputed_model_lda <- readRDS("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/models/saved_loans_model_lda.rds")
print(loaded_loans_imputed_model_lda)
```

    ## Linear Discriminant Analysis 
    ## 
    ## 492 samples
    ##  11 predictor
    ##   2 classes: 'N', 'Y' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (10 fold) 
    ## Summary of sample sizes: 443, 443, 442, 442, 444, 442, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.8128214  0.4867037

``` r
predictions_with_loaded_model <- predict(loaded_loans_imputed_model_lda, newdata = loans_imputed_testing)
confusionMatrix(predictions_with_loaded_model, loans_imputed_testing$Status)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  Y  N
    ##          Y 82 20
    ##          N  2 18
    ##                                           
    ##                Accuracy : 0.8197          
    ##                  95% CI : (0.7398, 0.8834)
    ##     No Information Rate : 0.6885          
    ##     P-Value [Acc > NIR] : 0.0007750       
    ##                                           
    ##                   Kappa : 0.5169          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.0002896       
    ##                                           
    ##             Sensitivity : 0.9762          
    ##             Specificity : 0.4737          
    ##          Pos Pred Value : 0.8039          
    ##          Neg Pred Value : 0.9000          
    ##              Prevalence : 0.6885          
    ##          Detection Rate : 0.6721          
    ##    Detection Prevalence : 0.8361          
    ##       Balanced Accuracy : 0.7249          
    ##                                           
    ##        'Positive' Class : Y               
    ## 

``` r
# STEP 6. Creating Functions in R ----

# Plumber requires functions, an example of the syntax for creating a function
# in R is:

name_of_function <- function(arg) {
    # Do something with the argument called `arg`
}

# STEP 7. Make Predictions on New Data using the Saved Model ---- We can also
# create and use our own data frame as follows:
to_be_predicted <- # Create a data frame with appropriate values and types to_be_predicted
to_be_predicted <- # Create a data frame with appropriate values and types <- #
to_be_predicted <- # Create a data frame with appropriate values and types Create
to_be_predicted <- # Create a data frame with appropriate values and types a
to_be_predicted <- # Create a data frame with appropriate values and types data
to_be_predicted <- # Create a data frame with appropriate values and types frame
to_be_predicted <- # Create a data frame with appropriate values and types with
to_be_predicted <- # Create a data frame with appropriate values and types appropriate
to_be_predicted <- # Create a data frame with appropriate values and types values
to_be_predicted <- # Create a data frame with appropriate values and types and
to_be_predicted <- # Create a data frame with appropriate values and types types
to_be_predicted <- data.frame(Gender = "Male", Married = "No", Dependents = "0",
    Education = "Graduate", SelfEmployed = "Yes", ApplicantIncome = 4583, CoapplicantIncome = 1508,
    LoanAmount = 12841, LoanAmountTerm = 360, CreditHistory = 1, PropertyArea = "Urban")

# Use factor() to set factor levels if needed
to_be_predicted$Gender <- factor(to_be_predicted$Gender, levels = levels(loaded_loans_imputed_model_lda$Gender))
to_be_predicted$Married <- factor(to_be_predicted$Married, levels = levels(loaded_loans_imputed_model_lda$Married))
to_be_predicted$Education <- factor(to_be_predicted$Education, levels = levels(loaded_loans_imputed_model_lda$Education))
to_be_predicted$SelfEmployed <- factor(to_be_predicted$SelfEmployed, levels = levels(loaded_loans_imputed_model_lda$SelfEmployed))
to_be_predicted$PropertyArea <- factor(to_be_predicted$PropertyArea, levels = levels(loaded_loans_imputed_model_lda$PropertyArea))
# to_be_predicted$Dependents <- factor(to_be_predicted$Dependents, levels =
# levels(loaded_loans_imputed_model_lda$Dependents))

# Make predictions
predictions <- predict(loaded_loans_imputed_model_lda, newdata = to_be_predicted)
print(predictions)
```

    ## factor()
    ## Levels: N Y

``` r
# We then use the data frame to make predictions
predict(loaded_loans_imputed_model_lda, newdata = to_be_predicted)
```

    ## factor()
    ## Levels: N Y

``` r
# STEP 8. Make predictions using the model through a function ---- An
# alternative is to create a function and then use the function to make
# predictions

predict_status <- function(arg_Gender, arg_Married, arg_Dependents, arg_Education,
    arg_SelfEmployed, arg_ApplicantIncome, arg_CoapplicantIncome, arg_LoanAmount,
    arg_LoanAmountTerm, arg_CreditHistory, arg_PropertyArea) {
    # Create a data frame using the arguments
    to_be_predicted <- data.frame(Gender = arg_Gender, Married = arg_Married, Dependents = arg_Dependents,
        Education = arg_Education, SelfEmployed = arg_SelfEmployed, ApplicantIncome = arg_ApplicantIncome,
        CoapplicantIncome = arg_CoapplicantIncome, LoanAmount = arg_LoanAmount, LoanAmountTerm = arg_LoanAmountTerm,
        CreditHistory = arg_CreditHistory, PropertyArea = arg_PropertyArea)

    # Make a prediction based on the data frame
    predict(loaded_loans_imputed_model_lda, to_be_predicted)
}


# We can now call the function predict_diabetes() instead of calling the
# predict() function directly

# Assuming Dependents should be a factor

predict_status("Male", "No", "0", "Graduate", "Yes", 4583, 1508, 12841, 360, 1, "Urban")
```

    ## [1] Y
    ## Levels: N Y

``` r
# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.  renv::snapshot()
```

## \<Milestone 8 out of 8\>

Issue 8b Consolidation.

``` r
# 8b. API ----

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall them)
# are recorded into a lockfile, renv.lock, and a .Rprofile ensures that the
# library is used every time you open the project.

# Consider a library as the location where packages are stored.  Execute the
# following command to list all the libraries available in your computer:
.libPaths()
```

    ## [1] "C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/markdown/renv/library/R-4.3/x86_64-w64-mingw32"
    ## [2] "C:/Users/Cris/AppData/Local/R/cache/R/renv/sandbox/R-4.3/x86_64-w64-mingw32/bd3f13aa"

``` r
# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)
```

    ## [[1]]
    ##   [1] "abind"          "adabag"         "Amelia"         "askpass"       
    ##   [5] "backports"      "base64enc"      "BH"             "bit"           
    ##   [9] "bit64"          "brew"           "brio"           "broom"         
    ##  [13] "broom.mixed"    "bslib"          "C50"            "cachem"        
    ##  [17] "callr"          "car"            "carData"        "caret"         
    ##  [21] "caretEnsemble"  "checkmate"      "chron"          "class"         
    ##  [25] "cli"            "clipr"          "clock"          "coda"          
    ##  [29] "codetools"      "collections"    "colorspace"     "commonmark"    
    ##  [33] "ConsRank"       "corrplot"       "covr"           "cpp11"         
    ##  [37] "crayon"         "Cubist"         "curl"           "cyclocomp"     
    ##  [41] "data.table"     "DBI"            "DEoptimR"       "desc"          
    ##  [45] "diagram"        "diffobj"        "digest"         "doParallel"    
    ##  [49] "doRNG"          "dplyr"          "e1071"          "ellipsis"      
    ##  [53] "evaluate"       "fansi"          "farver"         "fastmap"       
    ##  [57] "fontawesome"    "forcats"        "foreach"        "forecast"      
    ##  [61] "foreign"        "formatR"        "Formula"        "fracdiff"      
    ##  [65] "fs"             "furrr"          "future"         "future.apply"  
    ##  [69] "gbm"            "generics"       "ggcorrplot"     "ggformula"     
    ##  [73] "ggplot2"        "ggridges"       "ggtext"         "glmnet"        
    ##  [77] "globals"        "glue"           "gower"          "gridExtra"     
    ##  [81] "gridtext"       "gtable"         "gtools"         "hardhat"       
    ##  [85] "haven"          "here"           "highr"          "Hmisc"         
    ##  [89] "hms"            "htmlTable"      "htmltools"      "htmlwidgets"   
    ##  [93] "httpuv"         "httr"           "hunspell"       "imputeTS"      
    ##  [97] "inline"         "inum"           "ipred"          "isoband"       
    ## [101] "iterators"      "itertools"      "jomo"           "jpeg"          
    ## [105] "jquerylib"      "jsonlite"       "kernlab"        "KernSmooth"    
    ## [109] "knitr"          "labeling"       "labelled"       "laeken"        
    ## [113] "languageserver" "later"          "lattice"        "lava"          
    ## [117] "lazyeval"       "libcoin"        "lifecycle"      "lintr"         
    ## [121] "listenv"        "lme4"           "lmtest"         "loo"           
    ## [125] "lubridate"      "magrittr"       "markdown"       "MASS"          
    ## [129] "Matrix"         "MatrixModels"   "matrixStats"    "memoise"       
    ## [133] "mgcv"           "mice"           "miceadds"       "mime"          
    ## [137] "minqa"          "missForest"     "mitml"          "mitools"       
    ## [141] "mlbench"        "ModelMetrics"   "mosaic"         "mosaicCore"    
    ## [145] "mosaicData"     "munsell"        "mvtnorm"        "naniar"        
    ## [149] "NHANES"         "nlme"           "nloptr"         "nnet"          
    ## [153] "norm"           "numDeriv"       "openssl"        "ordinal"       
    ## [157] "pan"            "parallelly"     "partykit"       "pbapply"       
    ## [161] "pbkrtest"       "pillar"         "pkgbuild"       "pkgconfig"     
    ## [165] "pkgload"        "plumber"        "plyr"           "png"           
    ## [169] "praise"         "prettyunits"    "pROC"           "processx"      
    ## [173] "prodlim"        "progress"       "progressr"      "promises"      
    ## [177] "proxy"          "ps"             "purrr"          "quadprog"      
    ## [181] "quantmod"       "quantreg"       "QuickJSR"       "R.cache"       
    ## [185] "R.methodsS3"    "R.oo"           "R.utils"        "R6"            
    ## [189] "randomForest"   "ranger"         "rappdirs"       "RColorBrewer"  
    ## [193] "Rcpp"           "RcppArmadillo"  "RcppEigen"      "RcppParallel"  
    ## [197] "readr"          "recipes"        "rematch2"       "remotes"       
    ## [201] "renv"           "reshape2"       "rex"            "rgl"           
    ## [205] "rlang"          "rlist"          "rmarkdown"      "rngtools"      
    ## [209] "robustbase"     "roxygen2"       "rpart"          "rpart.plot"    
    ## [213] "rprojroot"      "RRF"            "rstan"          "rstudioapi"    
    ## [217] "sass"           "scales"         "shape"          "simputation"   
    ## [221] "sodium"         "sp"             "SparseM"        "spelling"      
    ## [225] "SQUAREM"        "StanHeaders"    "stinepack"      "stringi"       
    ## [229] "stringr"        "styler"         "survival"       "swagger"       
    ## [233] "sys"            "testthat"       "tibble"         "tidyr"         
    ## [237] "tidyselect"     "timechange"     "timeDate"       "tinytex"       
    ## [241] "tseries"        "TTR"            "tzdb"           "ucminf"        
    ## [245] "UpSetR"         "urca"           "utf8"           "vcd"           
    ## [249] "vctrs"          "vdiffr"         "VIM"            "viridis"       
    ## [253] "viridisLite"    "visdat"         "vroom"          "wakefield"     
    ## [257] "waldo"          "webutils"       "withr"          "xfun"          
    ## [261] "XML"            "xml2"           "xmlparsedata"   "xts"           
    ## [265] "yaml"           "zoo"           
    ## 
    ## [[2]]
    ##  [1] "base"       "boot"       "class"      "cluster"    "codetools" 
    ##  [6] "compiler"   "datasets"   "foreign"    "graphics"   "grDevices" 
    ## [11] "grid"       "KernSmooth" "lattice"    "MASS"       "Matrix"    
    ## [16] "methods"    "mgcv"       "nlme"       "nnet"       "parallel"  
    ## [21] "rpart"      "spatial"    "splines"    "stats"      "stats4"    
    ## [26] "survival"   "tcltk"      "tools"      "utils"

``` r
# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
    require("languageserver")
} else {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# Introduction ----

# We can create an API to access the model from outside R using a package
# called Plumber.

# STEP 1. Install and Load the Required Packages ---- plumber ----
if (require("plumber")) {
    require("plumber")
} else {
    install.packages("plumber", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
    require("caret")
} else {
    install.packages("caret", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# Create a REST API using Plumber ---- REST API stands for Representational
# State Transfer Application Programming Interface. It is an architectural
# style and a set of guidelines for building web services that provide
# interoperability between different systems on the internet. RESTful APIs are
# widely used for creating and consuming web services.

## Principles of REST API ----

### 1. Stateless ---- The server does not store any client state between
### requests. Each request from the client contains all the necessary
### information for the server to understand and process the request.

### 2. Client-Server Architecture ---- The client and server are separate
### entities that communicate over the Internet. The client sends requests to
### the server, and the server processes those requests and sends back
### responses.

### 3. Uniform Interface ---- REST APIs use a uniform and consistent set of
### interfaces and protocols. The most common interfaces are based on the HTTP
### protocol, such as GET (retrieve a resource), POST (create a new resource),
### PUT (update a resource), DELETE (remove a resource), etc.

### 4. Resource-Oriented ---- REST APIs are based on the concept of resources,
### which are identified by unique URIs (Uniform Resource Identifiers). Clients
### interact with these resources by sending requests to their corresponding
### URIs.

### 5. Representation of Resources ---- Resources in a REST API can be
### represented in various formats, such as JSON (JavaScript Object Notation),
### XML (eXtensible Markup Language), YAML (YAML Ain't Markup Language) or
### plain text. The server sends the representation of a resource in the
### response to the client.


# REST APIs are widely used for building web services that can be consumed by
# various client applications, such as web browsers, mobile apps, or other
# servers. They provide a scalable and flexible approach to designing APIs that
# can evolve over time. Developers can use RESTful principles to create APIs
# that are easy to understand, use, and integrate into different systems.

# When working with a REST API, clients typically send HTTP requests to
# specific endpoints (URLs) provided by the server, and the server responds
# with the requested data or performs the requested actions. The communication
# between client and server is based on the HTTP protocol, making REST APIs
# widely supported and accessible across different platforms and programming
# languages.

# In summary, a REST API is a set of rules and conventions for building web
# services that follow the principles of REST. It provides a standardized and
# scalable way for systems to communicate and exchange data over the internet.

# This requires the 'plumber' package that was installed and loaded earlier in
# STEP 1. The commenting below makes R recognize the code as the definition of
# an API, i.e., #* comments.

loaded_loans_imputed_model_lda <- readRDS("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/models/saved_loans_model_lda.rds")

# * @apiTitle Loan Approval Status Prediction Model API

# * @apiDescription Used to predict whether a client will be given a loan or
# not.

# * @param arg_Gender The clients Gender(Male or Female) * @param arg_Married
# The clients Marital status(Yes or No) * @param arg_Dependents The number of
# Dependents the client has(0,1,2 or 3+) * @param arg_Education The clients
# education status(Graduate or NotGraduate) * @param arg_SelfEmployed The
# clients employment status(Yes or No) * @param arg_ApplicantIncome The
# Applicants monthly income * @param arg_CoapplicantIncome The Coapplicants
# monthly income if applicable * @param arg_LoanAmount The Loan amount(in Ksh)
# * @param arg_LoanAmountTerm The Loan term (in days) * @param
# arg_CreditHistory The clients credit history (0 being less than 350, 1 being
# more thatn 500) * @param arg_PropertyArea The clients property area (Urban,
# SemiUrban, Rural)

# * @get /Status

predict_status <- function(arg_Gender, arg_Married, arg_Dependents, arg_Education,
    arg_SelfEmployed, arg_ApplicantIncome, arg_CoapplicantIncome, arg_LoanAmount,
    arg_LoanAmountTerm, arg_CreditHistory, arg_PropertyArea) {
    # Create a data frame using the arguments
    to_be_predicted <- data.frame(Gender = as.factor(arg_Gender), Married = as.factor(arg_Married),
        Dependents = as.factor(arg_Dependents), Education = as.factor(arg_Education),
        SelfEmployed = as.factor(arg_SelfEmployed), ApplicantIncome = as.numeric(arg_ApplicantIncome),
        CoapplicantIncome = as.numeric(arg_CoapplicantIncome), LoanAmount = as.numeric(arg_LoanAmount),
        LoanAmountTerm = as.numeric(arg_LoanAmountTerm), CreditHistory = as.numeric(arg_CreditHistory),
        PropertyArea = as.factor(arg_PropertyArea))
    # Make a prediction based on the data frame
    predict(loaded_loans_imputed_model_lda, to_be_predicted)
}

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.  renv::snapshot()
```

## \<Milestone 8 out of 8\>

Issue 8c Consolidation.

``` r
# *****************************************************************************
# Lab 11: Plumber API ----

# **[OPTIONAL] Initialization: Install and use renv ---- The R Environment
# ('renv') package helps you create reproducible environments for your R
# projects. This is helpful when working in teams because it makes your R
# projects more isolated, portable and reproducible.


# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below: This
# project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.  2: Discard the lockfile and
# re-initialize the project.  3: Activate the project without snapshotting or
# installing any packages.  4: Abort project initialization.

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall them)
# are recorded into a lockfile, renv.lock, and a .Rprofile ensures that the
# library is used every time you open the project.

# Consider a library as the location where packages are stored.  Execute the
# following command to list all the libraries available in your computer:
.libPaths()
```

    ## [1] "C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/markdown/renv/library/R-4.3/x86_64-w64-mingw32"
    ## [2] "C:/Users/Cris/AppData/Local/R/cache/R/renv/sandbox/R-4.3/x86_64-w64-mingw32/bd3f13aa"

``` r
# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)
```

    ## [[1]]
    ##   [1] "abind"          "adabag"         "Amelia"         "askpass"       
    ##   [5] "backports"      "base64enc"      "BH"             "bit"           
    ##   [9] "bit64"          "brew"           "brio"           "broom"         
    ##  [13] "broom.mixed"    "bslib"          "C50"            "cachem"        
    ##  [17] "callr"          "car"            "carData"        "caret"         
    ##  [21] "caretEnsemble"  "checkmate"      "chron"          "class"         
    ##  [25] "cli"            "clipr"          "clock"          "coda"          
    ##  [29] "codetools"      "collections"    "colorspace"     "commonmark"    
    ##  [33] "ConsRank"       "corrplot"       "covr"           "cpp11"         
    ##  [37] "crayon"         "Cubist"         "curl"           "cyclocomp"     
    ##  [41] "data.table"     "DBI"            "DEoptimR"       "desc"          
    ##  [45] "diagram"        "diffobj"        "digest"         "doParallel"    
    ##  [49] "doRNG"          "dplyr"          "e1071"          "ellipsis"      
    ##  [53] "evaluate"       "fansi"          "farver"         "fastmap"       
    ##  [57] "fontawesome"    "forcats"        "foreach"        "forecast"      
    ##  [61] "foreign"        "formatR"        "Formula"        "fracdiff"      
    ##  [65] "fs"             "furrr"          "future"         "future.apply"  
    ##  [69] "gbm"            "generics"       "ggcorrplot"     "ggformula"     
    ##  [73] "ggplot2"        "ggridges"       "ggtext"         "glmnet"        
    ##  [77] "globals"        "glue"           "gower"          "gridExtra"     
    ##  [81] "gridtext"       "gtable"         "gtools"         "hardhat"       
    ##  [85] "haven"          "here"           "highr"          "Hmisc"         
    ##  [89] "hms"            "htmlTable"      "htmltools"      "htmlwidgets"   
    ##  [93] "httpuv"         "httr"           "hunspell"       "imputeTS"      
    ##  [97] "inline"         "inum"           "ipred"          "isoband"       
    ## [101] "iterators"      "itertools"      "jomo"           "jpeg"          
    ## [105] "jquerylib"      "jsonlite"       "kernlab"        "KernSmooth"    
    ## [109] "knitr"          "labeling"       "labelled"       "laeken"        
    ## [113] "languageserver" "later"          "lattice"        "lava"          
    ## [117] "lazyeval"       "libcoin"        "lifecycle"      "lintr"         
    ## [121] "listenv"        "lme4"           "lmtest"         "loo"           
    ## [125] "lubridate"      "magrittr"       "markdown"       "MASS"          
    ## [129] "Matrix"         "MatrixModels"   "matrixStats"    "memoise"       
    ## [133] "mgcv"           "mice"           "miceadds"       "mime"          
    ## [137] "minqa"          "missForest"     "mitml"          "mitools"       
    ## [141] "mlbench"        "ModelMetrics"   "mosaic"         "mosaicCore"    
    ## [145] "mosaicData"     "munsell"        "mvtnorm"        "naniar"        
    ## [149] "NHANES"         "nlme"           "nloptr"         "nnet"          
    ## [153] "norm"           "numDeriv"       "openssl"        "ordinal"       
    ## [157] "pan"            "parallelly"     "partykit"       "pbapply"       
    ## [161] "pbkrtest"       "pillar"         "pkgbuild"       "pkgconfig"     
    ## [165] "pkgload"        "plumber"        "plyr"           "png"           
    ## [169] "praise"         "prettyunits"    "pROC"           "processx"      
    ## [173] "prodlim"        "progress"       "progressr"      "promises"      
    ## [177] "proxy"          "ps"             "purrr"          "quadprog"      
    ## [181] "quantmod"       "quantreg"       "QuickJSR"       "R.cache"       
    ## [185] "R.methodsS3"    "R.oo"           "R.utils"        "R6"            
    ## [189] "randomForest"   "ranger"         "rappdirs"       "RColorBrewer"  
    ## [193] "Rcpp"           "RcppArmadillo"  "RcppEigen"      "RcppParallel"  
    ## [197] "readr"          "recipes"        "rematch2"       "remotes"       
    ## [201] "renv"           "reshape2"       "rex"            "rgl"           
    ## [205] "rlang"          "rlist"          "rmarkdown"      "rngtools"      
    ## [209] "robustbase"     "roxygen2"       "rpart"          "rpart.plot"    
    ## [213] "rprojroot"      "RRF"            "rstan"          "rstudioapi"    
    ## [217] "sass"           "scales"         "shape"          "simputation"   
    ## [221] "sodium"         "sp"             "SparseM"        "spelling"      
    ## [225] "SQUAREM"        "StanHeaders"    "stinepack"      "stringi"       
    ## [229] "stringr"        "styler"         "survival"       "swagger"       
    ## [233] "sys"            "testthat"       "tibble"         "tidyr"         
    ## [237] "tidyselect"     "timechange"     "timeDate"       "tinytex"       
    ## [241] "tseries"        "TTR"            "tzdb"           "ucminf"        
    ## [245] "UpSetR"         "urca"           "utf8"           "vcd"           
    ## [249] "vctrs"          "vdiffr"         "VIM"            "viridis"       
    ## [253] "viridisLite"    "visdat"         "vroom"          "wakefield"     
    ## [257] "waldo"          "webutils"       "withr"          "xfun"          
    ## [261] "XML"            "xml2"           "xmlparsedata"   "xts"           
    ## [265] "yaml"           "zoo"           
    ## 
    ## [[2]]
    ##  [1] "base"       "boot"       "class"      "cluster"    "codetools" 
    ##  [6] "compiler"   "datasets"   "foreign"    "graphics"   "grDevices" 
    ## [11] "grid"       "KernSmooth" "lattice"    "MASS"       "Matrix"    
    ## [16] "methods"    "mgcv"       "nlme"       "nnet"       "parallel"  
    ## [21] "rpart"      "spatial"    "splines"    "stats"      "stats4"    
    ## [26] "survival"   "tcltk"      "tools"      "utils"

``` r
# This can also be configured using the RStudio GUI when you click the project
# file, e.g., 'BBT4206-R.Rproj' in the case of this project. Then navigate to
# the 'Environments' tab and select 'Use renv with this project'.

# As you continue to work on your project, you can install and upgrade
# packages, using either: install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their sources in the
# lockfile.

# Later, if you need to share your code with someone else or run your code on a
# new machine, your collaborator (or you) can call renv::restore() to reinstall
# the specific package versions recorded in the lockfile.

# [OPTIONAL] Execute the following code to reinstall the specific package
# versions recorded in the lockfile (restart R after executing the command):
# renv::restore()

# [OPTIONAL] If you get several errors setting up renv and you prefer not to
# use it, then you can deactivate it using the following command (restart R
# after executing the command): renv::deactivate()

# If renv::restore() did not install the 'languageserver' package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
    require("languageserver")
} else {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# STEP 1. Install and load the required packages ---- plumber ----
if (require("plumber")) {
    require("plumber")
} else {
    install.packages("plumber", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

# STEP 2. Process a Plumber API ---- This allows us to process a plumber API
api <- plumber::plumb("C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/8- Consolidation-b.R")

# STEP 3. Run the API on a specific port ---- Specify a constant localhost port
# to use api$run(host = '127.0.0.2', port = 5026)

# STEP 4. Test the API ---- We test the API using the following values: for the
# arguments: pregnant, glucose, pressure, triceps, insulin, mass, pedigree, age
# 6, 148, 72, 35, 0, 33.6, 0.627, and 50 respectively should be 'positive' 1,
# 85, 66, 29, 0, 26.6, 0.351, and 31 respectively should be 'negative'

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.  renv::snapshot()
```

## \<Milestone 8 out of 8\>

Issue 8d Consume Plumber API. {r Your Twelveth Code Chunk} \#<?php
# 8c.Consume data from the Plumber API Output (using PHP) ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
# the practice. It has required lab work submissions that are graded for
# coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

// Full documentation of the client URL (cURL) library: https://www.php.net/manual/en/book.curl.php

$apiUrl = 'http://127.0.0.2:5026/Status';
$curl = curl_init();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if the form data is set
    if (
        isset($_POST['Gender']) && isset($_POST['Married']) && isset($_POST['Dependents']) &&
        isset($_POST['Education']) && isset($_POST['SelfEmployed']) && isset($_POST['ApplicantIncome']) &&
        isset($_POST['CoapplicantIncome']) && isset($_POST['LoanAmount']) && isset($_POST['LoanAmountTerm']) &&
        isset($_POST['CreditHistory']) && isset($_POST['PropertyArea'])
    ) {
        // Check if the form values are numeric
        if (
            is_numeric($_POST['Dependents']) && is_numeric($_POST['ApplicantIncome']) &&
            is_numeric($_POST['CoapplicantIncome']) && is_numeric($_POST['LoanAmount']) &&
            is_numeric($_POST['LoanAmountTerm']) && is_numeric($_POST['CreditHistory']) &&
            is_numeric($_POST['PropertyArea'])
        ) {
            $formData = array(
                'Gender' => \$\_POST\[‘Gender’\], ‘Married’ =\>
\$\_POST\[‘Married’\], ‘Dependents’ =\> \$\_POST\[‘Dependents’\],
‘Education’ =\> \$\_POST\[‘Education’\], ‘SelfEmployed’ =\>
\$\_POST\[‘SelfEmployed’\], ‘ApplicantIncome’ =\>
\$\_POST\[‘ApplicantIncome’\], ‘CoapplicantIncome’ =\>
\$\_POST\[‘CoapplicantIncome’\], ‘LoanAmount’ =\>
\$\_POST\[‘LoanAmount’\], ‘LoanAmountTerm’ =\>
\$\_POST\[‘LoanAmountTerm’\], ‘CreditHistory’ =\>
\$\_POST\[‘CreditHistory’\], ‘PropertyArea’ =\>
\$\_POST\[‘PropertyArea’\], );

            // Set cURL options
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $formData);

            curl_setopt($curl, CURLOPT_URL, $apiUrl);

            // Make a POST request
            $response = curl_exec($curl);

            // Check for cURL errors
            if (curl_errno($curl)) {
                $error = curl_error($curl);
                // Handle the error appropriately
                die("cURL Error: $error");
            }

            // Process the response
            $data = json_decode($response, true);

            // Check if the response was successful
            if (isset($data['prediction'])) {
                // API request was successful
                // Access the predicted loan status
                echo "The predicted loan status is: " . $data['prediction'];
            } else {
                // API request failed or returned an error
                // Handle the error appropriately
                echo "API Error: " . $data['message'];
            }
        } else {
            echo "Form values must be numeric.";
        }
    } else {
        echo "All form fields are required.";
    }

}

// Close cURL session/resource curl_close(\$curl); ?\> \<!DOCTYPE html\>
<html>
<head>
<title>
POST Body
</title>
<style>
        form {
            margin: 30px 0px;
        }
&#10;        input {
            display: block;
            margin: 10px 15px;
            padding: 8px 10px;
            font-size: 16px;
        }
&#10;        div {
            font-size: 20px;
            margin: 0px 15px;
        }
&#10;        h2 {
            color: green;
            margin: 20px 15px;
        }
    </style>
</head>
<body>
<h2>
Loan Appraisal prediction
</h2>
<form method="post">
<input type="text" name="Gender" placeholder="Male or Female" required>
<input type="text" name="Married" placeholder="Marital Status (Yes or No)" required>
<input type="text" name="Dependents" placeholder="Dependents 0, 1, 2, 3+" required>
<input type="text" name="Education" placeholder="Graduate or Not Graduate" required>
<input type="text" name="SelfEmployed" placeholder="Self Employed (Yes or No)" required>
<input type="number" name="ApplicantIncome" placeholder="Enter monthly Income" required>
<input type="number" name="CoapplicantIncome" placeholder="Coapplicant monthly Income if applicable" required>
<input type="number" name="LoanAmount" placeholder="Enter Loan amount" required>
<input type="number" name="LoanAmountTerm" placeholder="Enter loan Term in days" required>
<input type="number" name="CreditHistory" placeholder="0-350 and below, 1-350 to 500" required>
<input type="text" name="PropertyArea" placeholder="Urban, SemiUrban, Rural" required>
<input type="submit" name="submit-btn" value="submit">
</form>
<br>
</body>
</html>

**etc.** as per the lab submission requirements. Be neat and communicate
in a clear and logical manner.
