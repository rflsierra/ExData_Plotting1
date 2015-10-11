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

## Create histogram of "Global Active Power", colored in red
hist(power.dt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Copy to a new device (png)
dev.copy(png, file = "plot1.png")
dev.off()
