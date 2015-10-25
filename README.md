# getting_and_cleaning_data_course_project

The script run_analysis.r basically does the following things:

1. It downloads the data for the project from the given URL.
2. It unzips the downloaded data and saves it in your working directory in a folder called "project_data"
3. It reads in the relevant files using read.table
4. It combines all the test data together using cbind, cleaning up and giving appropriate column names as needed.
5. It combines all the training data together using cbind, cleaning up and giving appropriate column names as needed.
5. It combines the cleaned test data with the cleaned training data, using rbind, to create combined_test_data_and_training_data.
6. It merges this with activity_labels, to create combined_test_data_and_training_data_with_activity_labels.  
7. It searches the features data frame for the rows which contain the phrases "mean()" or "std()", and records the column labels that have either mean() or std() within them as features_with_mean_or_std.
8. I union a list of all the columns we want to keep (the label columns, and the measurement columns from features_with_mean_or_std).
9. I use this list to extract only these columns and save the results as mean_and_std_extract_data.
10. I label the column names of mean_and_std_extract data using a for loop.
11. I drop non-essential columns, and make sure subjectID is a factor.
12. I aggregate and calculate the means for each variable using the aggregate function.
13. I write the results of the means for each variable of interest out to a CSV file.
