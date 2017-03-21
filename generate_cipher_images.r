###
# Requires dataset that INCLUDES the label
# Ciphers indicates the ciphers that itll print (0-9)
###
generateCipherImages <- function(dataset, ciphers){
  for(cipher in ciphers) {
    idx = (cipher * (nrow(dataset) / 10)) + 1
    imageSize = sqrt(ncol(dataset) - 1)
    imageMatrix <- matrix( dataset[idx:idx + 399,2:ncol(dataset)], nrow = imageSize, ncol=imageSize, byrow= FALSE)
    imageMatrix <- rotate(imageMatrix, 270)
    image(imageMatrix, col=gray((0:255)/255))
  }
}

generateCipherFromPcaImages <- function(dataset, ciphers, howManyPCs){
  
  restr <- dataset$x[,1:howManyPCs] %*% t(dataset$rotation[,1:howManyPCs])
  
  # unscale and uncenter the data
  if(dataset$scale != FALSE){
    restr <- scale(restr, center = FALSE , scale=1/dataset$scale)
  }
  if(all(dataset$center != FALSE)){
    restr <- scale(restr, center = -1 * dataset$center, scale=FALSE)
  }
  
  for(cipher in ciphers) {
    idx = (cipher * (nrow(dataset$x) / 10)) + 1
    imageSize = sqrt(ncol(dataset$x))
    imageMatrix <- matrix( restr[idx:idx+399,1:ncol(restr)], nrow = imageSize, ncol=imageSize, byrow= FALSE)
    imageMatrix <- rotate(imageMatrix, 270)
    image(imageMatrix, col=gray((0:255)/255))
  }
}

generateCipherFromLoadings <- function(dataset, ciphers, howManyLoadings){
  
  # unscale and uncenter the data
  
  for(cipher in ciphers) {
    idx = (cipher * (nrow(dataset$rotation) / 10)) + 1
    print(idx)
    imageSize = sqrt(ncol(dataset$x))
    imageMatrix <- matrix( dataset$rotation[0:36,1:howManyLoadings], nrow = imageSize, ncol=imageSize, byrow= FALSE)
    imageMatrix <- rotate(imageMatrix, 270)
    image(imageMatrix, col=gray((0:255)/255))
  }
}