fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fileDest <- "./household_power_consumption.txt"
if(!file.exists(fileDest))
{
     download.file(fileUrl,"./household_power_consumption.txt",method="curl")
}

## read text file starting from specific date
## there are 1440 minutes in a day, since we are considering data for 2 days we could subset
## data and set nrows = 2*1440
elecPC <- read.table(fileDest, sep = ";",na.strings=c("?"),skip=grep("1/2/2007",readLines("household_power_consumption.txt"))-1,nrows=2881)

## need to assign column names since skipped rows from beginning of file
names(elecPC) <- c("Date","Time","Global_active_power", "Global_reactive_power","Voltage", "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


## Open a bitmap device; creat 'plot1.png' in current working directory
png(filename = "plot3.png", width = 480, height = 480, units = "px")

## create a x,y plot with proper overlays and send to a file
with(elecPC, plot(as.POSIXct(paste(Date,Time)),Sub_metering_1, xlab="",
                  ylab="Energy sub metering", type="n"))
with(elecPC, lines(as.POSIXct(paste(Date,Time)),Sub_metering_1,type="l",col="black"))
with(elecPC, lines(as.POSIXct(paste(Date,Time)),Sub_metering_2,type="l",col="red"))
with(elecPC, lines(as.POSIXct(paste(Date,Time)),Sub_metering_3,col="blue"))
legend("topright",lty="solid",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## close the bitmap file device
dev.off()