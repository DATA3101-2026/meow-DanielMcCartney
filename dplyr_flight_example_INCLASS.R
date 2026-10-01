#---------- Adding in packages from library

library(tidyverse)
library(dplyr)
library(nycflights13)

#---------- Looking at my dataset for the first time -----------

flights 

jan1 <- flights |>
  flights(month == 1 & day == 1)

#-------- Create summaries of output, grouped by year, month, day
flights |> filter(dest == "IAH") |> group_by(year,month,day) |> summarize(arr_delay = mean(arr_delay, no.re = TRUE))

flights |> filter(dep_delay > 120)

flights |>
  arrange(year, month, day, dep_time)

showflightsinenv <- flights
sf <- showflightsinenv

mutate(flights, arr_time - dep_time == "gain") #X

#Mutate try 1 - getting the time gained during flight, measured from delays in departure and arrival.
flights |>
  mutate(gain = dep_delay - arr_delay, na.rm = TRUE) #Might need na.rm in final project if using a long dataset

showflightsinenv <- flights
sf <- showflightsinenv

#Mutate attempt 2
flights_gain <- flights |>
  mutate(
    gain = dep_delay - arr_delay, 
  )

flights_speed_in_hours <- flights_gain |>
  mutate(
    speed_in_hours = air_time / 60, na.rm = TRUE
  )

flights_gain_per_hour <- flights_speed_in_hours |>
  mutate(
    gain_per_hour = gain / speed_in_hours, na.rm = TRUE
  )
  
#In-class:

flights_delay_gain <- flights |>
  mutate(gain = dep_delay - arr_delay,
         speed = distance / (air_time / 60),
         gmh = gain/ (air_time/60), .keep = "used")

        