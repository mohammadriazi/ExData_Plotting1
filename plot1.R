fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fileDest <- "./household_power_consumption.txt"
if(!file.exists(fileDest))
{
     download.file(fileUrl,"./household_power_consumption.txt",method="curl")
}

## read text file starting from specific date
## there are 1440 minutes in a day, since we are considering data for 2 days we could subset
## data and set nrows = 2*1440
elecPC <- read.table(fileDest, sep = ";",na.strings=c("?"),skip=grep("1/2/2007",readLines("household_power_consumption.txt"))-1,nrows=2880)

## need to assign column names since skipped rows from beginning of file
names(elecPC) <- c("Date","Time","Global_active_power", "Global_reactive_power","Voltage", "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## coerce Date column to Date format
elecPC$Date <- as.Date(elecPC$Date)
## convert time column to proper time format
elecPC$Time <- strptime(elecPC$Time,"%H:%M:%S")

## Open a bitmap device; creat 'plot1.png' in current working directory
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## create a hitogram plot and send to a file
with(elecPC, hist(elecPC$Global_active_power, col="red", main="Global Active Power",xlab="Golbal Active Power (kilowatts)"))

## close the bitmap file device
dev.off()