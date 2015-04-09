# Program: Project1.R  
# Author: Ricardo Rodriguez 2015/04
#
# Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. 
# Irvine, CA: University of California, School of Information and Computer Science.
#
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#
# Modify this line to use your own directory path 
#  NOTE: (dWorkingDir) 
#     In blank would be your actual working directory
#
dWorkingDir <- "" 
dWorkingDir <- "C:/ricardor/Coursera/Exploratory_Data_Analysis/ExData_Plotting1"

I_Data <- "/../Project1/data"
I_export_Data <- "/data"
I_export_Plot <- "/figure_replica"

#
# I_Programs <- "Your own directory path where the scripts are stored"
#  This directory cointains additional functions
#
I_Programs <- "/programs"
I_Programs <- paste0(dWorkingDir,I_Programs)
#
I_Directory <- getwd() ## Saves the actual working directory

# =================================================================================
#  Loading auxiliary scripts with functions
# =================================================================================
source(paste0(I_Programs,"/dirFunctions.R"))
source(paste0(I_Programs,"/Files_mdl.R"))

# =================================================================================
# Validate Directory structure.
# Create directories if necessary.
#   Data Directory
#   Data Export Directory 
# =================================================================================
source(paste0(I_Programs,"/set_directories.R"))

# =================================================================================
# Downloading files from WWW
# =================================================================================
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
docFile <- paste0(dDataDir,"/FileZipped.zip")

if ( ! getFile( fileUrl, docFile) ) {
  # call_marshall
  # Restore the original Working Directory
  setwd(I_Directory)
  stop(paste("File ",docFile,"no available"))    
}
# =================================================================================
# Uncompressing the zip file
# =================================================================================
# fUnzipfile
#   unzip the files and load directory structure 
#
# NOTE: fUnzipfile second parameter use TRUE to load
#       only the vectors ( vDirectorypaths ) with the file names.
#       In this case, It runs twice the same
#       function to get the RELATIVE paths to work later with them
#
# load the vectors and unzip the files
#   Next version could ASK if the file names are
#   detected in the directory
#
vDirectorypaths <- fUnzipfile(docFile, FALSE, dDataDir)
if ( is.null(vDirectorypaths) == TRUE  ) {
  # call_marshall
  setwd(I_Directory)
  stop(paste("Unzipping file error :",docFile))  
}
#
# In this specific case, there is only one file to process
#   -  household_power_consumption.txt -
#

# Reading the Dataset
#
# epc <- read.table("household_power_consumption.txt", header= TRUE, nrows = 10, sep = ";")
# Took a long time to convert 
# colClasses = c("Date","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
#
#  read.csv2("household_power_consumption.txt", header= TRUE, sep = ";",na.strings = "?")
#
# =================================================================================
# Reading and sub setting
# =================================================================================
#
cFile2Read <- vDirectorypaths
epc <- subset(
read.table(cFile2Read, header= TRUE, sep = ";",
na.strings = "?"
)
  ,Date == '1/2/2007' | Date == '2/2/2007')

# =================================================================================
# Saving the Subset without convertion in the github data directory
# This new file will contain only the requested records
# =================================================================================
saveFile <- paste0(dWorkingDir,I_export_Data,'/',basename(cFile2Read))
if (! writeMyndf(epc,saveFile)){
  setwd(I_Directory)
  stop(paste("writting file error :",saveFile))  
}

# =================================================================================
# Restore the previous Working Directory
# =================================================================================
setwd(I_Directory)
rm(epc)
rm(list=ls(pattern='I_'))
rm(list=ls(pattern='c'))
rm(list=ls(pattern='d'))
rm(list=ls(pattern='e'))
rm(list=ls(pattern='f'))
rm(list=ls(pattern='m'))
rm(list=ls(pattern='v'))
# =================================================================================
# End of the Script
# =================================================================================
