Codebook

Key Variable Definitions in the final result: averages_by_subject_and_activity
* Activity - a factor from 1 to 6 which refers to which activity the subject was doing
  * 1 - WALKING
  * 2 - WALKING UPSTAIRS
  * 3 - WALKING DOWNSTAIRS
  * 4 - SITTING
  * 5 - STANDING
  * 6 - LAYING

* SUBJECT ID - a factor from 1 to 30 identifying the subject who the observation is from.

* The definitions for the other 68 columns containing either mean() or std() can be found in the features_info.txt and the features.txt file given in the original data URL for the project: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".  The x, y, and z refer to the axis the measurement was recorded on. mean() stands for mean value. std() stands for standard deviation.  These files from the URL contain more detailed information on variable units and definitions.
* Essentially, for each of these 68 columns, each row contains the mean of that measurement for the activity and subject in that row.  For example, in row 1, "tBodyAcc-mean()-X" contains the mean of tBodyAcc-mean()-X for the activity of "LAYING" for subject 1.

