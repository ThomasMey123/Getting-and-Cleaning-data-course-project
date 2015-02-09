### Variables used

* dir:                  Used to set the directory relatively to the working directory
* featuresFile:         Filename for the file with the data on feature codes and descriptions
* activityLabelsFile:   Filename for the file with the assigment of activity codes and descriptions
* xTestFile/xTrainFile: Filenames for the files with processed measurement data
* yTestFile/yTrainFile: Filenames for the files with activity codes
* sTestFile/sTrainFile: Filenames for the files with subject codes

All of the following variables are used to store the data read from the above files

* featuresData
* activityLabelsData
* xtestData/xtrainData
* ytestData/ytrainData
* stestData/strainData

The following variables are used to join test and train data

* xallData
* yallData
* sallData

The following variables are used for processing purposes:

* transposedFeaturesData:   used to transpose the features matrix in order to be applied to the xallData matrix columns
* columnsOfInterest:        used for the desired columns with mean or std 
* xselectedData:            selected measurement data (selected by columnsOfInterest)
* ynamedData:               used to apply activity names instead of codes
* alldata:                  data.table combining measurement, activity and subject data 
* tidydata:                 data.table with the means of alldata by activity and subject

### Processing
The script could download the data file "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
but since this is time consuming it assumes the file was already loaded to the working directory


1) The file is unzipped and then the following files are read

* the features.txt and the activity_labels.txt  file which contain information about the feature and activity codes
* the x... files containing the actual preprocessed experiment data
* the y... files containing the activity codes
* the s... files containing the subject codes

2) The test and train data is joined
3) User friendy names for the observations and other data which have been read are set 
4) The columns containing a mean or std deviation are selected
5) The activity codes are replaced by descriptive names
6) experiments, subjects and observations are joined to one big table
7) data is grouped by activity and subject
8) results are written to a file



