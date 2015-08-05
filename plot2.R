
#read household_power_consumption.txt file into R
data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, na.strings = "?")

#subset data
datas <- data[grep("^1/2/2007$|^2/2/2007$",data$Date),]
#no space in between arguments of grep, not working if not

#convert Date and Time to Date class and store it in Date col
datas$Date <- strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")

#plot the lot
plot(datas$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
#changing x labels to english as computer set to french
axis(1, at = c(1, length(datas$Date)/2, length(datas$Date)), labels = c("Thur.", "Fri.", "Sat."), las = 0)
dev.copy(png, file="plot2.png")
dev.off()
