Tidy data from Human Activity Recognition Dataset
========================================================

run_analysis.R script in this folder processes the data collected in an experiment to collect the Human Activity Recognition Using Smartphones Dataset.

This script will download and unzip the original dataset from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This script does not require any inputs.  Running this script generates two files in the same folder as the run_analysis.R.  These files are in CSV format

* **feature_mappings.txt** to map the features we are interested are mapped from the processed feature names to those in the original data
* **tidy_data.txt** that contains the final tidy data