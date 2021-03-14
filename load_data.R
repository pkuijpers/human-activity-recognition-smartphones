if (!dir.exists("./data")) {
	dir.create("./data")
}

library(utils)
filename <- "./data/dataset.zip"
if (!file.exists(filename)) {
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
		      destfile = filename)
	unzip(filename, exdir = "./data")
}

library(readr)
features <- read_delim("./data/UCI HAR Dataset/features.txt", " ",
		       col_names = c("number", "name"))
activity_labels <- read_delim("./data/UCI HAR Dataset/activity_labels.txt", " ",
		       col_names = c("label", "activity"))

x_train <- read_delim("./data/UCI HAR Dataset/train/X_train.txt", " ", 
		      col_names = as.character(features$number),
		      col_types = cols(.default = col_character()))

x_test <- read_delim("./data/UCI HAR Dataset/test/X_test.txt", " ", 
		      col_names = as.character(features$number),
		      col_types = cols(.default = col_character()))

y_train <- read_delim("./data/UCI HAR Dataset/train/y_train.txt", " ", 
		      col_names = c("label")) 

y_test <- read_delim("./data/UCI HAR Dataset/test/y_test.txt", " ",
		      col_names = c("label")) 

subject_train <- read_delim("./data/UCI HAR Dataset/train/subject_train.txt", " ",
		      col_names = c("subject")) 

subject_test <- read_delim("./data/UCI HAR Dataset/test/subject_test.txt", " ",
		      col_names = c("subject")) 
