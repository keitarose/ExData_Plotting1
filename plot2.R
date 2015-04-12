plot2<-function(){
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
  png("./data/plot2.png")
  plot(range(householdconsumption$datetime), range(householdconsumption$Global_active_power),type="n",xlab="",ylab="Global Active Power (kilowatts)")
  lines(householdconsumption$datetime, householdconsumption$Global_active_power, type="l")
  dev.off()
}