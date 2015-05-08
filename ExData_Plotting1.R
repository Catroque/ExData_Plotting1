
ExData_Plotting1 <- function()
{
    dataFilePath <- 0
    dataColumns  <- 0
    dataClasses  <- 0
    dataRows     <- 0
    dataFrame    <- 0
    
    
    
    filePath <- function(...) 
    { 
        paste(..., sep = "/") 
    }
    
    
    
    download <- function()
    {
        url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
        
        downloadDir  <- 'download'
        downloadFile <- 'exdata-data-household_power_consumption.zip'
        downloadFilePath <- filePath(downloadDir, downloadFile)
        
        # check the existence of data directory that will be used to 
        # host the zip file downloaded and txt file extracted from it
        #
        if (!file.exists(downloadDir))
        {
            dir.create(downloadDir)
        }
        
        if (!file.exists(downloadFilePath))
        {
            download.file(url, downloadFilePath)
        }
        
        dataDir  <- 'data'
        dataFile <- 'household_power_consumption.txt'
        dataFilePath <<- filePath(dataDir, dataFile)
        
        if (!file.exists(dataDir))
        {
            dir.create(dataDir)
        }
        
        if (!file.exists(dataFilePath))
        {
            unzip(downloadFilePath, dataFile, exdir=dataDir)
        }
    }
    
    
    
    prepare <- function()
    {
        # read only o little bit of data from file to getting information
        # to create the final data frame
        #
        initial <- read.table(dataFilePath, 
                              nrows = 10, 
                              header = TRUE, 
                              sep = ";")

        # get the columns classes of data and change the type for date and
        # time columns
        #
        dataColumns <<- c('date', 'time', 'activePower', 'reactivePower', 'voltage', 'current', 'meter1', 'meter2', 'meter3')
        dataClasses <<- sapply(initial, class)
        dataClasses[['Date']] <<- "character"
        dataClasses[['Time']] <<- "character"
        #sapply(dataClasses, function(x) sub('factor','character', x))
    
        # get the number of rows of data file
        #
        command   <- paste("wc -l ", dataFilePath, sep="")
        result    <- system(command = command, intern = TRUE)
        dataRows <<- as.numeric(strsplit(result, c(" "))[[1]][1])
    }
    
    
    
    load <- function()
    {
        dataDays <- c('1/2/2007', '2/2/2007')

        skipRows  <- 2
        readyRows <- 2
        batchRows <- 10000
        
        # create the data frame for processed data
        #
        dataFrame <- read.table(text = "", 
                                col.names = dataColumns, 
                                colClasses = as.vector(dataClasses))
        
        # open the connection with the data file
        #
        con <- file(dataFilePath)
        open(con)
        
        while (readyRows < dataRows)
        {
            auxDF <- read.table(con, 
                                header = FALSE, 
                                sep = ";", 
                                skip = skipRows,
                                nrow = batchRows,
                                col.names = dataColumns,
                                colClasses = as.vector(dataClasses),
                                na.strings = c('?'))

            auxDF <- auxDF[!is.na(auxDF$activePower) & auxDF$date %in% dataDays,]

            if (dim(auxDF)[1] > 0)
            {
                dataFrame <<- rbind(dataFrame, auxDF)
            }
            
            skipRows  <- 0
            readyRows <- readyRows + batchRows
        }
        
        close(con)
    }
    
    
    
    process <- function()
    {
        auxDF <- data.frame(datetime = strptime(paste(dataFrame$date, dataFrame$time), "%d/%m/%Y %H:%M:%S"))
        
        frame <- cbind(auxDF, dataFrame[,3:ncol(dataFrame)])        
        
        # frameColumns <<- c("DateTime", dataColumns[3:length(dataColumns)])
        # frameClasses <<- c(list(DateTime="Date"), dataClasses[3:length(dataClasses)])
        
        frame
    }
    
    
    
    plot <- function()
    {
        # plot 1
        #
        hist(frame$activePower, col = 'red', main = 'Global Active Power',xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')
        
        # plot 2
        #
        with(frame, plot(dateTime, activePower, pch = 19))
        
    }
    
    
    
    getFrame <- function()
    {
        dataFrame
    }
    
    
    
    download()
    prepare()
    load()
    frame <- process()
    frame
}




setwd('C:/Users/Rinaldo/Downloads/The Data Science Specialization/04 - Exploratory Data Analysis/wd')

frame <- ExData_Plotting1()

