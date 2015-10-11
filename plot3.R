## Download, unzip and open the file containing the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power.zip", method = "curl")
unzip("power.zip")

## In order to be reproduced, the file.choose function has been included in order to allow 
## the user to select the appropriate path for the desired workspace
db.file <- file.choose()

## Characters "?" and "" are defined as NA
power <- read.table(db.file, header = TRUE, sep = ";", na.strings = c("?",""))

## Subsetting the data base for the days to be analyzed 
power.dt <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

## Format the Date and Time data
power.dt$Date <- as.Date(power.dt$Date, format = "%d/%m/%Y")
DateTime <- paste(power.dt$Date, power.dt$Time)
power.dt$Time <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

## Set-up device for png print
png("plot3.png")

## Create first layer of plot with general labels
plot(x = power.dt$Time, y = power.dt$Sub_metering_1, type = "l", xlab = "", ylab = "Enery sub metering")

## Add adicional lines to plot
points(x = power.dt$Time, y = power.dt$Sub_metering_2, type = "l", col = "red")
points(x = power.dt$Time, y = power.dt$Sub_metering_3, type = "l", col = "blue")

## Create legend for plot
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

