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

## Plot #3
png(filename = "plot3.png",width = 480, height = 480, units = "px", bg = "white")
with(hh_power, {
    plot (Timestamp, Sub_metering_1, type = "l", xlab = "", ylab = "Engergy sub metering")
    lines(Timestamp, Sub_metering_2, col = 'Red')
    lines(Timestamp, Sub_metering_3, col = 'Blue')})
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = names(hh_power)[7:9])
dev.off()
