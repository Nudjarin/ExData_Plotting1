plot4<-function(x="plot4.png"){
    ## plot4("filename") produces plot4 and save to the specified file 
    ## plot4() saves plot4 in "plot3.png" file
  
    ##Read in a few lines to get column classes
    tmp<-read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", nrow=5 )

    classes <- sapply(tmp, class) # copy column class
    
    ##import data, specify colClasses & nrow to save memory and speed up allocation process
    hw1 <- read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", 
                      colClasses = classes, nrow=100000)
    
    ##select rows containing data from the dates 2007-02-01 and 2007-02-02
    xdata <- subset(hw1, ((Date=="1/2/2007")|(Date=="2/2/2007")))
    
    #Create POSIXlt "DateTime" column from "Date" and "Time" columns
    xdata$DateTime <- strptime(paste(xdata$Date, xdata$Time), format="%d/%m/%Y %H:%M:%S")
    
    ## setup png file using default width (480px) and height (480px)
    png(filename=x)
    par(mfrow=c(2,2))     #specify 2 rows x 2 columns format
    
    ##plot to png file and return device 
    ## First ([1,1]) position = Global active power vs. DateTime
    ## Second ([1,2]) postion = Voltage vs. DateTime
    ## Third ([2,1]) postion = Energy sub metering vs. weekdays
    ## Fourth([2,2]) postion = Global reactive power vs. DateTime
    with(xdata, {
      plot(DateTime, Global_active_power, ylab="Global Active Power", xlab=" ", "l")
      
      plot(DateTime, Voltage, ylab="Voltage", xlab="datetime", "l")
      with(xdata, plot(DateTime, Sub_metering_1, 
                     ylab="Energy sub metering", xlab=" ", type="n"))
        with(xdata, lines(DateTime, Sub_metering_1))
        with(xdata, lines(DateTime, Sub_metering_2, col="red"))
        with(xdata, lines(DateTime, Sub_metering_3, col="blue"))
        legend("topright", lty=1, 
             col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(DateTime, Global_reactive_power, ylab="Global_reactive_power", xlab="datetime","l")
      
    })
    dev.off()
}