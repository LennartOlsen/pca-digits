###
# Generates PCA sets
###
require("stats")

getPCASet <- function(dataset) {
  ds = prcomp(dataset, center = TRUE, scale. = TRUE)
  #the sdev is the squareroot of the eigen values see (https://stat.ethz.ch/pipermail/r-help/2005-August/076610.html)
  
  return( ds )
} 