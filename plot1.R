plot1 = function(x="plot1.png") {
  ## plot1("filename") produces plot1 and save to the specified file 
  ## plot1() saves plot1 in "plot1.png" file
  
  ##Read in a few lines to get column classes
  tmp<-read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", nrow=5 )
  
  classes <- sapply(tmp, class) # copy column class
  
  ##import data, specify colClasses & nrow to save memory and speed up allocation process
  hw1 <- read.table(file="household_power_consumption.txt", sep=";", header=T, na.strings="?", 
                colClasses = classes, nrow=100000)

  ##select rows containing data from the dates 2007-02-01 and 2007-02-02
  xdata <- subset(hw1, ((Date=="1/2/2007")|(Date=="2/2/2007")))

  ## setup png file using default width (480px) and height (480px)
  png(filename=x)

  ## plot histogram to png file and return device

  hist(xdata$Global_active_power, ylim=range(0,1300), 
       main="Global Active Power", xlab="Global Active Power (kilowatt)", col="red")
  dev.off()
}