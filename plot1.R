#read household_power_consumption.txt file into R
data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

#
#69518-66637 = 2881

#calculate 
#2075260 rows / 9 columns
(2075260*9*8)/2^20
#142.4968 MB

#reduce the dat set to the required rows
datas <- data[66637:69516,]

library(lubridate)
#change Date to date
datas$Date <- dmy(datas$Date)
# change Time to date
datas$Time <- hms(datas$Time)

#create histogramm and save it to file plot1.png
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = 72, antialias = "none")
hist(as.numeric(datas$Global_active_power)/1000, main = "Global Active Power", col= "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
#title(main = "Global Active Power")
dev.off()
