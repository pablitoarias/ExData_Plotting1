data<-read.table("household_power_consumption.txt", 
                 header=TRUE, sep=";", na.strings="?",
                 colClasses=c("character","character",rep("numeric",7)))
data<-subset(data,as.Date(strptime(Date, "%d/%m/%Y"))>="2007-02-01" & as.Date(strptime(Date, "%d/%m/%Y"))<="2007-02-02")
data<-transform(data, DateTime=as.POSIXct(strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")))
data<-data[,!(names(data) %in% c("Date","Time"))]
data<-data[c(8,1:7)]
png("plot1.png",bg="transparent")
par(mar=c(5,4,2,2))
hist(data$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()