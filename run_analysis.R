# read txt data into R
xtest <- read.table(file= "./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table(file= "./UCI HAR Dataset/test/y_test.txt")
xtrain <-read.table(file= "./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table(file= "./UCI HAR Dataset/train/y_train.txt")
act_labels <- read.table(file= "./UCI HAR Dataset/activity_labels.txt") 
features <- read.table(file= "./UCI HAR Dataset/features.txt")   #colnames for the activities
subject_train <- read.table(file= "./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
subject_test <- read.table(file= "./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

#create dataframe with labels and activity names for test data sets
ytest2 <- merge(ytest,act_labels, by = "V1")
colnames(ytest2) <- c("actv_label","act_name")
colnames(xtest) <- features$V2
xtest2 <- xtest[,1:6]
test_df <- cbind(subject_test,ytest2,xtest2)

#create dataframe with labels and activity names for training data sets
ytrain2 <- merge(ytrain,act_labels, by = "V1")
colnames(ytrain2) <- c("actv_label","act_name")
colnames(xtrain) <- features$V2
xtrain2 <- xtrain[,1:6]
train_df <- cbind(subject_train,ytrain2,xtrain2)

#merge test and training sets to create one data set
final_df <- rbind(test_df,train_df)

#convert column vectors to numeric in order to get quantitative summary
final_df$meanX <- as.numeric(as.character(final_df$`tBodyAcc-mean()-X`))
final_df$meanY <- as.numeric(as.character(final_df$`tBodyAcc-mean()-Y`))
final_df$meanZ <- as.numeric(as.character(final_df$`tBodyAcc-mean()-Z`))
final_df$meanstdX <- as.numeric(as.character(final_df$`tBodyAcc-std()-X`))
final_df$meanstdY <- as.numeric(as.character(final_df$`tBodyAcc-std()-Y`))
final_df$meanstdZ <- as.numeric(as.character(final_df$`tBodyAcc-std()-Z`))

#summarize subject by activity observations using group by
subject_grouped <- group_by(final_df,Subject, act_name)
summary_step5 <- summarize(subject_grouped, 
                           tBodyAcc_mean_X = mean(meanX, na.rm=TRUE),
                           tBodyAcc_mean_Y = mean(meanY, na.rm=TRUE),
                           tBodyAcc_mean_Z = mean(meanZ, na.rm=TRUE),
                           tBodyAcc_mean_std_X = mean(meanstdX, na.rm=TRUE),
                           tBodyAcc_mean_std_Y = mean(meanstdY, na.rm=TRUE),
                           tBodyAcc_mean_std_Z = mean(meanstdZ, na.rm=TRUE))

#write dataset out to txt
write.table(summary_step5, file = "tidy_data.txt", row.names = FALSE)
