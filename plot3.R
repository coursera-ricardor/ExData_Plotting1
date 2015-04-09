# Program: plot3.R  
# Author: Ricardo Rodriguez 2015/04
#
# Dataset:
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

I_Data <- "/data"
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
# Working with the pre-processed Data
# =================================================================================
cFile2Read <- paste0(dWorkingDir,I_Data,'/household_power_consumption.txt')
epc <-   read.table(cFile2Read, header= TRUE, sep = ",")
# sapply(epc,class)
#
# =================================================================================
# Conversion of the Date and Time Columns
# Time Adds the Record Date
# =================================================================================
#head(epc$Time)
epc$Time  <- strptime(paste(epc$Date,epc$Time),format = "%d/%m/%Y %H:%M:%S", tz = "")
# head(epc$Date)
epc$Date <- as.Date(epc$Date,"%d/%m/%Y")
# class(epc$Date)
# sapply(epc,class)
# =================================================================================
# Creating the plot
# =================================================================================
exp_plot <- paste0(dWorkingDir,I_export_Plot,'/plot3.png')
# exp_plot <- paste0(dWorkingDir,'/plot3.png')
#
# png(exp_plot)
#
# V_par <- par()
# plot.ts(epc$Sub_metering_3, col = "blue",ylab = "Energy sub metering")
# plot.new()
plot(epc$Sub_metering_1,type='n',ylab='Energy sub metering', xlab="")
lines(epc$Sub_metering_1, col = "black")
lines(epc$Sub_metering_2, col = "red")
lines(epc$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1,
                    col = c("black","red","blue"), merge = TRUE)
title(main = list('Plot 3',cex = 1.5),outer = TRUE, adj = 0.0)
# par(V_par)
# =================================================================================
# Copy the plot to the file
# =================================================================================
dev.copy(png,exp_plot, width=480, heigh = 480)
dev.off()
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
