## Clear the workspace
rm(list = ls())

## Set appropriate working directory
# setwd("/home/user/Documents/R/UCI HAR Programming Assignment")

## 1 - Merge the training and the test sets to create one data set.

# Read and merge all train data
mydata0 <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
mydata1 <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
mydata2 <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
train   <- cbind(mydata0, mydata2, mydata1)
colnames(train)[1:2] = c("ID","Activity")

# Read and merge all test data
mydata0 <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
mydata1 <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
mydata2 <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
test    <- cbind(mydata0, mydata2, mydata1)
colnames(test)[1:2] = c("ID","Activity")

# Merge train and test data
dataset <- rbind(train,test)

# Create readable names for variables
feat <- read.table(file = "./UCI HAR Dataset/features.txt");
feat <- feat[,2]
feat <- gsub("-", "_", feat)
feat <- gsub("\\(\\)", "", feat)
feat <- gsub("\\(", "_", feat)
feat <- gsub("\\)", "", feat)
feat <- gsub("\\,", "_", feat)
# colnames(dataset)[3:(length(feat)+2)] <- as.character(feat);

## 2 - Extract only the measurements on the mean and standard deviation for each measurement. 

# Go through the variable names and look for names that include one of the following: 
# "mean","Mean","std","Std"
ind_log <- vector(mode="numeric", length=length(feat))
for (i in 1:length(feat)){
      var         <- as.character(feat[i])
      ind_log[i]  <- grep("mean",var) || grep("Mean",var) || grep("std",var) || grep("Std",var)
}
subset_ind <- !is.na(ind_log)
subset_feat <- feat[subset_ind]
data <- dataset[,subset_ind]


## 3 Uses descriptive activity names to name the activities in the data set
activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
dataset$Activity <- factor(dataset$Activity, labels = activities)

## 4 Appropriately labels the data set with descriptive variable names. 
colnames(data)[3:(length(subset_feat)+2)] <- as.character(subset_feat);

## 5 From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
# This comment helped me:
# Each user has performed a number of activities. 
# That is, you should group by user and by activities and calculate 
# the average of each variable for each group.  
# I add an extra column which can serve as a factor denoting the corresponding variable.

if (file.exists("OutputData.txt")){
  file.remove("OutputData.txt")
}  
print("Writing in the text file:")
header = c(activities,"variable")
write(x=t(header), file="OutputData.txt", ncolumns = 7, append = TRUE, sep = " ")  
variables_range <- 3:(length(colnames(data)))
for (i in variables_range){
  real_name = colnames(data)[i] 
  colnames(data)[i] = "X"
  data_out = xtabs(X~ID + Activity,aggregate(X~ID + Activity,data,mean))
  colnames(data)[i] = real_name
  print(paste(i,": ",real_name, sep = ""))
  #   comment <- paste("Average of varaiable ",var_name,": ID(rows) vs. Activity(columns)",sep = "")
  #   write(comment, "OutputData", append = TRUE, sep = " ")
  data_out <- cbind(data_out,rep(i-2,nrow(data_out)))
  write(x=t(data_out), file="OutputData.txt", ncolumns = 7, append = TRUE, sep = " ")  
}

# Alternative:
# data_out <- aggregate(data[, 3:dim(data)[2]], list(data$ID,data$Activity),mean)
# write(x=t(data_out), file="OutputData.txt", ncolumns = 6, append = TRUE, sep = " ")  

## Write the output variables names in a separate file
if (file.exists("OutputVariables.txt")){
  file.remove("OutputVariables.txt")
}  
subset_feat_for_txt <- paste(c(1:length(subset_feat)),subset_feat)
write(x=t(subset_feat_for_txt), file="OutputVariables.txt", ncolumns = 1, append = TRUE, sep = " ") 

## Read data
data_tidy <- read.table(file = "./OutputData.txt", header = TRUE)
data_tidy$variable<-factor(data_tidy$variable)