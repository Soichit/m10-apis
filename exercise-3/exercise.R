### Exercise 10-3 ###
library(jsonlite)
library(dplyr)

setwd("C:/Users/Soichi/documents/info201/m10-apis/exercise-3")


# Use the `load` function to load in the nelly_tracks file.  That should make the data.frame
# `top.nelly` available to you
load('nelly_tracks.Rdata')
View(top.nelly)

# Use the `flatten` function to flatten the data.frame -- note what differs!
flattened <- flatten(top.nelly)
View(flattened)


# Use your `dplyr` functions to get the number of the songs that appear on each album
num.album <- flattened %>%
             group_by(album.name) %>%
             summarise(n=n()) %>%
             arrange(-n)
View(num.album)


# Bonus: perform both of the steps above in one line (one statement)
