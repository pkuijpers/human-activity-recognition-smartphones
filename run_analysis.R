library(dplyr)

# Combine the subject, x and y tables into one table
train_all <- bind_cols(subject_train, y_train, x_train)
test_all <- bind_cols(subject_test, y_test, x_test)

# Combine test and train data in one table
all_data <- bind_rows(train_all, test_all)

# Only select the measurements on the mean and standard deviation and add 
# activity name
interesting_features <-features[grep("(mean|std)\\(", features$name),]
colnames <- as.character(pull(interesting_features, number))
selected_features <- 
	select(all_data, all_of(c("subject", "label", colnames))) %>%
	left_join(activity_labels)
 
# Use appropriate types (factor and numeric) and set column names
typed_data <- selected_features %>%
	mutate_at(colnames, as.numeric) %>%
	mutate_at(c("subject", "label", "activity"), as.factor)
	
# Set column names
interesting_features <- mutate(interesting_features, 
			       colname = gsub("[()-]", "", name))
named_data <- typed_data %>%
	rename_with( ~ interesting_features$colname[which(colnames == .x)],
		     .cols = colnames)

# Calculate averages
averages <- named_data %>%
	group_by(subject, activity)  %>%
	summarize(across(tBodyAccmeanX:fBodyBodyGyroJerkMagstd, mean))
		  