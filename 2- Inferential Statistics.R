# *****************************************************************************
# 2: Inferential Statistics ----
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

## Step 1; Perform ANOVA on the “train_imputed_dataset” dataset ----
# ANOVA (Analysis of Variance) is a statistical test used to estimate how a
# quantitative dependent variable changes according to the levels of one or
# more categorical independent variables.

# The null hypothesis (H0) of the ANOVA is that
# “there is no difference in means”, and
# the alternative hypothesis (Ha) is that
# “the means are different from one another”.

# We can use the “aov()” function in R to calculate the test statistic for
# ANOVA. The test statistic is in turn used to calculate the p-value of your
# results. A p-value is a number that describes how likely you are to have
# found a particular set of observations if the null hypothesis were true. The
# smaller the p-value, the more likely you are to reject the null-hypothesis.

# The “crop_dataset” sample dataset loaded in STEP 4 contains observations from
# an imaginary study of the effects of fertilizer type and planting density on
# crop yield. In other words:

# Dependent variable:	Status


# One-Way ANOVA can be used to test the effect of the 3 types of Property Areas on
# Credit History whereas,
# Two-Way ANOVA can be used to test the effect of the 3 types of fertilizer and
# the 2 types of planting density on crop yield.
summary(loans$Status)
summary(loans$Gender)

loans_dataset_one_way_anova <- aov(CreditHistory ~ PropertyArea, data = loans)
summary(loans_dataset_one_way_anova)

# This shows the result of each variable and the residual. The residual refers
# to all the variation that is not explained by the independent variable. The
# list below is a description of each column in the result:

# 1.  Df column: Displays the degrees of freedom for the independent variable
#           (the number of levels (categories) in the variable minus 1),
#           and the degrees of freedom for the residuals (the total
#           number of observations minus the number of variables being
#           estimated + 1, i.e., (df(Residuals)=n-(k+1)).

# 2.	Sum Sq column: Displays the sum of squares (a.k.a. the total variation
#           between the group means and the overall mean). It is better to have
#           a lower Sum Sq value for residuals.

# 3.  Mean Sq column: The mean of the sum of squares, calculated by dividing
#           the sum of squares by the degrees of freedom for each parameter.

# 4.	F value column: The test statistic from the F test. This is the mean
#           square of each independent variable divided by the mean square of
#           the residuals. The larger the F value, the more likely it is that
#           the variation caused by the independent variable is real and not
#           due to chance.

# 5.	Pr(>F) column: The p-value of the F statistic. This shows how likely it
#           is that the F value calculated from the test would have occurred if
#           the null hypothesis of “no difference among group means” were true.

# The three asterisk symbols (***) implies that the p-value is less than 0.001.
# P<0.001 can be interpreted as “the type of fertilizer used has an impact on
# the final crop yield”.

# We can also have a situation where the Credit History depends not only on
# the type of Property Area used but also on the Dependents. A two-way ANOVA
# can then be used to confirm this. Execute the following for a two-way ANOVA
# (two independent variables):

loans_dataset_additive_two_way_anova <- aov(CreditHistory ~ PropertyArea + Dependents, # nolint
                                           data = loans)
summary(loans_dataset_additive_two_way_anova)

# Specifying an asterisk (*) instead of a plus (+) between the two independent
# variables (fertilizer * density) implies that they have an interaction effect
# rather than an additive effect.

# For example, an interaction effect would be that the fertilizer uptake by
# plants is affected by how close the plants are planted (density). An additive
# effect would be that the fertilizer uptake by plants is NOT affected by how
# close the plants are planted (density).

# Execute the following to perform a two-way ANOVA with the assumption that
# Credit History and Dependents have an interaction effect:

loans_dataset_interactive_two_way_anova <- aov(CreditHistory ~ PropertyArea * Dependents, # nolint
                                              data = loans)
summary(loans_dataset_interactive_two_way_anova)

# This can be interpreted as follows:
# The additive two-way ANOVA shows that the Credit History is affected by both the
# Property Area  and the Dependents (P<0.001 for both independent variables).
# The interactive two-way ANOVA also shows that the Credit History is affected by
# both the Property Area and the Dependents (P<0.001 for both independent variables).


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