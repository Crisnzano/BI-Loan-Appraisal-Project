# *****************************************************************************
# 8: Consolidation ----
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

# **[OPTIONAL] Initialization: Install and use renv ----
# The R Environment ("renv") package helps you create reproducible environments
# for your R projects. This is helpful when working in teams because it makes
# your R projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# "renv" It can be installed as follows:
# if (!is.element("renv", installed.packages()[, 1])) {
# install.packages("renv", dependencies = TRUE,
# repos = "https://cloud.r-project.org") # nolint
# }
# require("renv") # nolint

# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
# renv::init() # nolint

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open the project.

# Consider a library as the location where packages are stored.
# Execute the following command to list all the libraries available in your
# computer:
.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)

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
# renv::snapshot(), AT THE END, to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# [OPTIONAL]
# Execute the following code to reinstall the specific package versions
# recorded in the lockfile (restart R after executing the command):
# renv::restore() # nolint

# [OPTIONAL]
# If you get several errors setting up renv and you prefer not to use it, then
# you can deactivate it using the following command (restart R after executing
# the command):
# renv::deactivate() # nolint

# If renv::restore() did not install the "languageserver" package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Introduction ----
# What do you do after you have designed a model that is accurate enough to use?
# This is a critical question whose answer enables the gap between research and
# practice to be addressed.

# It is possible to discover the key internal representation of a model found
# by an algorithm (e.g., the coefficients in a linear model) and use
# them in a new implementation of the prediction algorithm in another
# program developed using a programming language other than R.

# This is easier to do for simpler algorithms that use a simple representation,
# e.g., a linear model, than for algorithms that use more complex
# representations.

# "caret" provides access to "the best" model from a training run in the
# "finalModel" variable.
# The "predict()" function in the "caret" package automatically uses the
# "finalModel" to make predictions on a new dataset. The data provided as the
# "new dataset" can be stored in a separate file and loaded as a data frame.

# STEP 1. Install and Load the Required Packages ----
## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# STEP 2. Load the Dataset ----

library(readr)
loans_imputed <- read_csv("data/loans_imputed.csv")
View(train_imputed)
# STEP 3. Train the Model ----
# create an 80%/20% data split for training and testing datasets respectively
set.seed(9)
train_index <- createDataPartition(loans_imputed$Status,
                                   p = 0.80, list = FALSE)
loans_imputed_training <- loans_imputed[train_index, ]
loans_imputed_testing <- loans_imputed[-train_index, ]

set.seed(9)
train_control <- trainControl(method = "cv", number = 10)
loans_imputed_model_lda <- train(Status ~ ., data = loans_imputed_training,
                                 method = "lda", metric = "Accuracy",
                                 trControl = train_control)

# We print a summary of what caret has done
print(loans_imputed_model_lda)

# We then print the details of the model that has been created
print(loans_imputed_model_lda$finalModel)

# STEP 4. Test the Model ----
# We can test the model
set.seed(9)

# Define the levels you expect in the Status variable
expected_levels <- c("Y", "N")

# Convert the Status variable to a factor with the defined levels
loans_imputed_testing[, 1:12]$Status <- factor(loans_imputed_testing[, 1:12]$Status, levels = expected_levels)

predictions <- predict(loans_imputed_model_lda, newdata = loans_imputed_testing)
confusionMatrix(predictions, loans_imputed_testing$Status)

print(loans_imputed_testing)

print(predictions)

# STEP 5. Save and Load your Model ----
# Saving a model into a file allows you to load it later and use it to make
# predictions. Saved models can be loaded by calling the `readRDS()` function

saveRDS(loans_imputed_model_lda, "./models/saved_loans_model_lda.rds")
# The saved model can then be loaded later as follows:
loaded_loans_imputed_model_lda <- readRDS("./models/saved_loans_model_lda.rds")
print(loaded_loans_imputed_model_lda)

predictions_with_loaded_model <-
  predict(loaded_loans_imputed_model_lda, newdata = loans_imputed_testing)
confusionMatrix(predictions_with_loaded_model, loans_imputed_testing$Status)


# STEP 6. Creating Functions in R ----

# Plumber requires functions, an example of the syntax for creating a function
# in R is:

name_of_function <- function(arg) {
  # Do something with the argument called `arg`
}

# STEP 7. Make Predictions on New Data using the Saved Model ----
# We can also create and use our own data frame as follows:
to_be_predicted <-
  # Create a data frame with appropriate values and types
  to_be_predicted <- data.frame(
    Gender = "Male",   # Specify as character or factor
    Married = "No",    # Specify as character or factor
    Dependents = "0",     # factor
    Education = "Graduate",  # Specify as character or factor
    SelfEmployed = "Yes",    # Specify as character or factor
    ApplicantIncome = 4583,   # Numeric
    CoapplicantIncome = 1508, # Numeric
    LoanAmount = 12841,       # Numeric
    LoanAmountTerm = 360,     # Numeric
    CreditHistory = 1,        # Numeric
    PropertyArea = "Urban"    # Specify as character or factor
  )

# Use factor() to set factor levels if needed
to_be_predicted$Gender <- factor(to_be_predicted$Gender, levels = levels(loaded_loans_imputed_model_lda$Gender))
to_be_predicted$Married <- factor(to_be_predicted$Married, levels = levels(loaded_loans_imputed_model_lda$Married))
to_be_predicted$Education <- factor(to_be_predicted$Education, levels = levels(loaded_loans_imputed_model_lda$Education))
to_be_predicted$SelfEmployed <- factor(to_be_predicted$SelfEmployed, levels = levels(loaded_loans_imputed_model_lda$SelfEmployed))
to_be_predicted$PropertyArea <- factor(to_be_predicted$PropertyArea, levels = levels(loaded_loans_imputed_model_lda$PropertyArea))
#to_be_predicted$Dependents <- factor(to_be_predicted$Dependents, levels = levels(loaded_train_imputed_model_lda$Dependents))

# Make predictions
predictions <- predict(loaded_loans_imputed_model_lda, newdata = to_be_predicted)
print(predictions)


# We then use the data frame to make predictions
predict(loaded_loans_imputed_model_lda, newdata = to_be_predicted)


# STEP 8. Make predictions using the model through a function ----
# An alternative is to create a function and then use the function to make
# predictions

predict_status <-
  function(arg_Gender, arg_Married, arg_Dependents, arg_Education, arg_SelfEmployed,
           arg_ApplicantIncome, arg_CoapplicantIncome, arg_LoanAmount, arg_LoanAmountTerm, arg_CreditHistory,
           arg_PropertyArea) {
    # Create a data frame using the arguments
    to_be_predicted <-
      data.frame(Gender = arg_Gender, Married = arg_Married,
                 Dependents = arg_Dependents, Education = arg_Education,
                 SelfEmployed = arg_SelfEmployed, ApplicantIncome = arg_ApplicantIncome,
                 CoapplicantIncome = arg_CoapplicantIncome, LoanAmount = arg_LoanAmount,
                 LoanAmountTerm = arg_LoanAmountTerm, CreditHistory = arg_CreditHistory, PropertyArea = arg_PropertyArea)
    
    # Make a prediction based on the data frame
    predict(loaded_loans_imputed_model_lda, to_be_predicted)
  }


# We can now call the function predict_diabetes() instead of calling the
# predict() function directly

# Assuming Dependents should be a factor

predict_status("Male", "No", "0", "Graduate", "Yes", 4583, 1508, 12841, 360, 1, "Urban")


# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
# renv::snapshot() # nolint