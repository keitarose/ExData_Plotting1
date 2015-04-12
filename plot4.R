plot4<-function(){
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
  png("./data/plot4.png")
  par(mfrow=c(2,2))
  plot(range(householdconsumption$datetime), range(householdconsumption$Global_active_power),type="n",xlab="",ylab="Global Active Power (kilowatts)")
  lines(householdconsumption$datetime, householdconsumption$Global_active_power, type="l")
  plot(range(householdconsumption$datetime), range(householdconsumption$Voltage),type="n",xlab="datetime",ylab="Voltage")
  lines(householdconsumption$datetime, householdconsumption$Voltage, type="l")
  plot(range(householdconsumption$datetime), range(c(householdconsumption$Sub_metering_1,householdconsumption$Sub_metering_2, householdconsumption$Sub_metering_3)),type="n",xlab="",ylab="Energy sub metering")
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_1, type="l", col="black", lwd=1)
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_2, type="l", col="red", lwd=1)
  lines(householdconsumption$datetime, householdconsumption$Sub_metering_3, type="l", col="blue", lwd=1)
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1), bty="n")
  plot(range(householdconsumption$datetime), range(householdconsumption$Global_reactive_power),type="n",xlab="datetime",ylab="Global_reactive_power")
  lines(householdconsumption$datetime, householdconsumption$Global_reactive_power, type="l")
  dev.off() 
}