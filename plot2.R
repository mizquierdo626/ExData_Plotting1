###Course Project###
   library(data.table)
    #Check, Download and Open zip file
        filename <- "Electric power consumption.zip"
        if (!file.exists(filename)) { 
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "Electric power consumption.zip", method = "curl")
    }
        if(!file.exists("household_power_consumption.txt")) {
            unzip(filename)
    }


    #Read text file, turn to data table, to subset data fro specified dates
        powercon <- data.table::fread(input = "household_power_consumption.txt"
                                  , na.strings = "?") 
   
        powercon[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

    #Change the format of the date
        powercon[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

    #Filter only the data you desire
       powercon <- powercon[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

    #Plot format
        png("plot2.png", width=480, height=480)

    #Plot 2
        plot(x = powercon[, dateTime], 
        y = powercon[, Global_active_power],
        type="l", xlab="", ylab="Global Active Power (kilowatts)")
        
        dev.off()


