The input data for this assignment is the data in folder UCI HAR Dataset, subfolders Train and Test (without Inertial folders).
The details on the input data are given in the README.txt file in the UCI HAR Dataset folder. 

This CodeBook provides the information on processing the input data.

Data was proccessed according to following steps:

1 - Merge the training and the test sets to create one data set.
2 - Extract only the measurements on the mean and standard deviation for each measurement. 
3 - Use descriptive activity names to name the activities in the data set
4 - Appropriately label the data set with descriptive variable names. 
5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Explanation of each step (as it was coded in the run_analysis.R script):

1 - The data from the training and test set is described with person ID (1-30), Activity label(1-6) and the 561 variables measured during these activites. Original names of these variables are listed in features.txt in the UCI HAR Dataset folder. The described data from the training and test set was read separately from the belonging files and then merged into one dataset.

2 - The original variable names are listed in features.txt file. In each name I looked for the string "mean","Mean","std"or "Std", which means that the variable annotates the mean or standard deviation of the measurement. 
If the name contains one of these strings (TRUE/FALSE) this will serve as a the logical indexing to subset the data.
Ie. the new data contains only the measurements on the mean and standard deviation for each measurement. 
This resulted in 86 variables for each measurement. .
Also, in this step i looked for characters such as "-", ()", "(", ")", and replaced them with a "_" or "", because otherwise they would be missinterpreted in R. 
I subset the variable names with the same mentioned logical indexes. 
The list of these variables is given in output_variables.txt

3 - Activity labels 1-6 are replaced with the strings describing the corresponding activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

4 - Automaticly, the variable names are "V1",...,"V86". At this point, I substitute these names with the subset of cleaned variable names (listed in output_variables.txt) created at step 2.

5 - Average of a single variable for each activity and each subject is a cross-table (xtab). Since we have 86 variables, we will have 86 xtabs, each xtab being 30x6. Since all xtabs are concatenated, I added an extra column denoting the variable (1-86), with their full names listed in output_variables.txt. Calculated xtabs are saved in a file output_data.txt.

