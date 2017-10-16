# Step 1a - download and unzip file

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")) {dir.create("data")}
download.file(fileURL, destfile = "./data/Electric_power_consumption.zip")

# Step 1b - unzip data
unzip(zipfile = "./data/Electric_power_consumption.zip", exdir = "./data")

# Step 1c - let's see what's in that directory
list.files("./data")

# Step 1d - it's always a good idea to explore the first few lines of the data table
firstfewlines <- readLines("./data/household_power_consumption.txt", n=5)
firstfewlines
rm(firstfewlines)

# Step 1e - read the table and subset to get rows between 01/02/2007 00:00:00 and 02/02/2007 23:59:59
df <- read.table("./data/household_power_consumption.txt",  header=TRUE, sep=';', na.strings="?")
new_df <- df[df$Date %in% c("1/2/2007", "2/2/2007"),]

# Step 1f - create a new variable that combines Date and Time
new_df$newdatetime <- with(new_df, as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))

# Step 2 - let's use mfrow and mfcol functions to stack the graphs into one
par(mfrow=c(2,2))#we want two rows, two columns
plot(new_df$newdatetime, new_df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(new_df$newdatetime, new_df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(x=new_df$newdatetime, y=new_df$Sub_metering_1, type="l", col="black", xlab="", ylab = "Energy sub metering")
lines(x=new_df$newdatetime, y=new_df$Sub_metering_2, type = "l", col="red")
lines(x=new_df$newdatetime, y=new_df$Sub_metering_3, type="l", col="blue")
legend("topright", pch=1, cex=0.25, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x=new_df$newdatetime, y=new_df$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

# step 3- let's save the plots as plot4.png
dev.copy(png,'plot4.png')
dev.off()






