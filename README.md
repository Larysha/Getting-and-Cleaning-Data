# Getting-and-Cleaning-Data

### Course project for Coursera - Getting and Cleaning Data. Code in run_analysis.R 

### 1.
### retriving the data from the URL and putting it in a folder called data, which will be created if it does not yet exist
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

### unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

### 2.
### retrieving the list of unzipped files in UCI HAR Dataset


### 3.
### Reading the file data and assigning it a variable
### Do this for:

### - The activity files (test and train)
### - The subject files (test and train)
### - The features files (test and train)

### Use the str command on each object to see the table details/ summary of the variables 
### the subject is the ID of the person
### the activity is the type of activity (walking, walking upstairs, walking downstairs,
### sitting, standing and laying)

### 4. 
### Merge the training and test data sets according to row using rbind and assign to a new object.

### give names to the variables 
### Combine the activity, subject and features data by column to get one single data frame (Data)


### 5.
### Extract the mean and std data from FeaturesNames

### Extract selected names (subject and activity) of Features from "Data"
### Uses descriptive activity names to name the activities in the data set

### 6.
### Give descriptive names to the variable activity in the dataframe using the factors function (make a vector into a factor)
### Check that it worked

### 7.
### Give labels to the data set (name of the features) to better describe the variables

### 8.
### Make an independant tidy data set based on the data averages for activity and subject (tidydata.txt) 


### To produce a codebook
library(knitr)
knit2html("codebook.Rmd")

