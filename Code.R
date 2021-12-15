library(dplyr)
library(plyr)

mean_median_temperature_on_particular_day<-function(date)
{
  
  #Read Cities where we have added a column 'PROVINCE_CODE'
  cities <- read.csv("cities-new.csv")
  
  #Read Climate where we have column 'PROVINCE_CODE'
  climate <- read.csv("climate-1.csv")
  
  #Merge two tables with column 'PROVINCE_CODE'
  merged_data = merge(x = cities,y = climate, by = "PROVINCE_CODE")
  
  #Urban Area Data
  urban_data <- subset(merged_data, capital == "admin" | capital == "primary")
  
  #Group by Date
  average_merged_data <- ddply(urban_data, .(LOCAL_DATE), summarize,  Mean_Temperature=mean(MEAN_TEMPERATURE), Median_Temperature=median(MEAN_TEMPERATURE))
  
  #formatting date to date-time format
  date_time <- paste(date, "00:00")
  
  #retrieve mean and median value for all urban locations on particular date
  expected_result <- subset(average_merged_data, LOCAL_DATE == date_time)
  return(expected_result)
}

# Call `mean_median_temperature_on_particular_day` with date value
m <- mean_median_temperature_on_particular_day("30-01-2021")

# Call `m` 
Average <- m
print(Average)