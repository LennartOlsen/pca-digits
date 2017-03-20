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

pca_set_pid <- getPCASet(pid, TRUE, FALSE)

restr <- pca_set_pid$x[,1:250] %*% t(pca_set_pid$rotation[,1:250])

# unscale and uncenter the data
if(pca_set_pid$scale != FALSE){
  restr <- scale(restr, center = FALSE , scale=1/pca$scale)
}
if(all(pca_set_pid$center != FALSE)){
  restr <- scale(restr, center = -1 * pca_set_pid$center, scale=FALSE)
}

generateCipherImages(pid, c(0:9))