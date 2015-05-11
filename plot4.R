fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fileDest <- "./household_power_consumption.txt"
if(!file.exists(fileDest))
{
     download.file(fileUrl,"./household_power_consumption.txt",method="curl")
}

## read text file starting from specific date
## there are 1440 minutes in a day, since we are
## considering data for 2 days we could subset data and set nrows = 2*1440
elecPC <- read.table(fileDest, sep = ";",na.strings=c("?"),skip=grep("1/2/2007", 
                    readLines("household_power_consumption.txt"))-1,nrows=2881)

## need to assign column names since skipped rows from beginning of file
names(elecPC) <- c("Date","Time","Global_active_power", 
                   "Global_reactive_power","Voltage", 
                   "Global_intensity","Sub_metering_1",
                   "Sub_metering_2","Sub_metering_3")


## Open a bitmap device; creat 'plot1.png' in current working directory
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

## create a x,y plot with proper overlays and send to a file
with(elecPC, {
     
     ## first plot in collection
     plot(as.POSIXct(paste(Date,Time)),Global_active_power, xlab="",
          ylab="Global Active Power", type="l", col="black")

     ## second plot in collection (row=1 col=2)
     plot(as.POSIXct(paste(Date,Time)),Voltage,xlab="datetime",ylab="Voltage",
          type="l",col="black")

     ## thrid plot in collection (row=2 col=1)
     plot(as.POSIXct(paste(Date,Time)),Sub_metering_1, xlab="",
          ylab="Energy sub metering", type="n")
     lines(as.POSIXct(paste(Date,Time)),Sub_metering_1,type="l",col="black")
     lines(as.POSIXct(paste(Date,Time)),Sub_metering_2,type="l",col="red")
     lines(as.POSIXct(paste(Date,Time)),Sub_metering_3,col="blue")
     legend("topright",lty="solid",col=c("black","red","blue"),
            legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

     ## fourth plot in collection
     plot(as.POSIXct(paste(Date,Time)),Global_reactive_power,xlab="datetime", 
          type="l",col="black")
})

## close the bitmap file device
dev.off()