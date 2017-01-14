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

#plot1
png(file = "plot1.png", width=480, height=480)
hist(data2$Global_active_power, col = "red", xlab = "Global Active Power (kilowatt)", main = "GLobal Active Power")
dev.off()