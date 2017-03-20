section2 <- function() {
  
  #Fetches the person dependent data (i think) by creating a data set with just one person
  pd <- loadEmAll(c(12), c(1), 100, "2017/")
  
  ##
  ## KNN PERSON DEPENDENT AFTER : ##
  ##
  dataset <- data.frame(pd)
  set.seed(42)
  dataset_shuffle <- dataset[sample(nrow(dataset)),]
  cross_set <- dataset_shuffle[1:nrow(dataset),2:ncol(dataset)]
  cross_set_labels <- dataset_shuffle[1:nrow(dataset),1]
  
  cross_set_pd <- getPCASet(cross_set)
  
  cross_set_pd_xs <- cross_set_pd$x
  
  cross_set_pd_xs =  (cross_set_pd_xs - min(cross_set_pd_xs))/
    (max(cross_set_pd_xs) - min(cross_set_pd_xs))
  
  #doCross <- function(dataset, labels, range_k, folds){}
  doCross(cross_set_pd_xs[,1:120], cross_set_labels, c(1:10), c(1:10))
}