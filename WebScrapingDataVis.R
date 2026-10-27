library(tidyverse)
library(rvest)
library(httr2) #"no package called httr2" - installed
library(jsonlite)
library(purrr)
library(dplyr)
library(tidytuesdayR)
   
tuesdata <- tidytuesdayR::tt_load('2026-03-31') 

#--- Set up datasets---
ocean_temperature <- tuesdata$ocean_temperature
ocean_temperature_deployments <- tuesdata$ocean_temperature_deployments

# Create a new dataset that merges the two
ocean_temp <- cross_join(ocean_temperature, ocean_temperature_deployments, copy = FALSE) |>
  filter(date >= start_date, date <= end_date) #object 'end_date' not found

#--------Let's look at the data-----
library(ggplot2)

ggplot(ocean_temp) +
  geom_area(mapping=aes(mean_temperature_degree_c, date, colour = deployment_id))

#change date to x-axis and temperature to y-axis
ggplot(ocean_temp) +
  geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id))

#-----Let's make the colours more smooth----
ggplot(ocean_temp) +
  geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id, fill = deployment_id))
