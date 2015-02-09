library(data.table)

# specify and load the file (only once), make sure to use binary for the zip file
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# The next lines are for reference only since they were executed only once
# download.file(fileurl,destfile ="FUCIDataset.zip", method="auto", mode="wb")
# Keep the download date in mind
# dateDownloaded<-date()

# Unzip
unzip("FUCIDataset.zip", exdir= ".")

# Note: the file features.txt can hardly be read on windows, therefor it is recommended to open the text file in Word and save it as word file
# Note: the x... files contain the actual preprocessed experiment data
#       the y... files contain the activity codes
#       the s... files contain the subject codes


# set file names and folders 
dir<-".\\UCI HAR Dataset\\"
featuresFile<-paste(dir, "features.txt", sep="")
activityLabelsFile<-paste(dir, "activity_labels.txt", sep="")

dir<-".\\UCI HAR Dataset\\test\\"
xTestFile<-paste(dir, "X_test.txt", sep="")
yTestFile<-paste(dir, "Y_test.txt", sep="")
sTestFile<-paste(dir, "subject_test.txt", sep="")
               
dir<-".\\UCI HAR Dataset\\train\\"
xTrainFile<-paste(dir, "X_train.txt", sep="")
yTrainFile<-paste(dir, "Y_train.txt", sep="")
sTrainFile<-paste(dir, "subject_train.txt", sep="")

# Read in the neccesary files
# Need to use read.table here since RStudio crashes using fread
featuresData<-read.table(featuresFile,header=FALSE)
activityLabelsData<-read.table(activityLabelsFile,header=FALSE)


xtestData<-read.table(xTestFile,header=FALSE,colClasses="numeric")
ytestData<-read.table(yTestFile,header=FALSE,colClasses="numeric")
stestData<-read.table(sTestFile,header=FALSE,colClasses="numeric")

xtrainData<-read.table(xTrainFile,header=FALSE,colClasses="numeric")
ytrainData<-read.table(yTrainFile,header=FALSE,colClasses="numeric")
strainData<-read.table(sTrainFile,header=FALSE,colClasses="numeric")

#join Test and Train Data
xallData<-rbind(xtestData,xtrainData)
yallData<-rbind(ytestData,ytrainData)
sallData<-rbind(stestData,strainData)

#set names for the observation columns
transposedFeaturesData<-t(featuresData)
names(xallData)<-transposedFeaturesData[2,]
names(yallData)<-c("activityLabel")
names(sallData)<-c("subject")
names(activityLabelsData)<-c("value","activity")

#extract means and standard deviation of measurements using a regular expression
columnsOfInterest<- grep("mean|std",featuresData[,2],ignore.case=TRUE)
xselectedData<-xallData[,columnsOfInterest]

#replace activity codes with  descriptive names
ynamedData<-data.frame(activityLabelsData[yallData[,],2])
names(ynamedData)<-c("activity")

#join experiments, subjects and observations to one big table
alldata<-data.table(cbind(ynamedData,sallData,xselectedData))

#group by activity and subject
tidydata<-alldata[,lapply(.SD,mean),by=list(activity,subject)]

#write results file
write.table(tidydata, "tidydata.txt" ,sep=";",row.names=FALSE)




