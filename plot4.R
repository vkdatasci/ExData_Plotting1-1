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

plot4 <- function() {
    d<-readdata()
    png("plot4.png",width=480,height=480)
    par(mfrow = c(2, 2))

    # plot2
    plot(d$datetime, d$Global_active_power, type="l",ylab="Global Active Power", xlab="")

    plot(d$datetime, d$Voltage, type="l",ylab="Voltage",xlab="datetime")

    # plot3 
    plot(d$datetime,d$Sub_metering_1, type="l",col="black",ylab="Energy sub metering",xlab="")
    lines(d$datetime,d$Sub_metering_2, type="l",col="red")
    lines(d$datetime,d$Sub_metering_3, type="l",col="blue")
    legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lwd=2.5,bty="n")

    plot(d$datetime, d$Global_reactive_power, type="l", xlab="datetime",ylab="Global_reactive_power")
    dev.off()

}

plot4()
