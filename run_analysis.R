# need this in order to read https
setInternet2(TRUE)

# load libraries
library(downloader)
library( reshape2)
library(data.table)

# Set the working directory
# setwd("C:/Ras/Coursera/Getting and Cleaning Data/data")

# get the data
## download the file
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFile <- "Dataset.zip"
if (!file.exists(path)) {
    dir.create(path)
}
download(url, dest="Dataset.zip", mode="wb")
## unzip file
unzip("Dataset.zip", exdir=path)
## read the files
dataDir <- file.path(path, "UCI HAR Dataset")
dtTrainSubjects <- fread(file.path(dataDir, "train", "subject_train.txt"))
dtTestSubjects <- fread(file.path(dataDir, "test", "subject_test.txt"))
dtTrainActivities <- fread(file.path(dataDir, "train", "Y_train.txt"))
dtTestActivities <- fread(file.path(dataDir, "test", "Y_test.txt"))
## these files are not easily read by fread
dfTrain <- read.table(file.path(dataDir, "train", "X_train.txt"))
dfTest <- read.table(file.path(dataDir, "test", "X_test.txt"))
dtTrainData = data.table(dfTrain)
dtTestData = data.table(dfTest)

# 1. Merge the training and the test sets to create one data set.
## Append TestSubjects to TrainSubjects, TestActivities to TrainActivities and TestData to TrainData
## and rename the column headings
dtAllSubjects <- rbind(dtTrainSubjects, dtTestSubjects)
## view the contents of file to determine what columns need to be renamed
dtAllSubjects
setnames(dtAllSubjects, "V1", "Subject")
dtAllActivities <- rbind(dtTrainActivities, dtTestActivities)
## view the contents of file to determine what columns need to be renamed
dtAllActivities
setnames(dtAllActivities, "V1", "ActivityNum")
dtAllData <- rbind(dtTrainData, dtTestData)
dtAllData
## Now merge (column-wise) Activities with Subjects and Data
dtDataset <- cbind(dtAllSubjects, dtAllActivities)
dtDataset <- cbind(dtDataset, dtAllData)
head(dtDataset)
## Create a key to the dataset
setkey(dtDataset, Subject, ActivityNum)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# Get the list of features from the features.txt file
dtFeatures <- fread(file.path(dataDir, "features.txt"))
## view the contents of file to determine what columns need to be renamed
dtFeatures
## rename the column headings
setnames(dtFeatures, c("V1","V2"), c("FeatureNum", "FeatureName"))
## determine which features correspond to mean ("mean()") and standad deviation ("std()")
dtMeanOrStdFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", FeatureName)]
## extract the list (vector) of FeatureNum's corresponding to the mean and standard deviation
## and add a "V' to the column numbers so that they match the columns in the dataset
dtSubFeaturesNums <- dtMeanOrStdFeatures[, paste0("V", FeatureNum)]
## now get the subset
dtSubDataset <- dtDataset[, c(key(dtDataset), dtSubFeaturesNums), with=FALSE]
## create key
setkey(dtSubDataset, Subject, ActivityNum)

# 3. Use descriptive activity names to name the activities in the data set.
## Extract activity names from the activity_labels.txt file
dtActivityNames <- fread(file.path(dataDir, "activity_labels.txt"))
dtActivityNames
setnames(dtActivityNames, c("V1","V2"), c("ActivityNum", "ActivityName"))
## Now merge these activity names with the dataset (merge on ActivityNum column)
dtSubDataset <- merge(dtSubDataset, dtActivityNames, by = "ActivityNum", all.x = TRUE)
## Move the ActivityName column to the front (after the ActivityNum column)
col_idx <- grep("ActivityName", names(dtSubDataset))
dt1 <- dtSubDataset[, c(1:2, col_idx), with=FALSE]
dt2 <- dtSubDataset[, -c(1:2, col_idx), with=FALSE]
dtSubDataset <- cbind(dt1, dt2)
## Add ActivityName to the key
setkey(dtSubDataset, Subject, ActivityNum, ActivityName)

# 4. Appropriately labels the data set with descriptive variable names. 
## Set the FeatureNum of the features to match that of the data set's FeatureCode
dtFeaturesV <- dtFeatures
setnames(dtFeaturesV, "FeatureNum", "FeatureCode")
dtFeaturesV$FeatureCode <- sub("^","V",dtFeaturesV$FeatureCode)
## Convert the dataset from short and wide to tall and thin
dtSubDataset <- data.table(melt(dtSubDataset, key(dtSubDataset), variable.name = "FeatureCode"))
## Now add the FeatureNames to the dataset (by merging the features list)
dtSubDataset <- merge(dtSubDataset, dtFeaturesV, by = "FeatureCode", all.x = TRUE)
dtSubdataset
## Reorder the columns (in order of key)
dtSubDataset <- dtSubDataset[, c(2:4, 1, 6, 5), with=FALSE]
## set the key
setkey(dtSubDataset, Subject, ActivityNum, ActivityName, FeatureCode, FeatureName)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dtTidyDataset <- dtSubDataset[, list(Average = mean(value)), by = key(dtSubDataset)]
