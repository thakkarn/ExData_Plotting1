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
png("plot3.png", width = 480, height = 480)

with(electric_usage_feb, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering"))
with(electric_usage_feb, lines(datetime, Sub_metering_2, col = "red"))
with(electric_usage_feb, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", pch = "_", col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()