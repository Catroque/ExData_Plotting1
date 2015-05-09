source('./ExData_Plotting1.R')

frame <- ExData_Plotting1()

png(filename='plot2.png', width = 480, height = 480)

with(frame, plot(datetime, 
                 activePower, 
                 pch = 19, 
                 xlab = '',
                 ylab = 'Global Active Power (kilowatts)',
                 type = 'n'))

with(frame, lines(datetime, activePower))

dev.off()