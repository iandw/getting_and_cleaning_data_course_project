# getting_and_cleaning_data_course_project

* The script that performs the analysis is saved in this repo as run_analysis.R
* The codebook has a description of the variable definitions in the final output "averages_by_subject_and_activity".  The codebook is saved as codebook.md.

Outline of How the run_analysis.R Script Works:
* Sets working directory.
* Checks if the zip file exists in working directory or not.
*   If it doesn't, it downloads and unzips the zipped file from the URL.
* It reads in the relvant files from the directory (the files in the Inertial Signals folder are not needed, so they are not read in).  These files are read in using read.table() commands.
* I label the new data frames with appropriate column names (for example, y_test and y_train both get labeled with column name "SubjectID" because they are the subject factor variable (ranging from 1 to 30), and subject_test and subject_train get labeled with column name "ActivityID" because they are the activity factor variable (ranging from 1 to 6).
* I cbind the test data together (y_test and X_test) so the data has its appropriate labels. (I also add a non-essential label called data_type to denote all these rows come from the test set). The result is test_data.
* I cbind the training data together in the same way (y_train and X_train).  (I also add a non-essential label called data_type to denote all these rows come from the training set).  The result is training_data.
* Now that test_data and training_data have same column names, we can rbind them together to produce combined_test_data_and_training_data.
* Next I merge combined_test_data_and_training_data with activity_labels using the "ActivityID" column to get descriptive version of the activity the subject is performing.  The result is combined_test_data_and_training_data_with_activity_labels.
* Next I go through the features data frame (which has the 561 variables for which each observation was recorded on).  I use str_detect to get a list of which of these features contain "mean()" or "std()" in their feature name.  I save this list as features_with_mean_or_std.
* I put together a list of columns we want to keep - basically the union of features_with_mean_or_std and the columns with observation labels ("ActivityID", "Activity", "SubjectID", "Data Type").  
* I label combined_test_data_and_training_data_with_activity_labels with descriptive names using a for loop on the features$V2 vector.
* I extract only the label columns and columns with mean or std in the name and save this as mean_and_std_extract_data (using the unioned list created earlier).
* I use the aggregate command to calculate the mean by subject and activity for the variables with mean() or std() in the title, and save the results as averages_by_subject_and_activity.
* Lastly, I write the data frame averages_by_subject_and_activity to a file.
