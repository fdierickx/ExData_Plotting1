plot3 <- function() {
	# Read the input data to a data frame
	powerCons <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

	# Convert the date column to a Date type for easy manipulation and filter the 2-day period
	powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
	df <- powerCons[(powerCons$Date=="2007-02-01") | (powerCons$Date=="2007-02-02"),]
        
	# Convert the Sub_metering columns to a numeric type
	df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
	df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
	df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
        
	df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
	# create the plot and annotate it with  additional variables and legend
	plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	lines(df$timestamp,df$Sub_metering_2,col="red")
	lines(df$timestamp,df$Sub_metering_3,col="blue")
	legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1))
	
	# copy the contents of the graph window to a png file of 480 x 480 pixels
	dev.copy(png, file="plot3.png", width=480, height=480)
	dev.off()
	print("plot3.png saved.")
}