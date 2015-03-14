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
  
#1. Download Data

  wd <- getwd()

  zipName = "activityData.zip"
  
  fileCon <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zipName)
  
#2. Unzip file  

  unzip(zipName)

#3. Load each of the individual text files in to R
  
  setwd("./UCI HAR Dataset")

  testdir  <- "./test"
  traindir <- "./train"
  
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
  
#4. Determine which variables are mean and std variables
  
  mean_f <- grep(c("mean()"),features$V2,fixed = T)
  std_f <- grep(c("std()"),features$V2,fixed = T)

#5. Create vector to select mean and std variables
  
  incl_feat <- sort(append(mean_f,std_f))
  
  feature_names <- as.character(features$V2[incl_feat])
  
#6. Subset the Test and Train data to only include mean and std variables
  
    test.x.r  <- test.x[,incl_feat]
    train.x.r <- train.x[,incl_feat]
  
#7. Add test and train lables to each observation
  
    test.x.r$TEST_TRAIN  <- "TEST"
    train.x.r$TEST_TRAIN <- "TRAIN"
    
#8. Combine X, Y, Subject Variables for both test and train data sets
    
    test.all <- cbind(test.x.r, test.s, test.y)
    train.all <- cbind(train.x.r, train.s,  train.y)
    
#9. Combine Test and Train Data Sets
  
    data.all <- rbind(test.all, train.all)
    
#10. Add the variable names to the data set
  
    colnames(data.all) <- append(feature_names, c("TEST_TRAIN","SUBJECT", "ACTIVITY"))
    
#11. Add activity descriptions
  
    data.all <- merge(data.all,act_lbl)
    data.all2 <- data.all[,c("SUBJECT","ACTIVITY","ACTIVITY_DESC","TEST_TRAIN",names(data.all[,2:67]))]
      
  
#12. Create second data set that averages each variable over each activity and subject
    
    data.agg <- aggregate(data.all[,2:67],
                          by=list(SUBJECT = data.all$SUBJECT,
                                  ACTIVITY = data.all$ACTIVITY,
                                  ACTIVITY_DESC = data.all$ACTIVITY_DESC,
                                  TEST_TRAIN = data.all$TEST_TRAIN),
                          FUN = mean)
    
#13. write the data sets out to text files
  
    setwd(wd)
    write.table(data.all,"tidydata.txt",row.name = FALSE)
    write.table(data.agg,"tidydata_agg.txt",row.name = FALSE)
  
  