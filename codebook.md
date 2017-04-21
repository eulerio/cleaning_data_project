## Introduction

This codebook describes the two data frames that this code generates

## Introduction


This is the larger of the two data frames. The first column lists the subject, the second column identifies the activity by its names as listed in the file "activity_labels.txt". Each row corresponds to the measurements made in a single time-window by the Samsung device. Therefore, the same combination of subject and activity appears multiple times, since multiple windows of sampling are present in the data.


This code contains the function run_analysis.R which takes in raw Samsung fitness data and produces a large data frame called pig_data and a smaller, tidier data frame called tidy_data. This is output to a text file tidy_data.txt. It assumes that the data is contained in a subdirectory called UCI_HAR_Dataset in the working directory.



