## Download, unzip and open the file containing the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power.zip", method = "curl")
unzip("power.zip")
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
png("plot4.png")

## Set-up conditions for multiple plots in one image
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

## Plot 1
plot(x = power.dt$Time, y = power.dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Plot 2
plot(x = power.dt$Time, y = power.dt$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

## Plot 3 (with added changes in legend)
plot(x = power.dt$Time, y = power.dt$Sub_metering_1, type = "l", xlab = "", ylab = "Enery sub metering")
points(x = power.dt$Time, y = power.dt$Sub_metering_2, type = "l", col = "red")
points(x = power.dt$Time, y = power.dt$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", pt.cex = 1, cex = 1)

## Plot 4
plot(x = power.dt$Time, y = power.dt$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
