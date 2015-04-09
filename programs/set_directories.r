# Program: set_directories.R  
# Author: Ricardo Rodriguez 2014/11
#
# Create the working directories and set the
# working directory, 
# saving the previous working directory path in I_Directory variable


# Change working Directory, validating existence & saving active working directory
# 3rd parameter makes dWorkingDir as the working directory 
#
if ( ! manageDir(dWorkingDir, FALSE, TRUE) ) {
    setwd(I_Directory)
    stop(paste("Directory error ",dWorkingDir))
}

#
# Data Directory verification and creation
#
dDataDir <- paste0(dWorkingDir,I_Data)
if ( ! manageDir( dDataDir, TRUE, FALSE) ) {
    setwd(I_Directory)
    stop(paste("Directory error ",dDataDir))  
}

#
# Data Export Directory verification and creation
#
dExportDataDir <- paste0(dWorkingDir,I_export_Data)
if ( ! manageDir( dExportDataDir, TRUE, FALSE) ) {
    setwd(I_Directory)
    stop(paste("Directory error ",dExportDataDir))  
}
