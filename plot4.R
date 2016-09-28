library(readr)
library(dplyr)

electric_usage <- read_delim("../Data/exdata_data_household_power_consumption/household_power_consumption.txt",
                             delim = ";",
                             col_names = TRUE, 
                             col_types = cols(col_date("%d/%m/%Y"),
                                              col_character(),col_number(),col_number(),
                                              col_number(), col_number(), col_number(), 
                                              col_number(), col_number()),
                             na = c("?", "NA"))
electric_usage_feb <- filter(electric_usage, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
datetime <- strptime(paste(as.character(electric_usage_feb$Date), electric_usage_feb$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(electric_usage_feb, {
 #hist(electric_usage_feb$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)")
  plot(datetime, electric_usage_feb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(datetime, electric_usage_feb$Voltage, type="l", xlab="", ylab="Voltage")
  plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", pch = "_", col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, electric_usage_feb$Global_reactive_power, type="l", xlab="", ylab="Global_reactive_power")
})

dev.off()