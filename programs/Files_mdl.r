# Program: Files_mdl.R  
# Author: Ricardo Rodriguez 2014/11
#
#  Functions included to mange the files:
#
#       writeMyndf
#       getFile
#       fUnzipfile
#       find_subject_group
#
#

# writeMyndf
# Writes the DataFrame ndf (NewDataFrame) to disk
#   Parameters:
#       dfData - DataFrame to write
#       cDestFile - Filename to store the DataFrame
#

writeMyndf <- function(dfData = NULL, cDestFile = ""){
    if ( is.null( dfData ) == TRUE ) {
        message("Data Frame to export is invalid!")
        return(FALSE)
    }    
    if ( nchar( cDestFile ) == 0 ) {
        message("file name is invalid!")
        return(FALSE)
    }
    
    #
    # Validates the Directory where the file will be written
    # Function candidate - 
    #
    lCreateDir <- "Y"
    if ( ! file.exists( dirname(cDestFile) ) ) {
        # Ask for User Input
        lCreateDir <- "X"
        message(paste("Directory",dirname(cDestFile)," does not Exists, Do You want to create it?"))
        while(length(grep(lCreateDir,"YN", ignore.case = TRUE)) == 0  ){
            lCreateDir <- readline(prompt = "[y|n]: ")
        }
        
        # DO NOT Create the Directory
        if (length(grep(lCreateDir,"N", ignore.case = TRUE)) == 1 ) {
            return(FALSE)
        }  
        dir.create( dirname(cDestFile), recursive = TRUE)
        
    } # end file.exists / Directory Check
    
    #
    # Validating if the File already exists
    #
    lDownload <- "Y"
    if ( file.exists( cDestFile ) ) {
        # Ask for User Input
        lDownload <- "X"
        message(paste("File:",cDestFile,"already Exists, Do You want to export it again?"))
        while(length(grep(lDownload,"YN", ignore.case = TRUE)) == 0  ){
            lDownload <- readline(prompt = "[y|n]: ")
        }
        
    } # end file.exists
    
    # Export the file
    if (length(grep(lDownload,"N", ignore.case = TRUE)) == 1 ) {
        return(FALSE)
    }  
    write.csv(dfData, file = cDestFile, row.names = FALSE)
    return(TRUE)
    
    
} # end writeMyndf

# getFile
#       Download a file from a url
#   Parameters:
#       cURL - URL to download the file
#       cDestFile - Filename to store the download URL
#
getFile <- function (cUrl = "", cDestFile = "") {
    
    #
    # Validating parameters
    #
    if ( nchar(cUrl) == 0 ) {
        warning("URL/URI not valid!")
        return(FALSE)
    }
    if ( nchar(cDestFile) == 0 ) {
        warning("Destination File name invalid!")
        return(FALSE)
    }
    
    #
    # Validating if the File already exists
    #
    lDownload <- "Y"
    if ( file.exists( docFile ) ) {
        # Ask for User Input
        lDownload <- "X"
        message("File already Exists, Do You want to Download it again?")
        while(length(grep(lDownload,"YN", ignore.case = TRUE)) == 0  ){
            lDownload <- readline(prompt = "[y|n]: ")
        }
        
    } # end file.exists
    
    # Download the file
    if (length(grep(lDownload,"Y", ignore.case = TRUE)) == 1 ) {
        download.file(cUrl, destfile = cDestFile, method = "curl")
    }  
    return(TRUE)
    
    
} # end getFile

# fUnzipfile
#   Parameters:
#       file2unzip - Directory path and filename to be unzip
#       lunzip     - Logical flag to extract the files or only LIST
#                       the contents of the zip file
# NOTE: 
#   lunzip - TRUE only loads the vector with the file names lDaSet,
#             this parameter allowed to run several tests without
#             expand every time the file.
#            FALSE 
#
# function to unzip the file and populate the 
# working filenames vectors
#
fUnzipfile <- function( file2unzip = "", 
                        lunzip = TRUE,
                        extraction_Directory = ".") {
  
    # Returns a vector with the Directory structure and file names extracted.
    lDaSet <- NULL
    
    if ( nchar( file2unzip ) == 0 ) {
        message("file name to unzip is invalid!")
        return(lDaSet)
    }
    
    #
    # Validate extraction directory
    #
#    if () {
#        
#    }
    #
    # In this case, we know that it is a zip file
    # the program will unzip the files
    #
    #
    # Obtaining the Directory Structure
    # Note:
    #   This is done expanding the list of files previously the extraction
    #   to AVOID file mismatch in the merging process in case of the
    #   existence of similar file names in the working directory,
    #   we can not assume that only the files to be extracted are going
    #   to be in the working directories
    
    message("uncompressing files...")
    lDaSet <- unzip(file2unzip, list = lunzip, exdir = extraction_Directory )
    message("files ready...")
    return(lDaSet)
} # end fUnzipfile

#
# find_subject_group function
#   function to return the subject_id, subject_code, subject_group
#
find_subject_group <- function (cGroup = "", cDirectorypaths = NULL) {
    if ( nchar( cGroup ) == 0 ) {
        message("Group to process is invalid!")
        return(FALSE)
    }
    if ( length( cDirectorypaths ) == 0 ) {
        message("Directory path to process is invalid!")
        return(FALSE)
    }
    
    cSubjectPath <- cDirectorypaths[grep(paste0(cGroup,"/$"),cDirectorypaths)]
    # adds the working directory path and Data directory path
    cSubjectFile <- paste0(dWorkingDir,I_Data,"/",cSubjectPath,"subject_",cGroup,".txt")
    
    tSubjects <- read.table(cSubjectFile, sep = "", col.names = "subject_id")
    ttSubjects <- unique(tSubjects)
    row.names(ttSubjects) <- NULL
    ttSubjects$subject_code <- paste("Subject",as.character(ttSubjects[[1]]))
    ttSubjects$subject_group <- cGroup
    ttSubjects
    
}

