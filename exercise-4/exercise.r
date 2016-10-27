### Exercise 10-4 ###

# Install and load the jsonlite package
library(jsonlite)
library(dplyr)

# Make a variable base.url that has the same base url from the omdb documentation.
# (Hint: visit https://www.omdbapi.com/ to find the base url)
base.url <- 'http://www.omdbapi.com/?'

# Make a variable called movie that has the names of your favorite movie
movie <- "Lord of the Rings: The Fellowship of the Ring"

# Make a variable called movie.no.spaces that holds movie where all the spaces
# are replaced with the '+' character
movie.no.spaces <- gsub(" ", "+", movie)

# Make a variable called "parameters" that holds a string with the parameters
# to pass to the API. View the OMDb documentation to see which parameters
# are available. Remember to separate parameters with the '&' character.
parameters <- paste0('t=', movie.no.spaces, '&', 'r=json')

# Make a variable called request that is a string of a request URL made up of the base URL
# and the parameters string
request <- paste0(base.url, parameters)
print(request)

# Use fromJSON to retrieve JSON data from the omdb api using your request URL.
# Store the result in a variable called movie.data
movie.data <- fromJSON(request) 

# Make movie_data into a data frame using as.data.frame
movie.df <- as.data.frame(movie.data) 
View(movie.df)

# Write a function called Director that accepts a data frame of movie info and returns
# A vector of strings that states a movie and the director of said movie.
Director <- function(movie.df) {
  result <- paste(movie.df$Title, "was directed by", movie.df$Director)
  return (result)
}

# Call Director with your favorite movie, and assign it to the variable movie.director
movie.director <- Director(movie.df)
paste(movie.director)

  
# Bonus 

# Knowing the director of on movie is okay, but it'd be great to know the directors of different
# movies. 

# Start by making a vector of movies and save it to the variable movie.list
movie.list <- c("Inside Out", "Up", "Tangled", "The Matrix")

# Remove spaces from each movie title
list.no.spaces <- gsub(" ", "+", movie.list)
paste(list.no.spaces)

# Prepare this list to be passed in as parameters for the API
list.parameters <- paste0('t=', list.no.spaces, '&', 'r=json')
paste(list.parameters)

# Create API URL request and assign it to the variable api.request
api.request <- paste0(base.url, list.parameters)
print(api.request)

# For every entry in the vector api.request, APPLY the function fromJSON to make a list of lists
# one entry for each request and assign this to a variable called data. 
# (Hint: ?lapply. It's similar to a 'for' loop but better!)
data <- lapply(api.request, fromJSON)

# Using the function do.call, call rbind on each entry in data (check out the do.call documentation)
data.list <- do.call(rbind, data)

# Make sure movies is treated as a data frame by calling as.data.frame and assign that to movies.df
movies.list.df <- as.data.frame(data.list)
View(movies.list.df)

# Use your Director function to see who directed all these movies. Assign the result to movie.info
movie.info <- Director(movies.list.df)
print(movie.info)
# Create a variable called meta.scores which is a vector containing the Metascore column from movie.df
meta.scores <- movies.list.df$Metascore

# Create a variable called movie.titles which is a vector containing the Title column from movie.df
movie.titles <- movies.list.df$Title

# Once you finish the rest of the lab you can uncomment this next line for some sweet data viz
barplot(as.numeric(meta.scores), names.arg=as.vector(movie.titles), las=2)
