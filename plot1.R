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
png(filename = "plot1.png", width = 480, height = 480)
hist(subdata[ ,3], main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)")
dev.off()