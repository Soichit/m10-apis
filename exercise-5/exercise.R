### Exercise 5 ###
library(jsonlite)
library(dplyr)

# Write a function that allows you to specify a movie, then does the following:
  
MovieInfo <- function(my_movie) {
  # Replace all of the spaces in your movie title with plus signs (+)
  movie.no.spaces <- gsub(" ", "+", my_movie)
  
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  base.url <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  api.key <- "b02e7f32f95b4436a1d4f5b375c7be98"
  request <- paste0(base.url,"query=", movie.no.spaces, "&", "api-key=", api.key)

  # Request data using your search query
  movie.data <- fromJSON(request)
  
  # What type of variable does this return?
  View(movie.data)
  
  # Flatten the data stored in the `$results` key of the data returned to you
  movie.df <- as.data.frame(movie.data)
  flattened <- flatten(movie.df)
  View(flattened)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  headline <- flattened$results.headline
  summary <- flattened$results.summary_short
  link <- flattened$results.link.url
  
  # Return an list of the three pieces of information from above
  result <- list(headline=headline, summary=summary, link=link)
  return (result)
}

# Test that your function works with a movie of your choice
MovieInfo("The Matrix")
