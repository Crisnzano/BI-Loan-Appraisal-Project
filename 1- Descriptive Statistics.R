# *****************************************************************************
# Lab 2: Exploratory Data Analysis ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

# STEP 1. Install and use renv ----
# **Initialization: Install and use renv ----
# The renv package helps you create reproducible environments for your R
# projects. This is helpful when working in teams because it makes your R
# projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# Install renv:
if (!is.element("renv", installed.packages()[, 1])) {
  install.packages("renv", dependencies = TRUE)
}
require("renv")

# Use renv::init() to initialize renv in a new or existing project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
renv::init()

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open that project.

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot() to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# Execute the following code to reinstall the specific package versions
# recorded in the lockfile:
renv::restore()

# One of the packages required to use R in VS Code is the "languageserver"
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

# Loading Datasets ----
## STEP 2: Load datasets ----

library(readr)
loans <- read_csv("data/train_imputed.csv")
View(loans)

# Dimensions ----
## STEP 3. Preview the Loaded Datasets ----
# Dimensions refer to the number of observations (rows) and the number of
# attributes/variables/features (columns). Execute the following commands to
# display the dimensions of your datasets:

dim(loans)

# Data Types ----
## STEP 4. Identify the Data Types ----
# Knowing the data types will help you to identify the most appropriate
# visualization types and algorithms that can be applied. It can also help you
# to identify the need to convert from categorical data (factors) to integers
# or vice versa where necessary. Execute the following command to identify the
# data types:
sapply(loans, class)


# Descriptive Statistics ----

# We will first understand the data before using it to design
# prediction models and to make generalizable inferences. 

# 1. Measures of frequency
# (e.g., count, percent)

# 2. Measures of central tendency
# (e.g., mean, median, mode)
# Further reading: https://www.scribbr.com/statistics/central-tendency/

# 3. Measures of distribution/dispersion/spread/scatter/variability
# (e.g., range, quartiles, interquartile range, standard deviation, variance,
# kurtosis, skewness)
# Further reading: https://www.scribbr.com/statistics/variability/
# Further reading:
#   https://digitaschools.com/descriptive-statistics-skewness-and-kurtosis/
# Further reading: https://www.scribbr.com/statistics/skewness/

# 4. Measures of relationship
# (e.g., covariance, correlation, ANOVA)

# Further reading: https://www.k2analytics.co.in/covariance-and-correlation/
# Further reading: https://www.scribbr.com/statistics/one-way-anova/
# Further reading: https://www.scribbr.com/statistics/two-way-anova/

# Understanding your data can lead to:
# (i)	  Data cleaning: Removing bad data or imputing missing data.
# (ii)	Data transformation: Reduce the skewness by applying the same function
#       to all the observations.
# (iii)	Data modelling: You may notice properties of the data such as
#       distributions or data types that suggest the use (or not) of
#       specific algorithms.

## Measures of Frequency ----

### STEP 5. Identify the number of instances that belong to each class. ----
# It is more sensible to count categorical variables (factors or dimensions)
# than numeric variables, e.g., counting the number of male and female
# participants instead of counting the frequency of each participant’s height.
loans_freq <- loans$Education
cbind(frequency = table(loans_freq),
      percentage = prop.table(table(loans_freq)) * 100)


## Measures of Central Tendency ----
### STEP 6. Calculate the mode ----
# Unfortunately, R does not have an in-built function for calculating the mode.
# We, therefore, must manually create a function that can calculate the mode.

loans_Education_mode <- names(table(loans$Education))[
  which(table(loans$Education) == max(table(loans$Education)))
]
print(loans_Education_mode)


## Measures of Distribution/Dispersion/Spread/Scatter/Variability ----

### STEP 7. Measure the distribution of the data for each variable ----
summary(loans)


### STEP 8. Measure the standard deviation of each variable ----
# Measuring the variability in the dataset is important because the amount of
# variability determines how well you can generalize results from the sample
# dataset to a new observation in the population.

# Low variability is ideal because it means that you can better predict
# information about the population based on sample data. High variability means
# that the values are less consistent, thus making it harder to make
# predictions.

# The format “dataset[rows, columns]” can be used to specify the exact rows and
# columns to be considered. “dataset[, columns]” implies all rows will be
# considered. Specifying “Loans[, -4]” implies all the columns except
# column number 4. This can also be stated as
# “Loans[, c(1,2,3,5,6,7,8,9,10,11,12,13,14)]”. This allows us to
# calculate the standard deviation of only columns that are numeric, thus
# leaving out the columns termed as “factors” (categorical) or those that have
# a string data type.

#check data types
str(loans)


sapply(loans[, 9], sd)
sapply(loans[, c(6, 7, 8, 9, 10)], sd)

# The data type should be double (not numeric) so that it can be
# calculated.


### STEP 9. Measure the kurtosis of each variable ----
# The Kurtosis informs you of how often outliers occur in the results.

# There are different formulas for calculating kurtosis.
# Specifying “type = 2” allows us to use the 2nd formula which is the same
# kurtosis formula used in SPSS and SAS. More details about any function can be
# obtained by searching the R help knowledge base. The knowledge base says:

# In “type = 2” (used in SPSS and SAS):
# 1.	Kurtosis < 3 implies a low number of outliers
# 2.	Kurtosis = 3 implies a medium number of outliers
# 3.	Kurtosis > 3 implies a high number of outliers

if (!is.element("e1071", installed.packages()[, 1])) {
  install.packages("e1071", dependencies = TRUE)
}
require("e1071")

sapply(loans[, 10],  kurtosis, type = 2)

### STEP 10. Measure the skewness of each variable ----

# The skewness informs you of the asymmetry of the distribution of results.
# Similar to kurtosis, there are several ways of computing the skewness.
# Using “type = 2” can be interpreted as:

# 1.	Skewness between -0.4 and 0.4 (inclusive) implies that there is no skew
# in the distribution of results; the distribution of results is symmetrical;
# it is a normal distribution.
# 2.	Skewness above 0.4 implies a positive skew; a right-skewed distribution.
# 3.	Skewness below -0.4 implies a negative skew; a left-skewed distribution.

sapply(loans[, 10],  skewness, type = 2)


# Note, executing:
# skewness(loans$Dependents, type=2) # nolint
# computes the skewness for one variable called “Dependents” in theloans
# dataset. However, executing the following enables you to compute the skewness
# for all the variables in the “loans” dataset except variable number 12:


## Measures of Relationship ----

## STEP 11. Measure the covariance between variables ----
# Note that the covariance and the correlation are computed for numeric values
# only, not categorical values.
loans_cov <- cov(loans[, 6:10])
View(loans_cov)

## STEP 12. Measure the correlation between variables ----
loans_cor <- cor(loans[, 6:10])
View(loans_cor)


# Inferential Statistics ----
# Read the following article:
#   https://www.scribbr.com/statistics/inferential-statistics/
# Statistical tests (either for comparison, correlation, or regression) can be
# used to conduct *hypothesis testing*.

## Parametric versus Non-Parametric Statistical Tests ----
# If all the 3 points below are true, then
# use parametric tests, else use non-parametric tests.
# (i)	  the population that the sample comes from follows a normal distribution
#       of scores
# (ii)  the sample size is large enough to represent the population
# (iii) the variances of each group being compared are similar

## Statistical tests for comparison ----
# (i)	  t Test: parametric; compares means; uses 2 samples.
# (ii)	ANOVA: parametric; compares means; can use more than 3 samples.
# (iii)	Mood’s median: non-parametric; compares medians; can use more than 2
#       samples.
# (iv)	Wilcoxon signed-rank: non-parametric; compares distributions; uses 2
#       samples.
# (v)	  Wilcoxon rank-sum (Mann-Whitney U): non-parametric; compares sums of
#       rankings; uses 2 samples.
# (vi)	Kruskal-Wallis H: non-parametric; compares mean rankings; can use more
#       than 3 samples.

## Statistical tests for correlation ----
# (i)	  Pearson’s r: parametric; expects interval/ratio variables.
# (ii)	Spearman’s r: non-parametric; expects ordinal/interval/ratio variables.
# (iii)	Chi square test of independence: non-parametric; nominal/ordinal
#       variables.

## Statistical tests for regression ----
# (i)	  Simple linear regression: predictor is 1 interval/ratio variable;
#       outcome is 1 interval/ratio variable.
# (ii)	Multiple linear regression: predictor can be more than 2 interval/ratio
#       variables; outcome is 1 interval/ratio variable.
# (iii)	Logistic regression: predictor is 1 variable (any type); outcome is 1
#       binary variable.
# (iv)	Nominal regression: predictor can be more than 1 variable; outcome is 1
#       nominal variable.
# (v)	  Ordinal regression: predictor can be more than 1 variable; outcome is 1
#       ordinal variable.


# Qualitative Data Analysis ----
# This can be done through either
# thematic analysis:
#   https://www.scribbr.com/methodology/thematic-analysis/ or
# critical discourse analysis:
#   https://www.scribbr.com/methodology/discourse-analysis/

# Basic Visualization for Understanding the Dataset ----

# Note: If you are using R Studio, ensure that the "Plots" window on the bottom
# right of R Studio has enough space to display the chart.

# The fastest way to improve your understanding of the dataset is to visualize
# it. Visualization can help you to spot outliers and give you an idea of
# possible data transformations you can apply. The basic visualizations to
# understand your dataset can be univariate visualizations (helps you to
# understand a single attribute) or multivariate visualizations (helps you to
# understand the interaction between attributes). Packages used to create
# visualizations include:
# (i)	  Graphics package: Used to quickly create basic plots of data. This is
#       the most appropriate to quickly understand the dataset before
#       conducting further analysis.
# (ii)  Lattice package: Used to create more visually appealing plots of data.
# (iii) ggplot2 package: Used to create even more visually appealing plots of
#       data that can then be used to present the analysis results to the
#       intended users. Given its complexity, it is not necessary to use
#       ggplot2 to have a basic understanding of the dataset prior to further
#       analysis.

# Note that the goal at this point is to understand your data, not to create
# visually appealing plots that are publicly shared. The visually appealing
# plots will be created much later after the best prediction model has been
# chosen.

## Univariate Plots ----
### STEP 13. Create Histograms for Each Numeric Attribute ----
# Histograms help in determining whether an attribute has a Gaussian
# distribution. They can also be used to identify the presence of outliers.

# Execute the following code to create histograms for the “loans”
# dataset:
# Assuming your dataset is named 'loans' (replace with the actual name of your dataset)
data_types <- sapply(loans, class)
print(data_types)



# Execute the following code to create one histogram for attribute 4 (the only
# numeric column was “final crop yield (in bushels per acre)”) in the
# “crop_dataset” dataset:
# The code below converts column number 4 into unlisted and numeric data first
# so that a histogram can be plotted. Further reading:
# https://www.programmingr.com/r-error-messages/x-must-be-numeric-error-in-r-histogram/ ) # nolint
Loans_status <- as.numeric(unlist(loans[, 9]))
hist(Loans_status, main = names(loans)[9])


### STEP 14. Create Box and Whisker Plots for Each Numeric Attribute ----
# Box and whisker plots are useful in understanding the distribution of data.
# Further reading: https://www.scribbr.com/statistics/interquartile-range/

# Execute the following code to create box and whisker plots for the
# “BostonHousing” dataset:
# This considers the first 3 attributes which are numeric. The fourth attribute
# in the dataset is of the type “factor”, i.e., categorical.

par(mfrow = c(6, 7))
for (i in 6:7) {
  boxplot(loans[, i], main = names(loans)[i])
}

# This considers the 5th to the 14th attributes which are numeric.
# The fourth attribute in the dataset is of the type “factor”, i.e., categorical


boxplot(loans[, 6], main = names(loans)[6])
boxplot(loans[, 7], main = names(loans)[7])
boxplot(loans[, 8], main = names(loans)[8])
boxplot(loans[, 9], main = names(loans)[9])
boxplot(loans[, 10], main = names(loans)[10])


### STEP 15. Create Bar Plots for Each Categorical Attribute ----
# Categorical attributes (factors) can also be visualized. This is done using a
# bar chart to give an idea of the proportion of instances that belong to each
# category.


barplot(table(loans[, 12]), main = names(loans)[12])

# Execute the following to create a bar plot for the categorical attributes
# 1 to 11 in the “loans” dataset:

par(mfrow = c(1, 11))
for (i in 1:11) {
  barplot(table(loans[, i]), main = names(loans)[i])
}


### STEP 16. Create a Missingness Map to Identify Missing Data ----
# Some machine learning algorithms cannot handle missing data. A missingness
# map (also known as a missing plot) can be used to get an idea of the amount
# missing data in the dataset. The x-axis of the missingness map shows the
# attributes of the dataset whereas the y-axis shows the instances in the
# dataset.
# Horizontal lines indicate missing data for an instance whereas vertical lines
# indicate missing data for an attribute. The missingness map requires the
# “Amelia” package.

# Execute the following to create a map to identify the missing data in each
# dataset:
if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")

missmap(loans, col = c("red", "grey"), legend = TRUE)

# As shown in the results, the datasets that was loaded in this lab has no 
# missing data. 

## Multivariate Plots ----

### STEP 17. Create a Correlation Plot ----
# Correlation plots can be used to get an idea of which attributes change
# together. The function “corrplot()” found in the package “corrplot” is
# required to perform this. The larger the dot in the correlation plot, the
# larger the correlation. Blue represents a positive correlation whereas red
# represents a negative correlation.

# Execute the following to create correlation plots for 3 of the datasets
# loaded in STEP 2 to STEP 4:
if (!is.element("corrplot", installed.packages()[, 1])) {
  install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")
corrplot(cor(loans[, 6:10]), method = "circle")


# Alternatively, the 'ggcorrplot::ggcorrplot()' function can be used to plot a
# more visually appealing plot.
# The code below shows how to install a package in R:
if (!is.element("ggcorrplot", installed.packages()[, 1])) {
  install.packages("ggcorrplot", dependencies = TRUE)
}
require("ggcorrplot")
ggcorrplot(cor(loans[, 6:10]))


# Alternatively, the ggcorrplot package can be used to make the plots more
# appealing:
ggplot(loans,
       aes(x = Dependents, y = Education, shape = Status, color = Status)) +
  geom_point() +
  geom_smooth(method = lm)

### STEP 18. Create Multivariate Box and Whisker Plots by Class ----
# This applies to datasets where the target (dependent) variable is categorical.
# Execute the following code:
if (!is.element("caret", installed.packages()[, 1])) {
  install.packages("caret", dependencies = TRUE)
}
require("caret")
featurePlot(x = loans[, 1:12], y = loans[, 12],
            plot = "box")

# **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
renv::snapshot()

# References ----
## Bevans, R. (2023a). ANOVA in R | A Complete Step-by-Step Guide with Examples. Scribbr. Retrieved August 24, 2023, from https://www.scribbr.com/statistics/anova-in-r/ # nolint ----

## Bevans, R. (2023b). Sample Crop Data Dataset for ANOVA (Version 1) [Dataset]. Scribbr. https://www.scribbr.com/wp-content/uploads//2020/03/crop.data_.anova_.zip # nolint ----

## Fisher, R. A. (1988). Iris [Dataset]. UCI Machine Learning Repository. https://archive.ics.uci.edu/dataset/53/iris # nolint ----

## National Institute of Diabetes and Digestive and Kidney Diseases. (1999). Pima Indians Diabetes Dataset [Dataset]. UCI Machine Learning Repository. https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database # nolint ----

## StatLib CMU. (1997). Boston Housing [Dataset]. StatLib Carnegie Mellon University. http://lib.stat.cmu.edu/datasets/boston_corrected.txt # nolint ----


# **Required Lab Work Submission** ----

# NOTE: The lab work should be done in groups of between 2 and 5 members using
#       Git and GitHub.

## Part A ----
# Create a new file called "Lab2-Submission-ExploratoryDataAnalysis.R".
# Provide all the code you have used to perform an exploratory data analysis of
# the "Class Performance Dataset" provided on the eLearning platform.

## Part B ----
# Upload *the link* to your "Lab2-Submission-ExploratoryDataAnalysis.R" hosted
# on Github (do not upload the .R file itself) through the submission link
# provided on eLearning.

## Part C ----
# Create a markdown file called "Lab-Submission-Markdown.Rmd"
# and place it inside the folder called "markdown". Use R Studio to ensure the
# .Rmd file is based on the "GitHub Document (Markdown)" template when it is
# being created.

# Refer to the following file in Lab 1 for an example of a .Rmd file based on
# the "GitHub Document (Markdown)" template:
#     https://github.com/course-files/BBT4206-R-Lab1of15-LoadingDatasets/blob/main/markdown/BIProject-Template.Rmd # nolint

# Include Line 1 to 14 of BIProject-Template.Rmd in your .Rmd file to make it
# displayable on GitHub when rendered into its .md version

# It should have code chunks that explain only *the most significant*
# analysis performed on the dataset.

# The emphasis should be on Explanatory Data Analysis (explains the key
# statistics performed on the dataset) as opposed to
# Exploratory Data Analysis (presents ALL the statistics performed on the
# dataset). Exploratory Data Analysis that presents ALL the possible statistics
# re-creates the problem of information overload.

## Part D ----
# Render the .Rmd (R markdown) file into its .md (markdown) version by using
# knitR in RStudio.
# Documentation of knitR: https://www.rdocumentation.org/packages/knitr/

# Upload *the link* to "Lab-Submission-Markdown.md" (not .Rmd)
# markdown file hosted on Github (do not upload the .Rmd or .md markdown files)
# through the submission link provided on eLearning.