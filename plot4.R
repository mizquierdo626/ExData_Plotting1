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
        png("plot4.png", width=480, height=480)
    #par() combines multiple plots into one overall graph
    #mfrow used to specify the number of subplot in vector form c(m,n)
        par(mfrow=c(2,2))

    #Plot 1
        plot(powercon[, dateTime], powercon[, Global_active_power], 
            type="l", xlab="", ylab="Global Active Power")

    #Plot 2
        plot(powercon[, dateTime], powercon[, Voltage], type="l", xlab="datetime", ylab="Voltage")
    
    #Plot 3
        plot(powercon[, dateTime], powercon[, Sub_metering_1],
            type="l", xlab="", ylab="Energy sub metering")
        lines(powercon[, dateTime], powercon[, Sub_metering_2], col="red")
        lines(powercon[, dateTime], powercon[, Sub_metering_3], col="blue")
        legend("topright", col=c("black", "red", "blue"),
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty = c(1,1), bty = "n", cex = .5) 

    #Plot 4
        plot(powercon[, dateTime], powercon[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power" )
 
        
        dev.off()








