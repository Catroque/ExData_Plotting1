source('./ExData_Plotting1.R')

frame <- ExData_Plotting1()

png(filename='plot4.png', width = 480, height = 480)

par(mfrow = c(2,2))


# plot 1
#
with(frame, plot(datetime, 
                 activePower, 
                 pch = 19, 
                 xlab = '',
                 ylab = 'Global Active Power (kilowatts)',
                 type = 'n'))

with(frame, lines(datetime, activePower))


# plot 2
#
with(frame, plot(datetime, 
                 voltage, 
                 pch = 19, 
                 xlab = 'datetime',
                 ylab = 'Voltage',
                 type = 'n'))

with(frame, lines(datetime, voltage))


# plot 3
#
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
       col = c('black', 'red', 'blue'),
       bty = 'n')


# plot 4
#
with(frame, plot(datetime, 
                 reactivePower, 
                 pch = 19, 
                 xlab = 'datetime',
                 ylab = 'Global_reactive_power',
                 type = 'n'))

with(frame, lines(datetime, reactivePower))

dev.off()