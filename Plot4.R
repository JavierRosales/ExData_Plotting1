temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
unlink(temp)

data$Date<-as.Date(data$Date, format="%d/%m/%Y")
Datos<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
Datos$DateTime<-strptime(paste(Datos$Date, Datos$Time, sep = " "),
                         format="%Y-%m-%d %H:%M:%S")
Datos$DateTime<-as.POSIXct(Datos$DateTime)
#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Datos, {
  plot(Global_active_power~DateTime, type="l", ylab ="Global Active Power(Kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l")
  plot(Sub_metering_1~DateTime, type="l", ylab = "Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
  legend("topright", lty = 1, lwd = 2, col=c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
