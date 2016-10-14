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

plot1 <- function() {
    d <- readdata()
    png("plot1.png",width=480,height=480)
    hist(d$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.off()
}

plot1()
