The objective of this project was to prepare tidy data that can be used for later analysis. 

First, all data was loaded into tables using read.table method. 
Dimensionality of loaded tables helped in determining how tables are related to one another.

Features containing descriptive names for measurements were loaded into features table. 
Using make.names, the feature names were converted into proper names to remove special characters '-' and '()' and replace them with '.' 
This was done to prevent issues in downstream operations, such as select().

Features dataset was used to set variable names for measurements. Note that columns should be set prior to any subsetting, to ensure appropriate mapping of feature names to variables.

Activity references were added into test and training datasets using cbind method.

Subject was added and variable renamed in order to keep the column names unique and different from default value of V1.

Activity reference values were then replaced with appropriate descriptive activity labels and V1 column was renamed to 'activity'.

Once all the variables were added and properly referenced, the datasets were subset to select only activity, subject, mean and std columns as per assignment instructions
d
Then the test and training datasets were added together using rbind method

As a final step, the dataset was grouped by activity and subject and the average of all variables was calculated for each activity and each subject.

The tidy data file was then written into a txt file named "run_analysis.txt"
write.table(final_grouped,"./run_analysis.txt",sep=" ",row.name=FALSE) 
