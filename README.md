## Coursera: Data Science Specialization
### Getting and Cleaning Data
### Course Project
### Due Sunday Mar 22, 2015
### Elliot Palmer

### Data URL:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Description:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Deliverables:
 1. a tidy data set as described below
 2. a link to a Github repository with your script for performing the analysis
 3. a code book that describes the variables, the data, and any transformations or work that you performed 
    to clean up the data called CodeBook.md. 
 4. You should also include a README.md in the repo with your scripts.

### Instructions:
 You should create one R script called run_analysis.R that does the following.
 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

==============
run_analysis.R
==============

This file downloads Samsung activity data from the internet and cleans the data creating a tidy data set for further analysis.

Steps:

1. Download Data
2. Unzip file
3. Load each of the individual text files in to R
  + Features
  + Activity descritions
  + Test X variables
  + Test Y variables
  + Test Subjects
  + Train X variables
  + Train Y variables
  + Train Subjects
4. Determine which variables are mean and std variables
5. Create vector to select mean and std variables
6. Subset the Test and Train data to only include mean and std variables
7. Add test and train lables to each observation
8. Combine X, Y, Subject Variables for both test and train data sets
9. Combine Test and Train Data Sets
10. Add the variable names to the data set
11. Add activity descriptions
12. Create second data set that averages each variable over each activity and subject
13. Write the data sets out to text files



  
