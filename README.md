## Introduction

This code contains the function run_analysis.R which takes in raw Samsung fitness data and produces a large data frame called pig_data and a smaller, tidier data frame called tidy_data. This is output to a text file tidy_data.txt. It assumes that the data is contained in a subdirectory called UCI_HAR_Dataset in the working directory.

## Algorithm

The code is well-commented to explain its working. It starts by reading in the relevant data files. The major work is to identify the mean and standard deviation columns from the test and train datasets and combine them. 

First the subjects are extracted from subject_test.txt and activity labels from y_test.txt (similarly for train sets). The test and train columns are concatenated into one column, which is also the texhnique used for the mean and std variables. 

Then the column numbers of the mean and std variables are identified using the grepl function. 

Using this, we loop over these numbers, extracting these columns from both test and train sets, and contenating them. Simultaneously, these columns are added on to the pig_data data frame. Thus this data frame contains the 
1. subject column
1. activity column
1. mean of first measurement
1. std of first measurement
1. repeats for other measurements

After this the tidy data frame is created. The pig_data is factored based on the interaction of subject and activity variables. This is done using the "by" function so that the data frame is split into multiple data frames with each unique combination of subject and activity is a unique data frame. The colMeans function is used on each factored data frame to calculate the average measurements. Then the data frames are merged to create the tidy_data data frame

After this some renaming is done to give the activities and measurements some suitable names. And then the tidy data is written to a text file. 

