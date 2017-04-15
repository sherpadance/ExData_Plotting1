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
png("plot2.png", bg="transparent")
plot(data$datetime, data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)"
)
dev.off()
