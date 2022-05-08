## This is a code script for the Assignment, to merge and tidy a training and test data set for Samsung
## first, import the 2 text files, training and test (.txt), along with:

  ## activity labels (numbers 1 through 6 corresponding to walking, sitting, standing, etc)
  ## Y_train and Y_test (numbers 1 through 6)
  ## and the features.txt file (which is the colummn headers)

library(dplyr, tidyr)

## first reading in the 2 files, and the activity_labels
X_train <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
View(X_train)

X_test <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
View(X_test)

activity_labels <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
View(activity_labels)

## this code reads in the Y_train and Y_test, which contain lists of the activity labels (numbers 1 through 6)
Y_train <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
View(Y_train)

Y_test <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
View(Y_test)

subject_train <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
View(subject_train)

subject_test <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
View(subject_test)

## this reads in the features data frame of column headings
features <- read.table("~/RStudio/datasciencecoursera/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
View(features)

## this section binds the subject_train and subject_test columns (of numbers 1 through 30 participants) as first row
X_train2 <- cbind(subject_train, X_train)
colnames(X_train2)[1] <- "Subject"
View(X_train2)

X_test2 <- cbind(subject_test, X_test)
colnames(X_test2)[1] <- "Subject"
View(X_test2)

## this section binds the Y_train and Y_test columns (of numbers 1 through 6) as the first row of each of X_train and X_test
X_train3 <- cbind(Y_train, X_train2)
colnames(X_train3)[1] <- "ActivityLabel"
View(X_train3)

X_test3 <- cbind(Y_test, X_test2)
colnames(X_test3)[1] <- "ActivityLabel"
View(X_test3)

## this code reads the feature list into a vector after adding the column 1 label for activity labels
## and contains character labels for the 561 columns of data from both X_train and X_test
vector_train <- c("1", "Subject")
View(vector_train)
features2 <- rbind(vector_train, features)
View(features2)

vector_train2 <- c("1", "ActivityLabel")
View(vector_train2)
features3 <- rbind(vector_train2, features2)
View(features3)

feature_list <- features3[, "V2"]
View(feature_list)

## make the 'feature_list' the column heading for both X_test2 and X_train2
colnames(X_test3) <- feature_list
colnames(X_train3) <- feature_list

## join the 2 data sets using rbind
X_train_test <- rbind(X_test3, X_train3)
View(X_train_test)

## extract columns with mean and SD for each measurement and keeps the firset column about ActivityLabel
X_train_test2 <- select(X_train_test, matches("mean|std|ActivityLabel|Subject"))
View(X_train_test2)

## make the first 2 columns into factors
## then changes names for 'activityllabel' into the 6 Activity Labels in the txt file
X_train_test2$ActivityLabel <- as.factor(X_train_test2$ActivityLabel)
X_train_test2$Subject <- as.factor(X_train_test2$Subject)
str(X_train_test2)

levels(X_train_test2$ActivityLabel)[1] <- 'WALKING'
levels(X_train_test2$ActivityLabel)[2] <- 'WALKING_UPSTAIRS'
levels(X_train_test2$ActivityLabel)[3] <- 'WALKING_DOWNSTAIRS'
levels(X_train_test2$ActivityLabel)[4] <- 'SITTING'
levels(X_train_test2$ActivityLabel)[5] <- 'STANDING'
levels(X_train_test2$ActivityLabel)[6] <- 'LAYING'

View(X_train_test2)
glimpse(X_train_test2)
## done through question #4

## question 5 - finding the average from this dataset in a new tidy table
## for each level both subject and activity level

Means_by_Activity <- X_train_test2 %>% 
    group_by(ActivityLabel) %>%
    select(-Subject) %>%
    summarise(across(everything(), list(mean)))
View(Means_by_Activity)

Means_by_Subj <- X_train_test2 %>% 
  group_by(Subject) %>%
  select(-ActivityLabel) %>%
  summarise(across(everything(), list(mean)))
View(Means_by_Subj)

Means_by_Subj_Act <- X_train_test2 %>% 
  group_by(Subject, ActivityLabel) %>%
  summarise(across(everything(), list(mean)))
View(Means_by_Subj_Act)

## done with assignment

write.table(Means_by_Subj_Act, file = "~/RStudio/datasciencecoursera/UCI HAR Dataset/output-table", row.names = FALSE)

