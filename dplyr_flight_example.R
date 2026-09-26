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


