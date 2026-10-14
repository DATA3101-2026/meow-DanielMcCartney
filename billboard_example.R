library(tidyverse)
library(dplyr)
library(billboard)
library(tidyr)

billboard

#---- Step 1: Look at the data----
billboard <- billboard


#----- test out pivot_longer-----
bb_long <- billboard |> pivot_longer(
  cols = starts_with("wk"), # taking columns from billboard that start with "wk" to transform.
  names_to = "week",
  names_prefix = "wk",
  names_transform = as.integer,
  values_to = "rank",
  values_drop_na = TRUE,
)

#-------Step 2: first example of ggplot2
ggplot(data = bb_long,
       mapping = aes(x =week, y = rank, colour = artist)) + geom_point()

#---------Make a dataset with just three of the top songs (Bye, Bye, Bye, Kryptonite, With Arms Wide Open)

example_songs <- bb_long %>%
  filter(track %in% c("Bye Bye Bye", "Kryptonite", "With Arms Wide Open"))

#------- Plot using more ggplot tools
ggplot(example_songs, aes(x = week, y = rank, group = track, color = track)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  #Reverse the Y-axis, ranks start at the very top of the graph, like places in a race
  scale_y_reverse(breaks = c(1, 10, 20, 50, 100)) +
  #Look into color brewer
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Billboard Hot 100 Performance in 2000",
    subtitle = "Weekly billboard place of selected hit singles",
    x = "Weeks on Chart",
    y = "Chart Rank (Top is Higher)",
    color = "Song Title",
    caption = "Data Source: tidyr::billboard"
  )
