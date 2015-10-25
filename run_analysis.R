#Set working directory
setwd("C:/Users/Katelyn/Documents")

#If the zip file doesn't already exist in the current working directory, 
#then download it and unzip the files into the working directory into a folder
if (!file.exists("./course_project_dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile="./course_project_dataset.zip")
  
  unzip("./course_project_dataset.zip", files=NULL, list=FALSE, overwrite=TRUE, exdir="./project_data")
}
#Read in the relevant files (don't need to read in the files in the Inertial Signals folders)
subject_test <- read.table("./project_data/UCI HAR Dataset/test/subject_test.txt")

X_test <- read.table("./project_data/UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./project_data/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./project_data/UCI HAR Dataset/train/subject_train.txt")

X_train <- read.table("./project_data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./project_data/UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("./project_data/UCI HAR Dataset/activity_labels.txt")

features <- read.table("./project_data/UCI HAR Dataset/features.txt")

#Label the columns
colnames(activity_labels) <- c("ActivityID", "Activity")
colnames(y_test) <- c("ActivityID")
colnames(subject_test) <- c("SubjectID")
colnames(y_train) <- c("ActivityID")
colnames(subject_train) <- c("SubjectID")

#Add flags labelling the test data and the train data, so you can differentiate if needed once merged together
subject_test_with_data_type_flag <- subject_test
subject_train_with_data_type_flag <- subject_train

subject_test_with_data_type_flag$data_type <- "Test Data"
subject_train_with_data_type_flag$data_type <- "Train Data"

#Merge the training data with the test data 
#First put together all the test data
test_data <- cbind(y_test, subject_test_with_data_type_flag, X_test)

#Second put together all the training data
training_data <- cbind(y_train, subject_train_with_data_type_flag, X_train)

#Finally, merge the training data and the test data
combined_test_data_and_training_data <- rbind(test_data, training_data)

##Use descriptive activity names to name the activities in the data set.
combined_test_data_and_training_data_with_activity_labels <- merge(combined_test_data_and_training_data, activity_labels,
      by=c("ActivityID"),
      all=TRUE)

#Clean up workspace
rm(combined_test_data_and_training_data)

#Load the stringr library so you can use str_detect
library(stringr)

##Extract the measurements on the mean and standard deviation for each measurement#############
features_with_mean_or_std <- 
  features[str_detect(features[,2], fixed("mean()", ignore_case=FALSE)) | 
             str_detect(features[,2], fixed("std()", ignore_case=FALSE)),]

#Extract the columns of interest from combined_test_data_and_training_data_with_activity_labels
names_of_label_columns_to_keep <- c("ActivityID", "Activity","SubjectID","data_type")
names_of_measurement_columns_to_keep <- as.character(features_with_mean_or_std$V2)
unioned_list_of_cols_to_keep <- union(names_of_label_columns_to_keep, names_of_measurement_columns_to_keep)

#Label the data set with descriptive variable names.
#To do this, just use the names from features to name the columns in combined_test_data_and_training_data_with_activity_labels
for(i in 4:564){
  names(combined_test_data_and_training_data_with_activity_labels)[i]<-as.character(features$V2)[(i-3)]
}

mean_and_std_extract_data <- combined_test_data_and_training_data_with_activity_labels[, unioned_list_of_cols_to_keep] 

#Drop non-essential columns from mean_and_std_extract_data
mean_and_std_extract_data <- mean_and_std_extract_data[ ,-c(1,4)]

#Make sure SubjectID is treated as a factor
mean_and_std_extract_data$SubjectID <- as.factor(mean_and_std_extract_data$SubjectID)

#Using the data set from step 4, create a second, independent tidy data set
#with the average of each variable for each activity and each subject.
averages_by_subject_and_activity <- aggregate(mean_and_std_extract_data[, 3:68],
                                              as.list(mean_and_std_extract_data[,1:2]),
                                              FUN=mean)

#Write the results out as a .txt file using write.table() with row.name=FALSE
filename = "./Averages by Subject and Activity for Test and Training Data Combined.txt"
write.table(averages_by_subject_and_activity, filename, row.names=FALSE)
