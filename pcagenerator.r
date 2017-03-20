###
# Generates PCA sets
###
require("stats")

getPCASet <- function(dataset, filterOutLabels=TRUE, reappendLabels=FALSE) {
  ## Filter out the first one due to it being the label
  if(filterOutLabels){
    ds = prcomp(dataset[,2:ncol(dataset)], center = TRUE, scale. = TRUE)
  } else {
    ds = prcomp(dataset, center = TRUE, scale. = TRUE)
  }
  #the sdev is the squareroot of the eigen values see (https://stat.ethz.ch/pipermail/r-help/2005-August/076610.html)
  
  return( ds )
} 