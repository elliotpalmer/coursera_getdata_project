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
#  COMBINE DATA
#------------------------#
  
  zipName = "activityData.zip"
  
  fileCon <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zipName)
  
  unzip(zipName)
  
  setwd("./UCI HAR Dataset")

  testdir  <- "./test"
  traindir <- "./train"
  
  ## LOAD DATA ##
  
  features <- read.delim("features.txt", sep = "", header = FALSE)
  
  act_lbl <- read.delim("activity_labels.txt",sep = "", header = FALSE)
  colnames(act_lbl) <- c("ACTIVITY", "ACTIVITY_DESC")
  
  setwd(traindir)
  
  train.x <- read.delim("X_train.txt", sep = "", header = FALSE)
  train.y <- read.delim("Y_train.txt", sep = "", header = FALSE)
  train.s <- read.delim("subject_train.txt", sep = "", header = FALSE)
  
  setwd("../")
  setwd(testdir)
  
  test.x <- read.delim("X_test.txt", sep = "", header = FALSE)
  test.y <- read.delim("y_test.txt", sep = "", header = FALSE)
  test.s <- read.delim("subject_test.txt", sep = "", header = FALSE)
  
  ## Get Feature Columns ##
  
  mean_f <- grep(c("mean"),features$V2)
  std_f <- grep(c("std"),features$V2)
  
  incl_feat <- sort(append(mean_f,std_f))
  
  feature_names <- as.character(features$V2[incl_feat])
  
  ## Restrict Data to Mean / Std Columns ##
  
    test.x.r  <- test.x[,incl_feat]
    train.x.r <- train.x[,incl_feat]
  
  ## Combine Data ##
  
    ## ADD COLUMN TO DENOTE TEST / TRAIN DATA #
  
    test.x.r$TEST_TRAIN  <- "TEST"
    train.x.r$TEST_TRAIN <- "TRAIN"
    
    ## ADD Y values to data
    
    test.all <- cbind(test.x.r, test.s, test.y)
    train.all <- cbind(train.x.r, train.s,  train.y)
    
    ## COMBINE TEST AND TRAIN DATA ##
  
    data.all <- rbind(test.all, train.all)
    
    ## ADD FEATURE NAMES ##
  
    colnames(data.all) <- append(feature_names, c("TEST_TRAIN","SUBJECT", "ACTIVITY"))
    
    ## ADD ACTIVITY DESCRIPTIONS ##
  
    data.all <- merge(data.all,act_lbl)
    
    ## CREATE 2ND DATA SET ##
  
    # NEED TO AVERAGE ALL OF THE COLUMNS AND GROUP BY SUBJECT AND ACTIVITY #
  
    
    
  
  