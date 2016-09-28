library(readr)
library(dplyr)

electric_usage <- read_delim("../Data/exdata_data_household_power_consumption/household_power_consumption.txt",
                             delim = ";",
                             col_names = TRUE, 
                             col_types = cols(col_date("%d/%m/%Y"),
                                              col_time("%H:%M:%S"),col_number(),col_number(),
                                              col_number(), col_number(), col_number(), 
                                              col_number(), col_number()),
                                              na = c("?", "NA"))
electric_usage_feb <- filter(electric_usage, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
png("plot1.png", width = 480, height = 480)
hist(electric_usage_feb$Global_active_power, col = "Red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
