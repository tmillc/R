# Dates are represented by the Date class
# Dates stored internally as days since 1/1/1970
# Times are represented by the POSIXct or the POSIXlt class
# Times stored internally as seconds since 1/1/1970

x <- as.Date("1970-01-02")
unclass(x)    # returns 1, for 1 day after 1970-01-01
weekdays(x)   # "Friday"
months(x)     # "January"
quarters(x)   # "Q1"
# POSIXct is just a big integer under the hood. Useful for storing times in something like a data frame
# POSIXlt is a list underneath, and it stores additional info like day of week, day of year, month, day of month

y <- Sys.time()
unclass(y)      # 1445011224, POSIXct
p <- as.POSIXlt(y)
unclass(p)      # $yday 288, $zone "CDT", ...
p$month         # 9

# strptime
datestring <- c("January 12, 2012 10:40", "November 8, 2020 8:15")
convertedDate <- strptime(datestring, "%B %d, %Y %H:%M")
class(convertedDate)   # "POSIXlt" "POSIXlt"

# y-x   # Warning: Incompatible methods ("-.POSIXxt", "-.Date") for "-"
x <- as.POSIXlt(x)
y-x    # Time difference of 16724.18 days

# Keeps track of tricky things like timezones and leap years
as.Date("2012-03-01") - as.Date("2012-02-28")   # this was a leap year, Time difference of 2 days
as.POSIXct("2014-03-18 06:00:00") - as.POSIXct("2014-03-18 06:00:00", tz = "GMT")  # Time diff 5 hours
as.POSIXct("2014-03-18 06:00:00", tz = "GMT") - as.POSIXct("2014-03-18 06:00:00")  # Time diff -5 hours

