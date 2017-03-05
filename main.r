###
# Base PCA thingy
##
source('smooth_operator.r')
source('load_em_all.r')

require("stats")

#Fetches the person independtent data (i think) by accumulating all data into one set
group_10_12 <- loadEmAll(c(12,10), c(1), 200, "2017/")

#Fetches the person dependent data (i think) by creating a data set with just one person
group_12 <- loadEmAll(c(12), c(1), 200, "2017/")


#prcomp uses singular value decomposition not eigen values which the values required for task 1.2
pca_set_group_10_12 <- prcomp(group_10_12, center = TRUE,
            scale. = TRUE)

pca_set_group_12 <- prcomp(group_12, center = TRUE,
                              scale. = TRUE)

#Plot shows variance on the Y axis and the number of pcs on the X axis.
plot(pca_set_group_10_12, type="l")
plot(pca_set_group_12, type="l")