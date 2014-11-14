data<-read.table("household_power_consumption.txt", 
                 header=TRUE, sep=";", na.strings="?",
                 colClasses=c("character","character",rep("numeric",7)))
data<-subset(data,as.Date(strptime(Date, "%d/%m/%Y"))>="2007-02-01" & as.Date(strptime(Date, "%d/%m/%Y"))<="2007-02-02")
data<-transform(data, DateTime=as.POSIXct(strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")))
data<-data[,!(names(data) %in% c("Date","Time"))]
data<-data[c(8,1:7)]
png("plot2.png",bg="transparent")
par(mar=c(3,4,2,2))
plot(data$DateTime,data$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab=NULL)
lines(data$DateTime,data$Global_active_power)
dev.off()