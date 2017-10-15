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

# Step 2 - Create a line graph with multiple y variables

plot(x=new_df$newdatetime, y=new_df$Sub_metering_1, type="l", col="black", xlab="", ylab = "Energy sub metering")
lines(x=new_df$newdatetime, y=new_df$Sub_metering_2, type = "l", col="red")
lines(x=new_df$newdatetime, y=new_df$Sub_metering_3, type="l", col="blue")
legend("topright", cex=0.50, pch=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Step 3 - let's save the png as plot3.png
dev.copy(png, 'plot3.png', width=480, height=480)
dev.off()

#I tried using ggplot2 first but couldn't figure out the legend
#png("plot3.png", width=480, height=480)
#library(ggplot2)
#p1 <-ggplot(new_df, aes(x=new_df$newdatetime))+
#geom_line(aes(x=new_df$newdatetime, y=new_df$Sub_metering_1), colour="black", show.legend = TRUE)+
#geom_line(aes(x=new_df$newdatetime, y=new_df$Sub_metering_2), colour="red", show.legend = TRUE)+
#geom_line(aes(x=new_df$newdatetime, y=new_df$Sub_metering_3), colour="blue", show.legend = TRUE)+
#ylab(label="Energy sub metering")+
#xlab("")+
#scale_x_datetime(date_breaks = "1 day")+
#  scale_color_manual('', limits=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), values=c("#000000", "red", "blue"))
#p1







