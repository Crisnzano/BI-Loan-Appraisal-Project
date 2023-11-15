# *****************************************************************************
# 3: Basic Visualization ----
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

## Univariate Plots ----
### STEP 1. Create Histograms for Each Numeric Attribute ----
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


### STEP 2. Create Box and Whisker Plots for Each Numeric Attribute ----
# Box and whisker plots are useful in understanding the distribution of data.
# Further reading: https://www.scribbr.com/statistics/interquartile-range/

class(loans)
summary(loans)
colnames(loans)

par(mfrow = c(8, 8))
for (i in 8:8) {
  boxplot(loans[, i], main = names(loans)[i])
}

# This considers the 6th to the 7th attributes which are numeric.
# The fourth attribute in the dataset is of the type “factor”, i.e., categorical


boxplot(loans[, 6], main = names(loans)[6])
boxplot(loans[, 7], main = names(loans)[7])
boxplot(loans[, 8], main = names(loans)[8])
boxplot(loans[, 9], main = names(loans)[9])



### STEP 3. Create Bar Plots for Each Categorical Attribute ----
# Categorical attributes (factors) can also be visualized. This is done using a
# bar chart to give an idea of the proportion of instances that belong to each
# category.


barplot(table(loans[, 10]), main = names(loans)[10])

# Execute the following to create a bar plot for the categorical attributes
# 1 to 11 in the “loans” dataset:

par(mfrow = c(1, 5))
for (i in 1:5) {
  barplot(table(loans[, i]), main = names(loans)[i])
}


### STEP 4. Create a Missingness Map to Identify Missing Data ----
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

### STEP 5. Create a Correlation Plot ----
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

### STEP 6. Create Multivariate Box and Whisker Plots by Class ----
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