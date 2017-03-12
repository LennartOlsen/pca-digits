###
# Base PCA thingy
##
source('smooth_operator.r')
source('load_em_all.r')
source("pcagenerator.r")
source("get_covering_percentage.r")
source("do_knn.r")

require("stats")

#Fetches the person independtent data (i think) by accumulating all data into one set
pid <- loadEmAll(c(12,10), c(1,2,3), 100, "2017/")

#Fetches the person dependent data (i think) by creating a data set with just one person
pd <- loadEmAll(c(12), c(1), 100, "2017/")

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
dataset_train <- dataset_shuffle[1:minTest - 1,2:ncol(dataset)]
dataset_test <- dataset_shuffle[minTest:maxTest,2:ncol(dataset)]
dataset_train_labels <- dataset_shuffle[1:minTest - 1,1]
dataset_test_labels <- dataset_shuffle[minTest:maxTest,1]

### DO PCA ON DATA ###

pid_test <- getPCASet(dataset_test)
pid_train <- getPCASet(dataset_train)

pid_test_xs <- pid_test$x
pid_train_xs <- pid_train$x

##doKnn <- function(train, test, train_labels, test_labels, range_k)
doKnn(dataset_train, dataset_test, dataset_train_labels, dataset_test_labels, c(1:10))
doKnn(pid_train_xs, pid_test_xs, dataset_train_labels, dataset_test_labels, c(1:10))


### Covering 80% variance
c = 53
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))

### Covering 90% variance
c = 106
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))


### Covering 95% variance
c = 165
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))

### Covering 99% variance
c = 252
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))





##
## KNN PERSON DEPENDENT ##
##
dataset <- data.frame(pd)
set.seed(42)
dataset_shuffle <- dataset[sample(nrow(dataset)),]
minTest = nrow(dataset)*0.90
maxTest = nrow(dataset)
dataset_train <- dataset_shuffle[1:minTest - 1,2:ncol(dataset)]
dataset_test <- dataset_shuffle[minTest:maxTest,2:ncol(dataset)]
dataset_train_labels <- dataset_shuffle[1:minTest - 1,1]
dataset_test_labels <- dataset_shuffle[minTest:maxTest,1]

### DO PCA ON DATA ###
pid_test <- getPCASet(dataset_test)
pid_train <- getPCASet(dataset_train)

pid_test_xs <- pid_test$x
pid_train_xs <- pid_train$x

##doKnn <- function(train, test, train_labels, test_labels, range_k)
doKnn(dataset_train, dataset_test, dataset_train_labels, dataset_test_labels, c(1:10))
doKnn(pid_train_xs, pid_test_xs, dataset_train_labels, dataset_test_labels, c(1:10))


### Covering 80% variance
c = 70
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
results <- doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))

### Covering 90% variance
c = 120
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))


### Covering 95% variance
c = 169
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))

### Covering 99% variance
c = 246
pid_80_train <- matrix(pid_train_xs[1:c])
pid_80_test <- matrix(pid_test_xs[1:c])
doKnn(pid_80_train, pid_80_test, dataset_train_labels[1:c], dataset_test_labels[1:c], c(1:10))