## run_analysis.R

## load libraries
library(dplyr)
library(plyr)

## read in the test data
subject_test <- read.table("subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
x_test<- read.table("x_test.txt", header = FALSE, stringsAsFactors = FALSE)
y_test<- read.table("y_test.txt", header = FALSE, stringsAsFactors = FALSE)

## build test data into single dataframe
test_data <- cbind(subject_test, y_test, x_test)

## add test column to flag this is test data
test_flag <- rep("test", times= nrow(test_data))
test_data_labelled <- cbind(test_flag, test_data)
test_data_labelled[,1] <- as.character(test_data_labelled[,1])

## read in the training data
subject_train <- read.table("subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
x_train<- read.table("x_train.txt", header = FALSE, stringsAsFactors = FALSE)
y_train<- read.table("y_train.txt", header = FALSE, stringsAsFactors = FALSE)

## build training data into single dataframe
train_data <- cbind(subject_train, y_train, x_train)

## add training column to flag this is training data
train_flag <- rep("training", times= nrow(train_data))
train_data_labelled <- cbind(train_flag, train_data)
train_data_labelled[,1] <- as.character(train_data_labelled[,1])

## add tidied column names
test_headings <- read.table("features.txt", header = FALSE, stringsAsFactors = F)
transpose <- t(test_headings)
transpose <- gsub("Acc", "Acceleration", transpose[2,])
transpose <- gsub("Gyro", "Gyroscope", transpose)
transpose <- gsub("BodyBody", "Body", transpose)
transpose <- gsub("tBody", "TimeBody", transpose)
transpose <- gsub("tGravity", "TimeGravity", transpose)
transpose <- gsub("fBody", "FourierBody", transpose)
transpose <- gsub("fGravity", "FourierGravity", transpose)
transpose <- gsub("mean\\(\\)", "Mean", transpose)
transpose <- gsub("std\\(\\)", "StdDeviation", transpose)
transpose <- gsub("Jerk", "Jerk", transpose)
transpose <- gsub("Mag", "Magnitude", transpose)
column_names <- c("typeofdata", "subjectid", "testperformed", transpose)

colnames(test_data_labelled) <- column_names
colnames(train_data_labelled) <- column_names

## combine two datasets into one set
combined_data <- rbind(test_data_labelled, train_data_labelled)

## keep only those with the data type, subject id, activity type and mean or std
columns_keep <- c(1:3, (grep("mean|std", test_headings$V2)+3))
condensed_data <- combined_data[, columns_keep]

## give the activities appropriate names
activity_labels <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors = F)
name_activities <- mapvalues(condensed_data[,3], from = activity_labels[,1], to = activity_labels[,2])
condensed_data[,3] <- name_activities

## make a second data set with the mean of each variable for each activity and subject
condensed_lesstypeofdata <- condensed_data[,-1]
summary_data <- aggregate(.~subjectid+testperformed, data = condensed_lesstypeofdata, FUN = "mean")
write.table(summary_data, file = "summary_data.txt", row.names = FALSE)
