## read file till the end of 2/2/2007 calculation based on all minutes
## of a day is 24*60=1440, and the total days from the beginning of this file
## till then is 31-16+31+2 (the first day is not complete)
rawfile <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", nrow=(396+1440*(31-16+31+2)))

##subset the file to extract only two days needed for analysis
feb <- rawfile[rawfile$Date %in% c("1/2/2007", "2/2/2007"),]

##add one more column to feb with date and time together and convert it
DT <- strptime(paste(feb$Date, feb$Time), format="%d/%m/%Y %H:%M:%S")
feb <- cbind(feb, DT)

## draw histogram as required
## the first setting is needed if par is changed by plot4.R
par(mfcol=c(1,1))
hist(feb$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## print out on a png file as required
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()