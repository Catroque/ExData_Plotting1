source('./ExData_Plotting1.R')

frame <- ExData_Plotting1()

png(filename='plot3.png', width = 480, height = 480)

with(frame, plot(datetime, 
                 meter1, 
                 pch = 19, 
                 xlab = '',
                 ylab = 'Energy sub metering', type = 'n' ))

lines(frame$datetime, frame$meter1, col = 'black')
lines(frame$datetime, frame$meter2, col = 'red')
lines(frame$datetime, frame$meter3, col = 'blue')

legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_2'), 
       #pch = c(19,19,19), 
       lty = c(1,1),
       col = c('black', 'red', 'blue'))

dev.off()