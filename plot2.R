plot2 <- function() {
	# Read the input data to a data frame
	powerCons <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

	# Convert the date column to a Date type for easy manipulation and filter the 2-day period
	powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
	df <- powerCons[(powerCons$Date=="2007-02-01") | (powerCons$Date=="2007-02-02"),]
	
	# Convert the Global_active_power column to a numeric type 
	df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
	# create the plot
	plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        
	# copy the contents of the graph window to a png file of 480 x 480 pixels
	dev.copy(png, file="plot2.png", width=480, height=480)
	dev.off()
	print("plot2.png saved.")
}