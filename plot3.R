readdata <- function() {
    if (!file.exists("data/household_power_consumption.txt")) {
        if (file.exists("data/household_power_consumption.zip")) {
            unzip("data/household_power_consumption.zip",exdir="./data")
        }
    
    }
    data=read.csv(file="data/household_power_consumption.txt",header=TRUE,sep=";",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")
    d<-subset(data, Date=="1/2/2007" | Date=="2/2/2007")
    d[["datetime"]]=strptime(paste(d$Date, d$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
    d
}

plot3 <- function() {
    d<-readdata()
    png("plot3.png",width=480,height=480)    
    plot(d$datetime,d$Sub_metering_1, type="l",col="black",ylab="Energy sub metering",xlab="")
    lines(d$datetime,d$Sub_metering_2, type="l",col="red")
    lines(d$datetime,d$Sub_metering_3, type="l",col="blue")
    legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1,lwd=2.5)
    dev.off()
}

plot3()
