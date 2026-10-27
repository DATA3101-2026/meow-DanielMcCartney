library(tidyverse)
library(rvest)
library(httr2) #"no package called httr2" - installed
library(jsonlite)
library(purrr)
library(dplyr)

link <- "https://en.wikipedia.org/wiki/List_of_counties_of_Nova_Scotia"
page <- read_html(link)

novaScotiaCounties <- data.frame(page |>
                          html_element("table.wikitable.sortable") |>
                          html_table())

#Bring in the table of county names in NS to a df called nsc
nsc <- data.frame(page |>
       html_element("table.wikitable.sortable") |>
       html_table())

library(knitr)
kable(nsc, caption = "Table scraped from Wikipedia for class, showing
a list of the counties in Nova Scotia, Canada.")

colnames(nsc)

# Let's clean up the 2021 population name
names(nsc)[names(nsc) == 'Population.2021..7.'] <- 'Population_2021' # What are these square brackets for? - selecting, doing name change

#----What if we want to see which population number is biggest?----

#sc$Population_2021 <- as.numeric(as.character(nsc$Population_2021)) #NAs introduced by coercion, commas do not count as numbers

nsc$Population_2021 <- gsub(",","", nsc$Population_2021) # Remove comma so that there are only numbers in the columns, gsub "substitutes"
nsc$Population_2021 <- as.numeric(as.character(nsc$Population_2021)) # How does it work now?

max(nsc$Population_2021) #Gives NA value, supposed to give 'Total counties' value - 969,383

#Showing different ways to display the same number of max county population
max(nsc$Population_2021[1:18]) #First way to select: positive selection range
max(nsc$Population_2021[-19]) #Second way, removing a row explicitly
    