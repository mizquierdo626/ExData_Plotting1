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
    #Change the format of the date
        powercon$Date <- as.Date(powercon$Date, "%d/%m/%Y")

    #Filter only the data you desire
        powercon <- subset(powercon,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

    #No missing data
        powercon <- powercon[complete.cases(powercon), ]

    #Plot format
        png("plot1.png", width=480, height=480)

    #Plot 1
        hist(powercon[, Global_active_power], main="Global Active Power",

            xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
        dev.off()


