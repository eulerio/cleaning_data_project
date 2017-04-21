## Introduction

This codebook describes the two data frames that this code generates

## Data frame pig_data


This is the larger of the two data frames. The first column lists the subject, the second column identifies the activity by its names as listed in the file "activity_labels.txt". Each row corresponds to the measurements made in a single time-window by the Samsung device. Therefore, the same combination of subject and activity appears multiple times, since multiple windows of sampling are present in the data. The remaining columns list the mean and standard deviation values of the various measurements. The explanation of the various measurements can be found in the "features_info.txt" file.

## Data frame tidy_data

This is very similar to the above data frame, with the exception that the average of the different windows has been taken. Thus, there are 180 rows corresponding to unique combinations of the 30 subjects and 6 activites. Each row contains the average value of the measurements of all windows for this particular subject doing this particular activity. The arrangement is in order of subject and then by activity. The column names are same as in pig_data.





