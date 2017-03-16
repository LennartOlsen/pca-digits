###
# Base PCA thingy
##
source('smooth_operator.r')
source('load_em_all.r')
source("pcagenerator.r")
source("get_covering_percentage.r")
source("do_knn.r")
source("cross_validation.r")

source("section1.r")


require("stats")

#Fetches the person independtent data (i think) by accumulating all data into one set
pid <- loadEmAll(c(12,10), c(1,2,3), 100, "2017/")

#Fetches the person dependent data (i think) by creating a data set with just one person
pd <- loadEmAll(c(12), c(1), 100, "2017/")


##
## KNN PERSON INDEPENDENT ##
##
dataset <- data.frame(pid)
set.seed(42)
dataset_shuffle <- dataset[sample(nrow(dataset)),]
cross_set <- dataset_shuffle[1:nrow(dataset),2:ncol(dataset)]
cross_set_labels <- dataset_shuffle[1:nrow(dataset),1]

cross_set =  (cross_set - min(cross_set))/
                    (max(cross_set) - min(cross_set))

cross_set_pid <- getPCASet(cross_set)

cross_set_pid_xs <- cross_set_pid$x

#doCross <- function(dataset, labels, range_k, folds){}
doCross(head(cross_set_pid_xs,106), head(cross_set_labels,106), c(1:10), c(1:10))
