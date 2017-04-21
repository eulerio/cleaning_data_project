run_analysis <- function(){
	
	#reading in all the useful data
	testX <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
	testy <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
	test_sub <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
	trainX <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
	trainy <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
	train_sub <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
	features <- read.table("./UCI_HAR_Dataset/features.txt")
	
	
	#creating a common column of the test and train subjects, keeping the test above the train
	subject<-c(test_sub$V1,train_sub$V1)
	
	#creating a common column of the activities list from test and train data
	activity<-c(testy$V1,trainy$V1)
	
	#find the names and column numbers for the mean of all measurements using grepl
    mean_names<-features$V2[grepl("mean\\(\\)",features$V2)]
    mean_cols<-features$V1[grepl("mean\\(\\)",features$V2)]
    
    
    #find the names and column numbers for the standard deviations of all measurements
    std_names<-features$V2[grepl("std\\(\\)",features$V2)]
    std_cols<-features$V1[grepl("std\\(\\)",features$V2)]
    
	
	#now we start making the pig_data data frame which will store subject, activity and measurements
	#from both test and train datasets
	#first make a data frame of the subject and their activity columns
	pig_data<-data.frame(subject,activity)
	
	#now start adding columns of the mean and standard deviations of the various measurements
	num_mean <- length(mean_cols)
	#looping over various measurements
	for (i in 1:num_mean){
		
		#making one column of the means of test and train sets
		measurement <- c(testX[,mean_cols[i]],trainX[,mean_cols[i]])
		#adding this to the data frame
		pig_data[,as.character(mean_names[i])] = measurement
		
		#making one column of the standard deviations
		measurement <- c(testX[,std_cols[i]],trainX[,std_cols[i]])
		#adding this to the data frame
		pig_data[,as.character(std_names[i])] = measurement
		
	} 
	
	
	#removing unnecessary brackets from variable names
	names(pig_data)<-gsub("\\(\\)","",names(pig_data))
	
	
	#next step is the create another tidy data frame with averages of each measurement
	#for each subject and activity
	#for this we use the by function to split pig_data into separate data frames
	#based on subject and activity, then we apply the column mean function 
	#on each separate data frame 
	out	<- by(pig_data, interaction(pig_data$subject,pig_data$activity,drop=TRUE),colMeans)
	
	#this combines the separate data frames in out into one data frame
	ddff <- t(sapply(out,I))
	tidy <- as.data.frame(ddff)
	
	#arranging properly with subject and activity
	library(plyr)
	tidy_data <- arrange(tidy,subject,activity)
	
	
	#now labeling the 6 activities with descriptive names
	ac_names <- read.table("./UCI_HAR_Dataset/activity_labels.txt")
	#small function for renaming
	rename_activity <- function(h){
		ac_names$V2[h]
	}
	namu<-lapply(pig_data$activity,rename_activity)
	pig_data$activity<-unlist(namu)
	namu<-lapply(tidy_data$activity,rename_activity)
	tidy_data$activity<-unlist(namu)
	
	#returning the tidy data frame
	write.table(tidy_data,file="tidy_data.txt",row.name=FALSE)
	
	
	
}