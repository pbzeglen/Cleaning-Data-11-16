# Cleaning-Data-11-16

All the data came from . The data cleaning script contained in Cleaning Data.R performs the following operations:

1. Read in all the data.

2. Labels the columns of the sets X datasets using the labels from "features.txt"

3. Remove all columns that do not contain "std" or "mean" and delete columns that contain "meanFreq"

4. Reads in the subject and action labels

5. Adds the subject and action data as a column to the dataset

6. Reorders the columns so that subject and action are first

7. Substitutes the numbers in the action column with descriptive factors labeled as the actions performed.

8. Combines the test and train dataset.

9. Renames variables to "time" instead of "t" and "fast fourier transform" instead of "f"

10. Aggregates the mean of all measurements by subject and action.

The end result is a dataset that displays the average mean and standard deviation of each measurement by action and subject.

The updated codebook for this dataset is described in Codebook.md
