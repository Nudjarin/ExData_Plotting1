plot2 <- function(x="plot2.png") {
  ## plot2("filename") produces plot2 and save to the specified file 
  ## plot2() saves plot2 in "plot2.png" file
  
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
  
  ## plot to png file and return device
  plot(xdata$DateTime, xdata$Global_active_power, "l", ylab="Global Active Power (kilowatts)", 
       xlab=" ")
  
  dev.off()
  
  
}