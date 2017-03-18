doSectionOne <- function(){
  pd <- loadEmAll(c(1,10,12), c(1,2), 100, "2017/")
  pid <- loadEmAll(c(12,10), c(1,2,3), 100, "2017/")
  
  pca_set_pid <- getPCASet(pid)
  pca_set_pd <- getPCASet(pd)
  
  #Plot shows influence/variance of each pca in the Y axis, the X axis shows the corrosponding PC. (like pc1, pc2 and so on)
  plot(pca_set_pid, type="l")
  plot(pca_set_pd, type="l")
  
  ###Accumulated variance
  accumulated_pid = 0
  accumulated_pd = 0
  sum_eigen = sum(pca_set_pid$sdev^2)
  for( i in 1:20) {
    pid_eigen = pca_set_pid$sdev[i]^2
    pd_eigen = pca_set_pd$sdev[i]^2
    accumulated_pid = (pid_eigen/ sum_eigen) + accumulated_pid
    accumulated_pd = (pd_eigen / sum_eigen) + accumulated_pd
  }
  
  ##
  ## KNN PERSON INDEPENDENT ##
  ##
  dataset <- data.frame(pid)
  set.seed(42)
  dataset_shuffle <- dataset[sample(nrow(dataset)),]
  minTest = nrow(dataset)*0.90
  maxTest = nrow(dataset)
  dataset_train_labels <- dataset_shuffle[1:minTest - 1,1]
  dataset_test_labels <- dataset_shuffle[minTest:maxTest,1]
  
  ### DO PCA ON DATA ###
  
  pid_knn <- getPCASet(dataset_shuffle)
  
  pid_train_xs <- pid_knn$x[1:minTest-1,]
  pid_test_xs <- pid_knn$x[minTest:maxTest,]
  
  ##doKnn <- function(train, test, train_labels, test_labels, range_k)
  doKnn(dataset_train, dataset_test, dataset_train_labels, dataset_test_labels, c(1:10))
  doKnn(pid_train_xs, pid_test_xs, dataset_train_labels, dataset_test_labels, c(1:10))
  
  
  ### Covering 80% variance
  c = 53
  pid_80_train <- pid_train_xs[,1:c]
  pid_80_test <- pid_test_xs[,1:c]
  doKnn(pid_80_train, pid_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  ### Covering 90% variance
  c = 105
  pid_80_train <- pid_train_xs[,1:c]
  pid_80_test <- pid_test_xs[,1:c]
  doKnn(pid_80_train, pid_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  
  ### Covering 95% variance
  c = 164
  pid_80_train <- pid_train_xs[,1:c]
  pid_80_test <- pid_test_xs[,1:c]
  doKnn(pid_80_train, pid_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  ### Covering 99% variance
  c = 251
  pid_80_train <- pid_train_xs[,1:c]
  pid_80_test <- pid_test_xs[,1:c]
  doKnn(pid_80_train, pid_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  
  
  
  
  ##
  ## KNN PERSON DEPENDENT ##
  ##
  dataset <- data.frame(pd)
  minTest = nrow(dataset)*0.75 ##amounts to one person, in this case member 1 from group 12 (ME)
  maxTest = nrow(dataset)
  
  dataset_test <- dataset[minTest:maxTest,2:ncol(dataset)]
  dataset_test_labels <- dataset[minTest:maxTest,1]
  
  dataset_train <- dataset[1:minTest - 1,2:ncol(dataset)]
  dataset_train_labels <- dataset[1:minTest - 1,1]
  
  ### DO PCA ON DATA ###
  pd_knn <- getPCASet(dataset)
  
  pd_train_xs <- pd_knn$x[1:minTest-1,]
  pd_test_xs <- pd_knn$x[minTest:maxTest,]
  
  ##doKnn <- function(train, test, train_labels, test_labels, range_k)
  doKnn(dataset_train, dataset_test, dataset_train_labels, dataset_test_labels, c(1:10))
  doKnn(pd_train_xs, pd_test_xs, dataset_train_labels, dataset_test_labels, c(1:10))
  
  
  ### Covering 80% variance
  c = 65
  pd_80_train <- pd_train_xs[,1:c]
  pd_80_test <- pd_test_xs[,1:c]
  results <- doKnn(pd_80_train, pd_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  ### Covering 90% variance
  c = 120
  pd_80_train <- pd_train_xs[,1:c]
  pd_80_test <- pd_test_xs[,1:c]
  doKnn(pd_80_train, pd_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  
  ### Covering 95% variance
  c = 176
  pd_80_train <- pd_train_xs[,1:c]
  pd_80_test <- pd_test_xs[,1:c]
  doKnn(pd_80_train, pd_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
  
  ### Covering 99% variance
  c = 256
  pd_80_train <- pd_train_xs[,1:c]
  pd_80_test <- pd_test_xs[,1:c]
  doKnn(pd_80_train, pd_80_test, dataset_train_labels, dataset_test_labels, c(1:10))
}