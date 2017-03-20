###
# Base PCA thingy
##
source('smooth_operator.r')
source('load_em_all.r')
source("pcagenerator.r")
source("get_covering_percentage.r")
source("do_knn.r")
source("cross_validation.r")
source("generate_cipher_images.r")

source("section1.r")


require("stats")


pid <- loadEmAll(c(12), c(1,2,3), 100, "2017/")

##
# 3.1 Image recall
##

##3.1 This task is about reconstructing data using PCA. First using these functions we can plot an image of a single cipher:
## *imageSize <- sqrt(ncol(id) - 1)
## *imageM <- matrix( id[cipherNumber,2:ncol(id)],nrow = imageSize,ncol = imageSize,byrow = FALSE)
## *imageM <- rotate(imageM) # rotate is a function to rotate the image
## *image( imageM )
# Try plotting one of each cipher.

generateCipherImages(pid, c(0:9))

####
# 3.2 image
###

pca_set_pid <- getPCASet(pid, TRUE)

generateCipherFromPcaImages(pca_set_pid, c(0:9), 10)