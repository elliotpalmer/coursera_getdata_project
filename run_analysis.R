# Coursera: Data Science Specialization
# Getting and Cleaning Data
# Course Project
# Due Sunday Mar 22, 2015
# Elliot Palmer

# Data URL:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Data Description:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Deliverables:
# 1: a tidy data set as described below
# 2: a link to a Github repository with your script for performing the analysis
# 3: a code book that describes the variables, the data, and any transformations or work that you performed 
#    to clean up the data called CodeBook.md. 
# 4: You should also include a README.md in the repo with your scripts.

# Instructions:
# You should create one R script called run_analysis.R that does the following. 
# 1: Merges the training and the test sets to create one data set.
# 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3: Uses descriptive activity names to name the activities in the data set
# 4: Appropriately labels the data set with descriptive variable names. 
# 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#------------------------#
  COMBINE DATA
#------------------------#
  
  testdir <- "./test"
  traindir <- "./train"
  
  setwd(traindir)
  
  train.x <- read.delim("X_train.txt", sep = "", header = FALSE)
  train.y <- read.delim("Y_train.txt", sep = "", header = FALSE)

  setwd("../")
  setwd(testdir)
  
  test.x <- read.delim("X_test.txt", sep = "", header = FALSE)
  test.y <- read.delim("y_test.txt", sep = "", header = FALSE)
  
  