require("EBImage")

smoothImage <- function(grayImg){
    
    kernel <- makeBrush(21, shape="Gaussian")
    
    smoothed <- filter2(grayImg, kernel)
    
    return(smoothed)
}