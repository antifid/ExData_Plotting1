# Load the entire dataset
#data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, 
#                   na.strings = c("?"),
#                   colClasses=c("Date", NA, 
#                                "numeric", "numeric", "numeric", "numeric",
#                                "numeric", "numeric", "numeric"))
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, 
                   na.strings = c("?"))
# Make a date-time column
data <- within(data, datetime <- as.POSIXlt(paste(Date, Time),
                                            format = "%d/%m/%Y %H:%M:%S"))
# Filter only the two days of interest by the date-time column
subdata <- data[as.Date(data$datetime) == as.Date("2007-02-01")
                | as.Date(data$datetime) == as.Date("2007-02-02"),]
# coercing Sub_meter factors to numeric (actually NULL)
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))

# Make the plot here
png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))
# Just a couple things are different than the individual graphs:
# - a couple labels are different
# - The legend size and order are changed for the Energy sub metering plot
with(subdata, {
    plot(as.POSIXct(datetime), as.numeric(Global_active_power), 
         type = "l", 
         xlab = NA, ylab = "Global Active Power")
    plot(as.POSIXct(datetime), as.numeric(Sub_metering_1),
         type = "l",
         xlab = NA, ylab = "Energy sub metering")
    lines(as.POSIXct(datetime), as.numeric(Sub_metering_2), col = "red")
    lines(as.POSIXct(datetime), as.numeric(Sub_metering_3), col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.9)
    plot(as.POSIXct(datetime), Voltage, type = "l", xlab = "datetime", main = NA)
    plot(as.POSIXct(datetime), Global_reactive_power, type = "l", xlab = "datetime", main = NA)
})
dev.off() # Close the file
