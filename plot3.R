plot3<-function(){
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  
  if(!file.exists("data")){
    dir.create("data")
  }
  if(!file.exists("./data/household_power_consumption.zip")){
    download.file(fileUrl, destfile="./data/household_power_consumption.zip")
  }
  unzip("./data/household_power_consumption.zip", exdir="./data")
  householdconsumption<-read.table(file="./data/household_power_consumption.txt",header=TRUE, sep=";", colClasses=c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.string="?")
  householdconsumption<-householdconsumption[householdconsumption$Date=="1/2/2007"|householdconsumption$Date=="2/2/2007",]
  householdconsumption$datetime<-strptime(paste(householdconsumption$Date, householdconsumption$Time), "%d/%m/%Y %T")
  png("./data/plot3.png")
  plot(range(householdconsumption$datetime), range(c(householdconsumption$Sub_metering_1,householdconsumption$Sub_metering_2, householdconsumption$Sub_metering_3)),type="n",xlab="",ylab="Energy sub metering")
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_1, type="l", col="black", lwd=1)
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_2, type="l", col="red", lwd=1)
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_3, type="l", col="blue", lwd=1)
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1))
  dev.off()    
}