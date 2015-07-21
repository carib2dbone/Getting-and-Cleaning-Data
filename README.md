# Getting-and-Cleaning-Data
Repo for the Getting and Cleaning Data course.

This tidy dataset was created from data gathered from an experiment on Human Activity Recognition Using Smartphones carried with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

More details on the experiment and the dataset can be got from this site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original dataset includes the following files:
==================================================

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/subject_train.txt': Training Subject set.

- 'train/X_train.txt': Training set.

- 'test/subject_train.txt': Test Subject set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The exercise requires an R script (run_analysis.R) that does the following:
===========================================================================
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How the script works:
=====================
The dataset is downloaded using download() and unzipped using unzip() into its default folder off the working directory. The training and test sets are by default stored in separate subfolders of this folder. The training and test Subjects and Activities are loaded into data tables (TrainSubjects; TestSubjects; TrainActivities; TestActivities) using fread() while the training and test results are loaded (TrainData; TestData) using read.table() since fread() was giving problems.

1. Merge the training and the test sets to create one data set.
The TestSubjects are merged row-wise (appended using rbind()) to the TrainSubjects to get AllSubjects. Similarly the TestActivities are merged with TrainActivities to get AllActivities and TestData merged with TrainData to get AllData. Columns in each table are renamed accordingly.
Then AllActivities and AllData are merger column-wise (cbind()) to AllSubjects to form one table, Dataset. The key to this table is set to Subject, ActivityNum.

2. Extract only the measurements on the mean and standard deviation for each measurement.
The features fie contains descriptions of the features and this is used to determine which features correspond to mean or standard deviation. This file is read into the Features table using fread() and the columns renamed. The FeatureName column will have "mean()" or "std()" for measurements corresponding to mean and standard deviation, respectively, so this column is searched for these occurences and the resulting column numbers stored in a vector. "V" is then added to these column numbers so that they match the values of the FeatureNum column in the Dataset. Then a subset of columns comprising the key and the columns stored in the vector are extracted from the dataset to form a new dataset, SubDataset. The original dataset is preserved for possible future use.

3. Use descriptive activity names to name the activities in the data set.
Activity names are stored in the activity file. These are read into the ActivityNames table using fread() and the columns appropriately renamed. ActivityNames is then merged with the Subdataset on ActivityNum. The columns of SubDataset are then reordered so that the key values stay together and the key is set to Subject, ActivityNum, ActivityName.

4. Appropriately labels the data set with descriptive variable names. 
"V" is added to the FeatureNum values of the Features table so that they match the FeatureCode's of the SubDataset. The SubDataset table is converted from 'short and wide' (where all the feature values are stored in different columns) to a 'tall and thin' table (where each feature and its value is stored in a separate row). The Features table is then merged with the SubDataset table so that the SubDataset table now has FeatureName's. FeatureName is copied to FeatureCode since the existing FeatureCode is 'meaningless', so now FeatureCode has the values from the existing FeatureName. Next FeatureName is modified repeatedly using gsub() to form more meaningful names. Finally the key is set to Subject, ActivityNum, ActivityName, FeatureCode, FeatureName.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
A new table, TidyDataset, is created from SubDataset by extracting the key columns and the mean of the values, grouped by the key columns.


Make codebook
-------------
The codebook, codebook.md, is generated via the GenerateCodebook.Rmd file using knit() from knitr library. A corresponding codebook.html file is also generated using markdown() from the markdown library.

Create file for upload to project
---------------------------------
The tab-separated file, TidyDataset.txt, is generated using write.table() with row.names=FALSE and sep="\t".
