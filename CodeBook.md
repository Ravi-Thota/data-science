Analysis of a Human Activity Recogintion experiment
========================================================

This codebook describes the data analysis done on the dataset made available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
This [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) provides more information about the experiment.

Understanding the data
--------------------------------------------------------
Download the zip file and unzip the file in the directory that contains the run_analysis.R script. Quick look at the files made it clear that
* Data sets test and train are similar data sets with observations from the same experiment done a different subjects
* There are 30 subjects identified by integer values 1:30
* subjects_*.txt lists the subjects by the obervations totaling in  

 
This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(cars)
```

