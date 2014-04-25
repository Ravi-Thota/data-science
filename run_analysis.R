# Download data
setwd("C:/work/projects/data-science/cleaning-data/assignment/UCI Har Dataset")

## Create a method that checks to see if a required package is installed or not
## and installs it if necessary.  It is not unreasonable to expect the required
## packages to be installed, but this is a good way to learn

## installed package needs to be loaded in to the workspace separately using library
installpkg = function(pkg) {
  if (!(pkg %in% installed.packages()[,1])) {
    message(paste(c("Package ", pkg, " is not installed.  Installing it...")))
    install.packages(pkg)
  }
}

## First read the column names for the datasets
library(stringr)
featurenames = tolower(str_trim(readLines("features.txt")))

# instead of reading all the dataset into memory,  filter in only the
# variables needed suggested in this thread
# https://class.coursera.org/getdata-002/forum/thread?thread_id=355
#
# fields we are interested
featurenameswanted = featurenames[grep("mean|std", featurenames, ignore.case=TRUE)]
featureswanted = grepl("mean|std", featurenames, ignore.case=TRUE)

# create a classes column to filter out the fields we are not interested in
featureclasses = lapply(featureswanted, function(x) if (x) "numeric" else NULL)
# to convert the activities in the test data according to the mappings in
# activities_labels.txt
anames = read.table("activity_labels.txt")
activitylevels = anames[,2]
activitylabels = tolower(anames[,2])

## read the data from training
straindata = read.table("./train/subject_train.txt", col.names=c("subject"))
ytraindata = read.table("./train/y_train.txt", col.names=c("activity"))
xtraindata = read.table("./train/x_train.txt", col.names=featurenames, colClasses=featureclasses)
xtraindata$subject = straindata$subject
xtraindata$activity = factor(ytraindata$activity, levels=activitylevels, labels=activitylabels)

## read the data from test
stestdata = read.table("./test/subject_test.txt", col.names=c("subject"))
ytestdata = read.table("./test/y_test.txt", col.names=c("activity"))
xtestdata = read.table("./test/x_test.txt", col.names=featurenames, colClasses=featureclasses)
xtestdata$subject = stestdata$subject
xtestdata$activity = factor(ytestdata$activity, levels=activitylevels, labels=activitylabels)

xdata = rbind(xtraindata, xtestdata)
xdata

