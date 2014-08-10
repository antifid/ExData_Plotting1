# Load the entire dataset
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
# Make a date-time column
data <- within(data, datetime <- as.POSIXlt(paste(Date, Time),
                                            format = "%d/%m/%Y %H:%M:%S"))
# Filter only the two days of interest by the date-time column
subdata <- data[as.Date(data$datetime) == as.Date("2007-02-01")
                | as.Date(data$datetime) == as.Date("2007-02-02"),]
write.csv(subdata, file = "subdata.csv")

# Make the plot here
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(subdata$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() # Close the file
