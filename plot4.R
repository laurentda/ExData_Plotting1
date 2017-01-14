#read data into R
#Note that in this dataset missing values are coded as ?.
data <- read.table(file = "household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")

#We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
#subset data with Date 2007-02-01 | 2007-02-02
data2 <- data[grep("^2007-02-01|^2007-02-02", data$Date), ]

#You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
library(lubridate)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

#clear space by removing original dataset
rm(data)

#transform Global_active_power to numeric
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

#plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = 72, antialias = "none")

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data2, {
    plot(data2$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power", xlab = "")
    axis(1, at = c(1, length(data2$Date)/2, length(data2$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
    
    plot(data2$Voltage, xaxt = "n", type = "l", ylab = "Voltage", xlab = "datetime")
    axis(1, at = c(1, length(data2$Date)/2, length(data2$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
    
    plot(data2$Sub_metering_1, xaxt = "n", type="l", ylab = "Energy sub metering", xlab = "")
    axis(1, at = c(1, length(data2$Date)/2, length(data2$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
    lines(data2$Sub_metering_2, type = "l", col ="red")
    lines(data2$Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, lwd = 1, bty = "n", col = c("black", "red", "blue"), legend = names(data2[7:9]))
    
    plot(data2$Global_reactive_power, xaxt = "n", type = "l", ylab = names(data2[4]), xlab = "datetime")
    axis(1, at = c(1, length(data2$Date)/2, length(data2$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
    
})
dev.off()