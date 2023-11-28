Business Intelligence Lab Submission Markdown
================
\<\>
\<23/10/2023\>

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
  - [Milestone 6 out of 8](#milestone-6-out-of-8)
- [Loading the Loan Status Train Imputed
  Dataset](#loading-the-loan-status-train-imputed-dataset)

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
Milestone will have its own packages.

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

install.packages("formatR")
```

    ## The following package(s) will be installed:
    ## - formatR [1.14]
    ## These packages will be installed into "C:/Users/Cris/github-classroom/BI-Loan-Appraisal-Project/markdown/renv/library/R-4.3/x86_64-w64-mingw32".
    ## 
    ## # Installing packages --------------------------------------------------------
    ## - Installing formatR ...                        OK [linked from cache]
    ## Successfully installed 1 package in 16 milliseconds.

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

## Milestone 6 out of 8

# Loading the Loan Status Train Imputed Dataset

Issue 6 Training the Model.

``` r
## 6. Training the Model ----

if (!is.element("languageserver", installed.packages()[, 1])) {
    install.packages("languageserver", dependencies = TRUE, repos = "https://cloud.r-project.org")
}
require("languageserver")

# Introduction ---- The performance of the trained models can be compared
# visually. This is done to help you to identify and choose the top performing
# models.

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

## kernlab ----
if (require("kernlab")) {
    require("kernlab")
} else {
    install.packages("kernlab", dependencies = TRUE, repos = "https://cloud.r-project.org")
}

## randomForest ----
if (require("randomForest")) {
    require("randomForest")
} else {
    install.packages("randomForest", dependencies = TRUE, repos = "https://cloud.r-project.org")
}



## STEP 2. Load the Dataset ----
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

## STEP 3. The Resamples Function ----

# Analogy: We cannot compare apples with oranges; we compare apples with
# apples.

# The 'resamples()' function checks that the models are comparable and that
# they used the same training scheme ('train_control' configuration).  To do
# this, after the models are trained, they are added to a list and we pass this
# list of models as an argument to the resamples() function in R.

## 3.a. Train the Models ---- We train the following models, all of which are
## using 10-fold repeated cross validation with 3 repeats: LDA CART KNN SVM
## Random Fores

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### LDA ----
set.seed(7)
loans_imputed_model_lda <- train(Status ~ ., data = loans, method = "lda", trControl = train_control)

### CART ----
set.seed(7)
loans_imputed_model_cart <- train(Status ~ ., data = loans, method = "rpart", trControl = train_control)

### KNN ----
set.seed(7)
loans_imputed_model_knn <- train(Status ~ ., data = loans, method = "knn", trControl = train_control)

### SVM ----
set.seed(7)
loans_imputed_model_svm <- train(Status ~ ., data = loans, method = "svmRadial",
    trControl = train_control)

### Random Forest ----
set.seed(7)
loans_imputed_model_rf <- train(Status ~ ., data = loans, method = "rf", trControl = train_control)

## 3.b. Call the `resamples` Function ---- We then create a list of the model
## results and pass the list as an argument to the `resamples` function.

results <- resamples(list(LDA = loans_imputed_model_lda, CART = loans_imputed_model_cart,
    KNN = loans_imputed_model_knn, SVM = loans_imputed_model_svm, RF = loans_imputed_model_rf))

# STEP 4. Display the Results ---- 1. Table Summary ---- This is the simplest
# comparison. It creates a table with one model per row and its corresponding
# evaluation metrics displayed per column.

summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: LDA, CART, KNN, SVM, RF 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## LDA  0.7377049 0.7960578 0.8130619 0.8137810 0.8360656 0.8688525    0
    ## CART 0.7049180 0.7714172 0.8064516 0.7947343 0.8196721 0.8688525    0
    ## KNN  0.5573770 0.6169355 0.6557377 0.6530434 0.6774194 0.7213115    0
    ## SVM  0.7377049 0.7911546 0.8064516 0.8094182 0.8326943 0.8524590    0
    ## RF   0.7377049 0.7877446 0.8064516 0.8050728 0.8225806 0.8524590    0
    ## 
    ## Kappa 
    ##            Min.     1st Qu.     Median      Mean    3rd Qu.      Max. NA's
    ## LDA   0.2339089  0.44725111 0.49539163 0.4930891 0.56480068 0.6543909    0
    ## CART  0.2855051  0.38377792 0.46883104 0.4562377 0.51904090 0.6543909    0
    ## KNN  -0.2263589 -0.04734239 0.01493286 0.0146983 0.09109683 0.2004626    0
    ## SVM   0.2339089  0.44265198 0.49041096 0.4767094 0.54651307 0.6174216    0
    ## RF    0.2339089  0.43317789 0.47285762 0.4699364 0.52405786 0.6047516    0

``` r
## 2. Box and Whisker Plot ---- This is useful for visually observing the
## spread of the estimated accuracies for different algorithms and how they
## relate.

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)
```

![](Lab8-Submission-ModelTraining_files/figure-gfm/Train%20Model-1.png)<!-- -->

``` r
## 3. Dot Plots ---- They show both the mean estimated accuracy as well as the
## 95% confidence interval (e.g. the range in which 95% of observed scores
## fell).

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)
```

![](Lab8-Submission-ModelTraining_files/figure-gfm/Train%20Model-2.png)<!-- -->

``` r
## 4. Scatter Plot Matrix ---- This is useful when considering whether the
## predictions from two different algorithms are correlated. If weakly
## correlated, then they are good candidates for being combined in an ensemble
## prediction.

splom(results)
```

![](Lab8-Submission-ModelTraining_files/figure-gfm/Train%20Model-3.png)<!-- -->

``` r
## 5. Pairwise xyPlots ---- You can zoom in on one pairwise comparison of the
## accuracy of trial-folds for two models using an xyplot.

# xyplot plots to compare models
xyplot(results, models = c("LDA", "SVM"))
```

![](Lab8-Submission-ModelTraining_files/figure-gfm/Train%20Model-4.png)<!-- -->

``` r
# or xyplot plots to compare models
xyplot(results, models = c("SVM", "CART"))
```

![](Lab8-Submission-ModelTraining_files/figure-gfm/Train%20Model-5.png)<!-- -->

``` r
## 6. Statistical Significance Tests ---- This is used to calculate the
## significance of the differences between the metric distributions of the
## various models.

### Upper Diagonal ---- The upper diagonal of the table shows the estimated
### difference between the distributions. If we think that LDA is the most
### accurate model from looking at the previous graphs, we can get an estimate
### of how much better it is than specific other models in terms of absolute
### accuracy.

### Lower Diagonal ---- The lower diagonal contains p-values of the null
### hypothesis.  The null hypothesis is a claim that 'the distributions are the
### same'.  A lower p-value is better (more significant).

diffs <- diff(results)

summary(diffs)
```

    ## 
    ## Call:
    ## summary.diff.resamples(object = diffs)
    ## 
    ## p-value adjustment: bonferroni 
    ## Upper diagonal: estimates of the difference
    ## Lower diagonal: p-value for H0: difference = 0
    ## 
    ## Accuracy 
    ##      LDA       CART      KNN       SVM       RF       
    ## LDA             0.019047  0.160738  0.004363  0.008708
    ## CART 0.003626             0.141691 -0.014684 -0.010338
    ## KNN  < 2.2e-16 2.636e-13           -0.156375 -0.152029
    ## SVM  0.300813  0.047484  < 2.2e-16            0.004345
    ## RF   0.013136  0.768128  < 2.2e-16 1.000000           
    ## 
    ## Kappa 
    ##      LDA       CART      KNN       SVM       RF       
    ## LDA             0.036851  0.478391  0.016380  0.023153
    ## CART 0.005434             0.441539 -0.020472 -0.013699
    ## KNN  < 2.2e-16 1.044e-15           -0.462011 -0.455238
    ## SVM  0.088726  0.454348  < 2.2e-16            0.006773
    ## RF   0.006104  1.000000  < 2.2e-16 1.000000

``` r
# The model of choice will be 'LDA'.This is as a result of the model givong the
# highest accuracy of 0.8137810 as compared to the other models (CART 0.7947),
# (KNN 0.6530), (SVM 0.8094) AND (RF 0.8050)


# Upload *the link* to 'Lab-Submission-Markdown.md' (not .Rmd) markdown file
# hosted on Github (do not upload the .Rmd or .md markdown files) through the
# submission link provided on eLearning. install the same package version in
# their local machine during their initialization step.  renv::snapshot()
```

**etc.** as per the lab submission requirements. Be neat and communicate
in a clear and logical manner.
