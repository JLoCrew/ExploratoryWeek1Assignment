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

# Step 2 - let's make a line graph with Global Active Power as Y variable and DateTime as X variable
#png("plot2.png", width=480, height=480)
plot(new_df$newdatetime, new_df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Step 3 - let's save plot2 as a png format
dev.copy(png, 'plot2.png', width=480, height=480)
dev.off()





