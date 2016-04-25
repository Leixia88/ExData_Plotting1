#set the working directory to my data science dir
setwd("/Users/leixia/Documents/DataScience")
#import dplyr to use filter, select, etc.
require(dplyr)
#Download the source file if the file not yet exist in the working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "household_power_consumption.zip",method = "curl")
#run system command "unzip household_power_consumption.zip" to extract household_power_consumption.txt

#Read the csv file into R data.frame
hpc_complete <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
hpc_complete$Date <- as.Date(hpc_complete$Date, "%d/%m/%Y")
hpc <- filter(hpc_complete, Date == "2007-02-01" | Date == "2007-02-02")
hpc <- mutate(hpc, Time2 = as.POSIXct(paste(Date,Time, sep = " "))) #add a new column of time in POSIXct formate
#set png device
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#plot the left top figure
plot(hpc$Time2,hpc$Global_active_power, xlab = "", ylab = "Global Active Power",type = 'l')
#plot the right top figure
plot(hpc$Time2,hpc$Voltage, xlab = "datetime", ylab = "Voltage",type = 'l')
#plot the left bottom figure
plot(hpc$Time2,hpc$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = 'l')
points(hpc$Time2,hpc$Sub_metering_2, type = 'l', col = "red")
points(hpc$Time2,hpc$Sub_metering_3, type = 'l', col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"),bty = 'n' )
#plot the right bottom figure
plot(hpc$Time2,hpc$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",type = 'l')
dev.off()