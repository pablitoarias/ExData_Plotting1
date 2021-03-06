#Read dataset
# ns.strings = '?' identifies ? as NAs
# colClasses imports first 2 columns as character an dthe rest as numbers
data<-read.table("household_power_consumption.txt", 
                 header=TRUE, sep=";", na.strings="?",
                 colClasses=c("character","character",rep("numeric",7))) 
# Extract only the dates we care about
data<-subset(data,as.Date(strptime(Date, "%d/%m/%Y"))>="2007-02-01" 
             & as.Date(strptime(Date, "%d/%m/%Y"))<="2007-02-02")
# Tied Date and Time into a single Date value
data<-transform(data, 
        DateTime=as.POSIXct(strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")))
# Remove Date and Time columns
data<-data[,!(names(data) %in% c("Date","Time"))]
# reorder to put DateTime as first column
data<-data[c(8,1:7)]
#Open PNG device
png("plot1.png",bg="transparent")
#Increase bottom and left margins to see the x, y labels
par(mar=c(5,4,2,2))
#Generate histogram
hist(data$Global_active_power,col="red", main="Global Active Power",
                xlab="Global Active Power (kilowatts)")
# Close device
dev.off()