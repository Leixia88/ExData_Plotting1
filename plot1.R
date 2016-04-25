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
#set png device
png(file = "plot1.png", width = 480, height = 480)
hist(hpc$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()