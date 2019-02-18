# CodeBook for tidying data from the Human Activity Recognition Using Smartphones Dataset

Please also see the README.md file for information on the data source and license requirements

## Study design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## The variables

The R script run_analysis.R tidies and subsets the raw data from the Human Activity Recognition Using Smartphones Dataset into two data sets.

### Condensed data - holds the 'raw' data by subject, test performed and randomly allocated test vs training variables for a subset of the variables

subject - an integer from 1-30 for each of the 30 test participants
test performed - one of 6 activities listed in the activity_labels.txt file
test vs training - the original researchers split the participants randomly in the proportion 70:30 and allocated them to test or training for the purposes of Machine Learning on the data set

The remaining features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 'time') were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcceleration-XYZ and timeGravityAcceleration-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerationJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerationMagnitude, timeGravityAccelerationMagnitude, timeBodyAccelerationJerkMagnitude, timeBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fourierBodyAcceleration-XYZ etc. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

Mean: Mean value
StdDeviation: Standard deviation

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### Summary data - output as a .txt file at the end of the analysis

The summary data table contains the mean of each of the above variables for each activity and each subject

## Analysis and transformations performed

* All files are read into R using read.table
* The test data set is aggregated from a number of files and labelled as test
* The training data set is aggregated from a number of files and labelled as training
* The two data sets are combined into one complete data set
* The column headings are changed to be more intuitive to a reader
* Only the Mean and Standard Deviations of each variable are retained, with the other variables removed
* The activity undertaken (e.g. walking) is converted to text from the original code (e.g. 1)
* The mean of each remaining variable by activity and subject is calculated and returned in the summary_data table
