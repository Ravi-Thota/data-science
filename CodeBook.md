Tidying the data from of a Human Activity Recogintion experiment
========================================================

This codebook describes the process in which tidy data is generated from the dataset made available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This tidy data contains only the mean and standard deviations of each of the measures that were receorded

This [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) provides more information about the experiment.

Understanding the data
--------------------------------------------------------
Quick look at the data downloaded and unzipped made it clear that

* Features are the measurements from the experiment and they are enumerated in features.txt file
* There are 561 measurements that were summarized in the final data sets
* Only a subset of these measures are to be included in the final tidy data set
* Observations are also categorized by activities of the subjects during the measurement
* Activites are listed in the activity_labels.txt file as mappings from an integer to a label
* Summary data sets test and train are similar data sets with observations from the same experiment done a different subjects
* Datasets span across 3 different files with 
 * subject_ files listing the subject of the measurement
 * y_ files listing the activity category of the measturement
 * x_ files that have the feature measurements
* Data is clean with no missing values are misalignments between the different data set fragments

Reshaping the data
---------------------------

### Features
* Features are read from the **features.txt**.
* Since we are interested only in the means and standard deviations,  featues filtered using the regular expression **mean()|std()**.  This regular expression keeps varialbes lile meanFreq and angle(y, gravitymean) out of the final dataset as they are not to be part of the tidy data set
* Feature from the original dataset are reshaped to improve the readability of the variable names
 * All the capital letters in the variable names are reduced to lowercase.
 * Leading digits in the variabled names (presumably the digits indicate the position of the variable) and the parantesis are removed
 * All hyphens are converted to underscores
 * A mapping file **feature_mappings.txt** is created to map the reshaped feature names to the featurenames from the original data set in CSV format
 
### Activities
* activities are read in from **activity_labels.txt** as levels and labels to factorize the activity data in the observations

### Observations
* training category observations are read from **subject_train.txt**, **y_train.txt** and **x_train.txt** files
* test category observations are read from **subject_test.txt**, **y_test.txt** and **x_test.txt** files
* activites are factorized using the activity labels
* subjects are factorized as well into 30 categories
* traing and test are added as categories to preserve this information
* both data sets are merged row wise using rbind
* all measurements are summarized by their means by subject and activity using aggregate function

 
This tidy data set is written back to a file **tidy_data.csv**
This tidy data will have all the features listed in the feature_mappings.csv file and two columns "subject.group" and "activity.group"