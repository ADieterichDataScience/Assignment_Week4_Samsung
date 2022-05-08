# Assignment_Week4_Samsung
this is the data for assignment 4 - Samsung data table

## READ ME 

This is a readme.txt file for the assignment

The UCI HAR Dataset folder contains 'test' and 'train' subfolders
These folders contains .txt files of data

The UCI HAR Dataset folder also contains files for activity labels, and the subjects (Y_train, etc)

First I read it each .txt file using read.table()

Then I appended the X_train and X_test files with the Y_train and Y_test files
Then added the 'ActivityLabel' column

I changed all the headings with the column of names also provided in the folder

I extracted all using a string function that had 'mean' or 'std'

I made the Subject and ActivityLabel columns into factors, and changed the labels from numbers to words
Example, 1 became "Walking", etc

Lastly, I took the means of each coumn after grouping by activity, by subject, and by both
