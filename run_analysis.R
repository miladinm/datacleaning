library(dplyr)

# Load data into tables
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
training <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Load features and convert into proper names to remove special characters - and () that cause issues in downstream operations
features <- read.table("./UCI HAR Dataset/features.txt")
features$V2 <- make.names(features$V2, unique = TRUE)

# Load activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")


## Set variable names for measurements based on the features provided
colnames(test) <- features$V2
colnames(training) <- features$V2

## Add references to activity label into test and training datasets
test <- cbind (test, y_test) 
training <- cbind (training, y_train) 

# Add subject and rename the column names to keep unique and different from V1
subject_test <- rename(subject_test, subject=V1)
subject_train <- rename(subject_train, subject=V1)
test <- cbind (test, subject_test)
training <- cbind (training, subject_train) 

## Merge the activity labels with data
test <- merge(test, activity_labels, by = "V1", all = TRUE)
training <- merge(training, activity_labels, by = "V1", all = TRUE)

# Rename activity column name
test <- rename(test, activity=V2)
training <- rename(training, activity=V2)

# Select only activity, subject, mean and std columns
test <- select(test, contains("activity"), contains("subject"), contains("mean"), contains("std"))
training <- select(training, contains("activity"), contains("subject"), contains("mean"), contains("std"))

# Add the test and training datasets together
final <- rbind(test, training)

# Get average of each variable for each activity and subject
final_grouped <- (final %>%
                  group_by(subject,activity) %>%
                  summarise_each(funs(mean)))
