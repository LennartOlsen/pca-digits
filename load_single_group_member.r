##
# Optimized version of the load image function provided by TA
##
library("png")

loadSinglePersonsData <- function(DPI,groupNr,groupMemberNr,folder){
    #load the scaned images
    
    if(!file.exists(paste(c(folder,groupNr,"/member",groupMemberNr,"/Corners.txt"), collapse = ""))){
        return(FALSE)
    }
    
    ciffers <- list(readPNG(paste(c(folder,groupNr,"/member",groupMemberNr,"/Ciphers",DPI,"-0.png"), collapse = "")),
                    readPNG(paste(c(folder,groupNr,"/member",groupMemberNr,"/Ciphers",DPI,"-1.png"), collapse = "")),
                    readPNG(paste(c(folder,groupNr,"/member",groupMemberNr,"/Ciphers",DPI,"-2.png"), collapse = "")),
                    readPNG(paste(c(folder,groupNr,"/member",groupMemberNr,"/Ciphers",DPI,"-3.png"), collapse = "")),
                    readPNG(paste(c(folder,groupNr,"/member",groupMemberNr,"/Ciphers",DPI,"-4.png"), collapse = "")))
    #load the corner values
    corners <- read.csv(paste(c(folder,groupNr,"/member",groupMemberNr,"/Corners.txt"), collapse = ""))
    corners <- trunc(corners*DPI/300)
    #print(corners)
    
    #define lists to be used
    #  gray <- list(1:5)
    #   smoothed <- list(1:5)
    prepared <- list(1:5)
    
    
    #convert the images to gray scale.
    for(i in 1:5)
    {
        r <-ciffers[[i]][,,1]
        g <-ciffers[[i]][,,2]
        b <-ciffers[[i]][,,3]
        prepared[[i]] <- (r+g+b)/3
    }
    
    #smooth images based on the funtion in the top
    for(i in 1:5)
    {
        prepared[[i]] <- smoothImage(prepared[[i]])
    }  
    
    #extract individual ciffers
    #xStep and yStep is used to ensure the first corner of the
    #individual ciffers are placed fairly accurate
    xStep  <- (corners[1,7]-corners[1,1])/20;
    yStep  <- (corners[1,8]-corners[1,2])/20;
    
    #xStepT and yStepT is used to ensure that the feature vectors
    #from all people have the same size.
    xStepT <- 60*DPI/300
    yStepT <- 60*DPI/300
    
    dataMatrix <- matrix(1:((xStepT-2)*(yStepT-2) + 1)*10*20*20, nrow=10*20*20, ncol=(xStepT-2)*(yStepT-2) + 1)
    
    for(pages in 1:5)
    {
        for(box in 1:2)
        {
            for(cifX in 1:20)
            {
                aXbase <- corners[(pages-1)*2 + box,1] + xStep*(cifX-1)
                for(cifY in 1:20)
                {
                    aYbase <- corners[(pages-1)*2 + box,2] + yStep*(cifY-1)
                    
                    dataMatrix[((pages-1)*2 + box - 1)*20*20 + (cifY-1)*20 + cifX ,1 ] <- (pages-1)*2 + box - 1
                    
                    for(px in 1:(xStepT-2))
                    {
                        for(py in 1:(yStepT-2))
                        {
                            #here things are read in
                            dataMatrix[((pages-1)*2 + box - 1)*20*20 + (cifY-1)*20 + cifX ,1 + (px-1)*(yStepT-2) + py ] <- prepared[[pages]][aYbase+py+1,aXbase+px+1]
                            
                        }
                    }
                }
            }
        }
    }
    
    return(dataMatrix)
}