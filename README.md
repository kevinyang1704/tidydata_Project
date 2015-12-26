==================================================================
R Script for reading and then creating a tidy dataset based on Samsung wearable computing data
==================================================================
Author: Kevin Yang
==================================================================
1. Download data from 
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Extract the content into your working directory. You should now have a folder named "UCI HAR       Dataset"

3. Run the script from your working directory. The script will:

a. Read the training and test datasets into R along with other files necessary for variable description.

b. Merge training and test sets into one dataframe while retaining only the measurements on the mean and standard deviation for each measurement. Descriptive activity names will also be appended.

c. Variables will be converted to numeric for creating the summary data. We will show the mean for each subject by activity for each variable.

d. A final tidy dataset  ("tidy_data.txt") will be created in the working directory. It will contain header row and show summary mean statistics of: subject by activity by accelerometer values in x,y,z axis. 
  
  
  
  
  
