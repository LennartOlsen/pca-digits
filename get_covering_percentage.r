###
# Returning All the PC's until we are at a given percentage
###

## Requires $eigen in the dataset
getCoveringPercentage <- function(dataset, percentage) {
  p = percentage / 100
  accumulated = 0.0001
  i <- 0
  retval = c()
  print(accumulated)
  print(p)
  while( accumulated < p ){
    retval = c(dataset[i], accumulated)
    accumulated = (dataset$eigen[i] / sum(dataset$eigen)) + accumulated
    i = i + 1
  }
  return(retval)
}
