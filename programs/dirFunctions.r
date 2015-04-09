# Program: dirFunctions.R  
# Author: Ricardo Rodriguez 2014/11
#
#    Functions to mange directories
#
#   manageDir

# manageDir
#      Validate the path and set as a working directory
#
#   Parameters:
#       cDirectory -    Directory path to work with
#       lCreate    -    Flag to create the Directory structure
#       lSetWD     -    Flag to SET the Directory Path as a working Directory 
# NOTES:
#       lCreate    -    Default TRUE, to NOT create the Directory path requires FALSE
#       lSetWD     -    Default TRUE, to NOT set the Directory as a WD requires FALSE
#   Due R language behaviour, if You send more than ONE parameter, it is recomended 
#   that you send ALL the parameters in the function call.

manageDir <- function(cDirectory = "" , 
                         lCreate = TRUE,
                         lSetWD = TRUE) {
  ##
  ## Set the working environment
  ##
  if ( nchar( cDirectory ) != 0 ) {
    if ( !file.exists( cDirectory ) ) {
      #
      # Verify create Directory flag
      #
      if ( lCreate == FALSE ){
        warning(paste("invalid path selected:",cDirectory))
        return(FALSE)
      }
      else {
        ## By now allows to create the full path
        ## to skip the validation of existence of the previous directory
        dir.create(cDirectory, recursive = TRUE)        
      }
    } ## endif file.exists
    
    if ( lSetWD == TRUE ) {
        setwd(cDirectory)
        return(TRUE)        
    } else {
        return(TRUE)
    }# end SetWD
  }
  else {
    warning("Verify Path name, is empty")
    return(FALSE)
  } # end file.exists
    
} # end manageDir

