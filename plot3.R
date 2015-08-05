
#read household_power_consumption.txt file into R
data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, na.strings = "?")

#subset data
datas <- data[grep("^1/2/2007$|^2/2/2007$",data$Date),]
#no space in between arguments of grep, not working if not

#convert Date and Time to Date class and store it in Date col
datas$Date <- strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")

#plot the lot
#use Sub_metering_1 Sub_metering_2 Sub_metering_3
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = 72, antialias = "none")
plot(datas$Sub_metering_1, xaxt = "n", type="l", ylab = "Energy sub metering", xlab = "")
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
lines(datas$Sub_metering_2, type = "l", col ="red")
lines(datas$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(datas[7:9]))
dev.off()

