library(data.table)

# Check if source data is present
# download/unzip if not
if(!file.exists("household_power_consumption.zip")) {
    download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        "household_power_consumption.zip",
        mode="wb"
    )
    unzip("household_power_consumption.zip", overwrite=TRUE)
}

# Read source data file
data <- fread(
    "household_power_consumption.txt",
    sep = ";",
    header = TRUE,
    na.strings = "?"
)

# Convert dates to Date objects and subset data
data$Date <- as.Date(strptime(data$Date, format="%d/%m/%Y"))
data <- subset(data, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

# create datetime   
data$datetime <- as.POSIXct(strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))

# Set locale for English date outputs
Sys.setlocale("LC_TIME", "US")

# Create plot to png device
png("plot4.png", bg="transparent")

par(mfrow = c(2,2))

plot(data$datetime, data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)"
)
plot(data$datetime, data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)
plot(data$datetime, data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
lines(data$datetime, data$Sub_metering_2,
      col = "red"
)
lines(data$datetime, data$Sub_metering_3,
      col = "blue"
)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1
)
plot(data$datetime, data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "global_reactive_power"
)

dev.off()