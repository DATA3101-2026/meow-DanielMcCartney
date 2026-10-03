library(tidyverse)
library(dplyr)
library(nycflights13)

flights

tidyverse #not loading, says object 'tidyverse' not found
glimpse(tidyverse) #not loading, says object 'tidyverse' not found
?tidyverse #not loading, says object 'tidyverse' not found

glimpse(flights)
?flights
View(flights)

filter(flights, dest == "LAX")
filter(flights, dest == "YYZ") #None showing, no flights to Toronto?
filter(flights, dest == "BUF")

data.frame("flights_delay_180") #did not work

flights_delay_180 <- data.frame() 

jan1 <- flights |>
  filter(month == 1 & day == 1)

filter(flights, dep_delay > 3) #108,699 flights had a departure delay longer than 3 hours.

filter(flights, month == 9, day == 17) #961 flights departed on September 17, 2013.

arrange(flights, dep_time)

flights |> 
  arrange(desc(dep_delay)) #The longest departure delay was 1301 hours.


flights |> 
  distinct() #There are not any duplicate rows.

flights |> 
  distinct(origin, dest) #There are 224 unique origin and destination pairs in this data frame.

flights |>
  rename(destination = dest) #Renamed the "dest" column to "destination" to clarify what the column represents in case there was some confusion.



###ASSIGNMENT 2b###



#The next lines of code answer exercise 3.2.5 question 5.

flights |>
  relocate(distance) |>
  arrange(desc(distance)) #Arranged and relocated distance in descending order to determine how far the longest flights were, which ended up being 4983 kilometres long.

flights |>
  relocate(distance) |>
  arrange(distance) #Arranged distance in ascending order to determine how short the shortest flight was, which ended up being 17 kilometres.


#The next lines of code answer exercise 3.3.5 question 6.

flights |>
  rename(air_time_min = air_time) |> #Renamed air_time to air_time_min to indicate units of measurement.
  relocate(air_time_min) #Moved air_time_min to the front, didn't need to specify since relocate() moves variables to the front by default.

#At first, I was getting stuck with trying to use multiple lines of code to do each task, but then I found out using the pipe could help me with doing everything in a more condensed format.
