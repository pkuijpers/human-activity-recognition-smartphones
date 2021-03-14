# CodeBook

## Initial data

The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
velocity at a constant rate of 50Hz. The experiments have been video-recorded 
to label the data manually. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

The data covers 30 persons who are performing 6 activities. For each person
performing an activity, a series of data is generated for the linear 
acceleration and the angular velocity.

The provided data contains the following files:

* `features.txt`: a list of the names of the 561 features.
* `activity_labels.txt`: Links the class labels with their activity name.
* `train/X_train.txt`: Training set.
* `train/y_train.txt`: Training labels.
* `test/X_test.txt`: Test set.
* `test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their
descriptions are equivalent. 

* `train/subject_train.txt`: Each row identifies the subject who performed the
  activity for each window sample. Its range is from 1 to 30. 
* `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from
  the smartphone accelerometer X axis in standard gravity units 'g'. Every row
  shows a 128 element vector. The same description applies for the 
  'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z
  axis. 
* `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal
  obtained by subtracting the gravity from the total acceleration. 
* `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector
  measured by the gyroscope for each window sample. The units are
  radians/second. 

## Loading the data

The data is downloaded to the `data` subdirectory and loaded into the 
environment using the script `load_data.R`. All columns are read as character:
conversion to more appropriate types will be done later. Sensible column headers
are added during the load.
 
The `features` file contains several features with the same name, for example
feature 461 and 475 are both listed as "R read_delim same type for all columns".
To avoid warnings and automatic renaming, the feature number (e.g. 461) is used
for column names, not the feature name.

The data in the Inertial Signals subdirectories doesn't seem to be needed for
the analysis of this assignment, so it isn't loaded.

## Tidying the data

In the script `run_analysis.R` the following operations are performed to tidy
up the data:

1. Combine the subject, x and y tables into a single table: `train_all` and
   `test_all`
2. Combine the test and train tables to a single table `all_data`.
3. Only select the measurements on the mean and standard deviation and add the
   activity name. For this, the feature names are filtered with a regular
   expression that matches 'std' or 'mean' followed by a '('. This matches
   for example "tBodyAcc-mean()-X", but not "fBodyAcc-meanFreq()-X" which seems
   to be right.
4. Convert columns to the appropriate type (factor and double).
5. Replace the  column names that contain a number with the corresponding
   feature name. The '(', ')' and '-' characters that are included in the 
   feature name are removed.
   
The last step of the script groups the data for subject and activity label, and
calculates the average of every feature. The results are saved to a table
called `averages`.