temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T, sep=';', na.strings="?", 
                   nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
unlink(temp)

data$Date<-as.Date(data$Date, format="%d/%m/%Y")
Datos<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")

#plot1
hist(Datos$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)",
     ylab = "Frequency", col = "Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
