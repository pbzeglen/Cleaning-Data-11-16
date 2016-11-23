#Read in all the data
test <- read.table(file = "Clean data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
train <- read.table(file = "Clean data/UCI HAR Dataset/train/X_train.txt",header = FALSE)
labels <- read.table(file = "Clean data/UCI HAR Dataset/features.txt",header = FALSE) 

#Labels the columns of the setss
names(test) <- labels$V2
names(train) <- labels$V2

#Remove all columns that do not contain "std" or "mean" and delete columns that contain "meanFreq"
std <- grepl(pattern = "std",x = labels$V2)
men <- grepl(pattern = "mean",x = labels$V2)
fre <- !grepl(pattern = "meanFreq",x = labels$V2)
shortTest <- test[,(std | men) & fre]
shortTrain <- train[,(std | men) & fre]


#Read in the subject and action labels
ys <- read.table(file = "Clean data/UCI HAR Dataset/test/y_test.txt",header = FALSE)
ss <- read.table(file = "Clean data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
yr <- read.table(file = "Clean data/UCI HAR Dataset/train/y_train.txt",header = FALSE)
sr <- read.table(file = "Clean data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

#Add the subject and action data as a column to the datasets
shortTrain$subject <- sr$V1
shortTrain$action <- yr$V1
shortTest$subject <- ss$V1
shortTest$action <- ys$V1

#Reorder the columns so that subject and action are firts
shortTest <- shortTest[,c(length(shortTest)-1,length(shortTest),1:(length(shortTest)-2))]
shortTrain <- shortTrain[,c(length(shortTrain)-1,length(shortTrain),1:(length(shortTrain)-2))]

#Substitute the numbers in the action column with descriptive factors
labels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
shortTrain$action <- factor(labels[shortTrain$action])
shortTest$action <- factor(labels[shortTest$action])


#Combine the test and train dataset
combined <- rbind(shortTest,shortTrain)
#Rename variables to "time" instead of "t" and "fast fourier transform" instead of "f"
names(combined) <- gsub("^t","time-",names(combined))
names(combined) <- gsub("^f","fast fourier transform-",names(combined))

#Take the mean of all measurements by subject and action
averageTable <- aggregate(. ~ subject + action, combined,mean)