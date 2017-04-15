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

# Create plot to png device
png("plot1.png", bg="transparent")
hist(data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()
