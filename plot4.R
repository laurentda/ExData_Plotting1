
#read household_power_consumption.txt file into R
data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, na.strings = "?")

#subset data
datas <- data[grep("^1/2/2007$|^2/2/2007$",data$Date),]
#no space in between arguments of grep, not working if not

#convert Date and Time to Date class and store it in Date col
datas$Date <- strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")

#plot the lot
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = 72, antialias = "none")

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(datas, {
plot(datas$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power", xlab = "")
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
        
plot(datas$Voltage, xaxt = "n", type = "l", ylab = "Voltage", xlab = "datetime")
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)

plot(datas$Sub_metering_1, xaxt = "n", type="l", ylab = "Energy sub metering", xlab = "")
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
lines(datas$Sub_metering_2, type = "l", col ="red")
lines(datas$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, lwd = 1, bty = "n", col = c("black", "red", "blue"), legend = names(datas[7:9]))

plot(datas$Global_reactive_power, xaxt = "n", type = "l", ylab = names(datas[4]), xlab = "datetime")
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)

})
dev.off()
