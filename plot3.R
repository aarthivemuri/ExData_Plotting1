# Check if the dataset exists in the working directory and download it if its not
# present

filename <- "exdata-data-household_power_consumption.zip"

if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, filename, mode = 'wb')
}  

if (!file.exists("household_power_consumption.txt")) { 
      unzip(filename) 
}

# Import the dataset into R
hpc <- read.table("household_power_consumption.txt", sep = ";", header = T,stringsAsFactors=FALSE)

# Subset the data for 1/2/2007 and 2/2/2007
subsethpc1 <- hpc[(hpc$Date == "1/2/2007"),]
subsethpc2 <- hpc[(hpc$Date == "2/2/2007"),]
subsethpc <- rbind(subsethpc1,subsethpc2)
rm(hpc,subsethpc1,subsethpc2)

# Extract the data required for plotting
datetime <- strptime(paste(subsethpc$Date, subsethpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subsethpc$Global_active_power)
subMetering1 <- as.numeric(subsethpc$Sub_metering_1)
subMetering2 <- as.numeric(subsethpc$Sub_metering_2)
subMetering3 <- as.numeric(subsethpc$Sub_metering_3)


# Create and save the plot in png format
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
