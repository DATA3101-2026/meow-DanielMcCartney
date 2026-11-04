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

#----Add in clear titles and x and y labels-----
ggplot(ocean_temp) +
  geom_area(mapping=aes(date, mean_temperature_degree_c, colour = deployment_id, fill = deployment_id)) + 
  labs(
    title = "Birchy Cove Ocean Temperatures",
    subtitle = "Data sourced from TidyTuesday",
    x = "Date", 
    y = "Mean Temperatre (deg. C)"
  )

#------Filter data into one deployment ID-----
deployment_id_filter <- ocean_temp %>%
  filter(deployment_id %in% c("depl_08"))

#------Create a line plot of depl_08 for temperature over time with a cyan line colour and proper labels------
ggplot(deployment_id_filter, aes(x = date, y = mean_temperature_degree_c)) +
  geom_smooth(color = "cyan", linewidth = 1) +
  geom_point(size = 1) +
  labs(
    title = "Deployment 08's temperature over time",
    subtitle = "Line plot showing deployment 08's 
    mean temperature over time",
    x = "Time",
    y = "Mean Temperature (deg. C)",
    caption = "Data source: TidyTuesday"
  )

#------Filter ocean_temp data into a different deployment ID------
deployment_id_filter_2 <- ocean_temp %>%
  filter(deployment_id %in% c("depl_02"))

#-------Create a plot showing mean temperature as a red line------
ggplot(deployment_id_filter_2, aes(x = date, y = mean_temperature_degree_c)) +
  geom_smooth(color = "red", linewidth = 1) +
  geom_point(size = 0) +
  geom_errorbar(aes(
    ymin = mean_temperature_degree_c - sd_temperature_degree_c,
    ymax = mean_temperature_degree_c + sd_temperature_degree_c
    ), width = 0.1, size = 0.1) +
  labs(
    title = "Deployment 02's temperature over time",
    subtitle = "Line plot showing deployment 02's 
    mean temperature over time with error bars",
    x = "Time",
    y = "Mean Temperature (deg. C)",
    caption = "Data source: TidyTuesday"
  )

    
