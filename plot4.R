## Read the data
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                      na.strings = "?", nrows = 100) 
classes <- sapply(initial, class)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", colClasses = classes)

## Convert Date and Time
full.time <- paste(data$Date, data$Time)
data$Time <- strptime(full.time, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Truncate data
subdata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

## Generate plot in a png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
        ## upperleft
plot(subdata$Time, subdata[ ,3], type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
        ## upperright
plot(subdata$Time, subdata[ ,5], type = "l", xlab = "datetime", 
     ylab = "Voltage")
        ## downleft
plot(subdata$Time, subdata[ ,7], type = "l", xlab = "", ylab = "Energy sub metering")
points(subdata$Time, subdata[ ,8], type = "l", col = "red")
points(subdata$Time, subdata[ ,9], type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        ## downright
plot(subdata$Time, subdata[ ,4], type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()