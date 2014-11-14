data<-read.table("household_power_consumption.txt", 
                 header=TRUE, sep=";", na.strings="?",
                 colClasses=c("character","character",rep("numeric",7)))
data<-subset(data,as.Date(strptime(Date, "%d/%m/%Y"))>="2007-02-01" & 
                     as.Date(strptime(Date, "%d/%m/%Y"))<="2007-02-02")
data<-transform(data, DateTime=as.POSIXct(strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")))
data<-data[,!(names(data) %in% c("Date","Time"))]
data<-data[c(8,1:7)]
png("plot4.png",bg="transparent")
par(mfcol=c(2,2))
par(mar=c(4,4,2,2))
plot(data$DateTime,data$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=" ")
lines(data$DateTime,data$Global_active_power)
plot(data$DateTime,data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab=" ")
lines(data$DateTime,data$Sub_metering_1, col="black")
lines(data$DateTime,data$Sub_metering_2, col="red")
lines(data$DateTime,data$Sub_metering_3, col="blue")
legend("topright", col = c("black","red", "blue"), legend = names(data)[6:8],
       lty=c(1,1,1),bty="n")
plot(data$DateTime,data$Voltage, type="n", ylab="Voltage", xlab="datetime")
lines(data$DateTime,data$Voltage)
plot(data$DateTime,data$Global_reactive_power, type="n", ylab="Global_reactive_power",xlab="datetime")
lines(data$DateTime,data$Global_reactive_power)
dev.off()
