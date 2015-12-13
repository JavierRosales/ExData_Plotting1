temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
unlink(temp)

data$Date<-as.Date(data$Date, format="%d/%m/%Y")
Datos<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")
Datos$DateTime<-strptime(paste(Datos$Date, Datos$Time, sep = " "),
                         format="%Y-%m-%d %H:%M:%S")
date<-as.POSIXct(Datos$DateTime)
#plot2
plot(Datos$Global_active_power~date, type="l", ylab ="Global Active Power(Kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
