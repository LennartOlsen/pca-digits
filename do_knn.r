## Should be in own function, but R got me fucked up
require("class")
require("ggplot2")
source("multiplot.r")
doKnn <- function(train, test, train_labels, test_labels, range_k){
    ## TEST WITH MANY K's
    range <- range_k
    accs <<- rep(0, length(range))
    speeds <<- rep(0, length(range))
    
    for (k in range) {
        startTime <- Sys.time();
        print(startTime)
        #make predictions using knn: pred
        pred <- knn(train = train, test = test, cl=train_labels, k=k)
        
        #construct the confusion matrix: conf
        confidence <- table(test_labels, pred)
        
        #calculate the accuracy and store it in accs[k]
        accs[k] <- sum(diag(confidence)) / sum(confidence)
        
        endTime <- Sys.time()
        speeds[k] <- endTime - startTime
        print(k)
    }
    
    # Calculate the best k
    which.max(accs)
    
    plotspeed <- qplot(seq_along(speeds), speeds)+geom_point() + 
        geom_smooth(method="lm",formula = y ~ splines::bs(x,3), se=FALSE) +
        xlab("K Value") + 
        ylab("Time")
    
    plotacc <- qplot(seq_along(accs), accs)+geom_point() + 
        geom_smooth(method="lm",formula = y ~ splines::bs(x,3), se=FALSE) +
        xlab("K Value") + 
        ylab("Accuracy")
    multiplot(plotspeed, plotacc)
}