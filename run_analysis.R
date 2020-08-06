### retriving the data and putting it in a folder called data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

### unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

### retrieving the list of unzipped files
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

### Reading the file data and assigning it a variable
### The activity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
### The subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
### The features files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
### Use the str command on each object to see the table details/ summary of the variables 
### the subject is the ID of the person
### the activity is the type of activity (walking, walking upstairs, walking downstairs,
### sitting, standing and laying)



### Merge the training and test data sets according to row using rbind
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
### give names to the variables 
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
### Combine the activity, subject and features data by column to get one single data frame (Data)
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

### Extract the mean and std data from FeaturesNames
extractFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
### Extract selected names (subject and activity) of Features from "Data"
selectedNames<-c(as.character(extractFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
###check it out to see if it worked/ what it looks like
str(Data)

### Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

### Give descriptive names to the variable activity in the dataframe using the factors function (make a vector into a factor)
Data$activity<-factor(Data$activity,labels=activityLabels[,2])
### Check that it worked
head(Data$activity,30)

### Give labels to the data set (name of the features) to better describe the variables
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

### Make an independant tidy data set based on the data averages for activity and subject 
library(plyr);
TidyData<-aggregate(. ~subject + activity, Data, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

### To produce a codebook
library(knitr)
knit2html("codebook.Rmd")





