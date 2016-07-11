plants <- dget("plants.R")
class(plants)
ncol(plants)
nrow(plants)
object.size(plants)  # how much memory occupying
names(plants)  # char vector of column names
summary(plants)  # gives a summary for each variable
#  min/Q1/med/mean/Q3/max for numeric, totals for categorical vars (factor variables)

# one variable from that output:
  # Active_Growth_Period
  # Spring and Summer   : 447
  # Spring              : 144
  # Spring, Summer, Fall:  95
  # Summer              :  92
  # Summer and Fall     :  24
  # (Other)             :  30
  # NA's                :4334

table(plants$Active_Growth_Period)
  # Fall, Winter and Spring                  Spring
  #                      15                     144
  #         Spring and Fall       Spring and Summer
  #                      10                     447
  #    Spring, Summer, Fall                  Summer
  #                      95                      92
  #         Summer and Fall              Year Round
  #                      24                       5

str(plants)  # combines many of the summarizing features
