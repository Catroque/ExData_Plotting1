source('./ExData_Plotting1.R')

frame <- ExData_Plotting1()

png(filename='plot1.png', width = 480, height = 480)

hist(frame$activePower, 
     col = 'red', 
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)', 
     ylab = 'Frequency')

dev.off()