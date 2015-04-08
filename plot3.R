plot3 <- function(x="plot3.png"){
  ## plot3("filename") produces plot3 and save to the specified file 
  ## plot3() saves plot3 in "plot3.png" file
  
  ##Read in a few lines to get column classes
  tmp<-read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", nrow=5 )
  
  classes <- sapply(tmp, class)   # copy column class
  
  ##import data, specify colClasses & nrow to save memory and speed up allocation process
  hw1 <- read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", 
                    colClasses = classes, nrow=100000)
  
  ##select rows containing data from the dates 2007-02-01 and 2007-02-02
  xdata <- subset(hw1, ((Date=="1/2/2007")|(Date=="2/2/2007")))
  
  #Create POSIXlt "DateTime" column from "Date" and "Time" columns
  xdata$DateTime <- strptime(paste(xdata$Date, xdata$Time), format="%d/%m/%Y %H:%M:%S")
  
  ## setup png file using default width (480px) and height (480px)
  png(filename=x)
  
  ##plot to png file and return device 
  ## First a blank
  with(xdata, plot(DateTime, Sub_metering_1, 
                   ylab="Energy sub metering", xlab=" ", type="n"))
  
  ##Then add lines one by one
  with(xdata, lines(DateTime, Sub_metering_1))
  with(xdata, lines(DateTime, Sub_metering_2, col="red"))
  with(xdata, lines(DateTime, Sub_metering_3, col="blue"))
  
  ##Add legend the the topright
  legend("topright", lty=1, 
         col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
  
}