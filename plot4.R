## read file till the end of 2/2/2007 calculation based on all minutes
## of a day is 24*60=1440, and the total days from the beginning of this file
## till then is 31-16+31+2 (the first day is not complete)
rawfile <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", nrow=(396+1440*(31-16+31+2)))

##subset the file to extract only two days needed for analysis
feb <- rawfile[rawfile$Date %in% c("1/2/2007", "2/2/2007"),]

##add one more column to feb with date and time together and convert it
DT <- strptime(paste(feb$Date, feb$Time), format="%d/%m/%Y %H:%M:%S")
feb <- cbind(feb, DT)

## partition the canvas into 4
par(mfcol=c(2,2))

## draw 1st figure as required
plot(feb$DT, feb$Global_active_power, type="l", axes=FALSE, xlab="", ylab="Global Active Power")
box()
axis(1, at=min(feb$DT), lab=c("Thu"))
axis(1, at=max(feb$DT), lab=c("Sat"))
axis(1, at=feb$DT[1440], lab=c("Fri"))
axis(2, las=1)

## draw 2nd figure as required
plot(feb$DT, feb$Sub_metering_1, type="l", axes=FALSE, xlab="", ylab="Energy sub metering")
lines(feb$DT, feb$Sub_metering_2, col="red")
lines(feb$DT, feb$Sub_metering_3, col="blue")
box()
axis(1, at=min(feb$DT), lab=c("Thu"))
axis(1, at=max(feb$DT), lab=c("Sat"))
axis(1, at=feb$DT[1440], lab=c("Fri"))
axis(2, las=1)
legend("topright", cex=0.5, bty="n", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

## draw 3rd figure as required
plot(feb$DT, feb$Voltage, type="l", axes=FALSE, xlab="datetime", ylab="Voltage")
box()
axis(1, at=min(feb$DT), lab=c("Thu"))
axis(1, at=max(feb$DT), lab=c("Sat"))
axis(1, at=feb$DT[1440], lab=c("Fri"))
axis(2, las=1)

## draw 4th figure as required
plot(feb$DT, feb$Global_reactive_power, type="l", axes=FALSE, xlab="datetime")
box()
axis(1, at=min(feb$DT), lab=c("Thu"))
axis(1, at=max(feb$DT), lab=c("Sat"))
axis(1, at=feb$DT[1440], lab=c("Fri"))
axis(2, las=1)

## print out on a png file as required
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()