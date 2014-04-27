# Download and unzip the original dataset
# It was not immediately clear whether this step is required or not for the assignment
# It is probably a good idea to pass the URL as a parameter,  instead of hard coding it here
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="original.zip")
unzip("original.zip")
unlink("original.zip")

## go to the directory where the actual datai is
setwd("UCI HAR Dataset")

## It is assumed that the libraries required to process this script are already
## installed in the R environment
library(stringr)

# read features and get the features we want and process these features to improve
# readability
originalfeatures = readLines("features.txt")
featureswanted = grepl("mean\\(\\)|std\\(\\)", originalfeatures, ignore.case=TRUE)
newfeatures = tolower(str_trim(originalfeatures[featureswanted]))
newfeatures = gsub("^[0-9]* ", "", newfeatures)
newfeatures = gsub("\\(\\)", "", newfeatures)
newfeatures = gsub("-", "_", newfeatures)

featuremappings = data.frame(newfeatures,originalfeatures[featureswanted])
write.csv(featuremappings, file="../feature_mappings.csv")

# instead of reading all the dataset into memory,  filter in only the variables needed.
# create a classes column to filter out the fields we are not interested in
featureclasses = lapply(featureswanted, function(x) if (x) "numeric" else NULL)

# to convert the activities in the test data according to the mappings in
# activities_labels.txt
anames = read.table("activity_labels.txt")
activitylevels = anames[,1]
activitylabels = tolower(anames[,2])

## read the data from training
straindata = read.table("./train/subject_train.txt", col.names=c("subject"))
ytraindata = read.table("./train/y_train.txt", col.names=c("activity"))
xtraindata = read.table("./train/x_train.txt", col.names=originalfeatures, colClasses=featureclasses)

# change column names to the new ones and add subject, activity columens
# there was no explicit requirement to add the test type, but it may be a good idea to
# add that piece of data
colnames(xtraindata) = newfeatures
xtraindata$subject = straindata$subject
xtraindata$activity = factor(ytraindata$activity, levels=activitylevels, labels=activitylabels)

## read the data from test
stestdata = read.table("./test/subject_test.txt", col.names=c("subject"))
ytestdata = read.table("./test/y_test.txt", col.names=c("activity"))
xtestdata = read.table("./test/x_test.txt", col.names=originalfeatures, colClasses=featureclasses)

# change column names to the new ones and add subject, activity columens
# there was no explicit requirement to add the test type, but it may be a good idea to
# add that piece of data
colnames(xtestdata) = newfeatures
xtestdata$subject = stestdata$subject
xtestdata$activity = factor(ytestdata$activity, levels=activitylevels, labels=activitylabels)

# merge the data
xdata = rbind(xtraindata, xtestdata)

# aggregate the results
result = aggregate(xdata, list(subject.group=xdata$subject, activity.group=xdata$activity), mean)

# drop the subject and activity columns as this data is repeated in
# subject.group and activity.group columns
# There is probably a better way to do this.
result = result[,c("subject.group", "activity.group", newfeatures)]
write.csv(result, "../tidy_data.csv")
