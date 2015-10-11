## Download the data file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists('/Users/eric/Downloads/household_power_consumption.zip')) {
    download.file(fileURL,destfile = "/Users/eric/Downloads/household_power_consumption.zip", method = "curl")
}

## Read the data file, only include the observations of interest
alldata <- read.csv(unz("/Users/eric/Downloads/household_power_consumption.zip",
                        "household_power_consumption.txt"),
                    header = T, sep = ";", na.strings = '?')
hh_power <- subset(alldata, Date %in% c("1/2/2007","2/2/2007"))
rm(alldata)
hh_power <- transform(hh_power, Date = as.Date(hh_power$Date, "%d/%m/%Y"))
hh_power$Timestamp <- strptime(paste(hh_power$Date, hh_power$Time), "%Y-%m-%d %H:%M:%S")

## Plot #2
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg = "white")
plot(hh_power$Timestamp, hh_power$Global_active_power, type="l", col="black",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
