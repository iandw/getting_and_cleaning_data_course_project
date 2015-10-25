Codebook

This codebook describes the variables, data, and transformations you performed to clean up the data.

The script run_analysis.R does the following transformations to clean up the data:
1. It checks if the needed data is in your working directory in a file called course_project_dataset.zip.
2. If it isn't already there, it downloads and unzips the needed data to your current working directory to a folder called project_data.
3. It reads in all the relevant unzipped files (ignoring the inertial signals files, since those aren't used).  It does this via multiple read.table commands.
4. It combines the test data with its labels (y_test, X_test) using cbind to create "test_data".
5. It combines the training data with its labels (y_train, X_train) using cbind to create "training_data".
6. It combines test_data and training_data via rbind to create "combined_test_data_and_training_data".
7. It merges with activity_labels to create "combined_test_data_and_training_data_with_activity_labels", using the ActivityID as the join key.
8. Now we need to label the unlabelled columns of combined_test_data_and_training_data_with_activity_labels.  To do this, we get the column names from the features data frame using a for loop.
9. Then it searches for which of the labels contain "mean()" or "std()".  It saves this as a vector called features_with_mean_or_std.
10. Then, I generate a list of columns to keep (i.e. label columns PLUS columns containing mean() or std()), and then we use this to extract only these columns and save the results as mean_and_std_extract_data.
11. I convert SubjectID from integer to factor.
12. I aggregate and calculate the means for each variable of interest (anything with mean() or std() in its name) using the aggregate function, and the results get saved as "averages_by_subject_and_activity".
13. Lastly, I write out the results.


Key Variable Definitions in the final result: averages_by_subject_and_activity
1. Activity - a factor from 1 to 6 which refers to which activity the subject was doing
  1 - WALKING
  2 - WALKING UUPSTAIRS
  3 - WALKING DOWNSTAIRS
  4 - SITTING
  5 - STANDING
  6 - LAYING

2. SUBJECT ID - a factor from 1 to 30 identifying the subject who the observation is from.
Columns 3 - 68 - the column name definitions for these can be found in the features_info.txt and the features.txt file given in the original data URL for the project.  

