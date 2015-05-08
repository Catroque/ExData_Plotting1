source('./ExData_Plotting1.R')

frame <- ExData_Plotting1()

hist(frame$activePower, col = 'red', main = 'Global Active Power',xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')

