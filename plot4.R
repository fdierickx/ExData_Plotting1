plot4 <- function() {
	# Read the input data to a data frame
	powerCons <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

	# Convert the date column to a Date type for easy manipulation and filter the 2-day period
	powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
	df <- powerCons[(powerCons$Date=="2007-02-01") | (powerCons$Date=="2007-02-02"),]
        
	# Convert the columns relevant for the plot to a numeric type
	df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
	df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
	df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
	df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
	df$Voltage <- as.numeric(as.character(df$Voltage))
        
	df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
	# set the layout of the graphical layout
	par(mfrow=c(2,2))

	# add plot1 to the graphical layout
	plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
	
	# add plot2 to the graphical layout
	plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
	# add plot3 to the graphical layout
	plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	lines(df$timestamp,df$Sub_metering_2,col="red")
	lines(df$timestamp,df$Sub_metering_3,col="blue")
	legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), bty="n")
        
	# add plot4 to the graphical layout
	plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
	# copy the contents of the graph window to a png file of 480 x 480 pixels
	dev.copy(png, file="plot4.png", width=480, height=480)
	dev.off()
 	print("plot4.png saved.")
}