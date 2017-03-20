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