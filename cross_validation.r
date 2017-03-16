## Should be in own function, but R got me fucked up
require("class")
require("ggplot2")
source("multiplot.r")
doCross <- function(dataset, labels, range_k, folds){
    ## TEST WITH MANY K's
    range <- range_k
    accs_cross <<- rep(0, length(range))
    speeds_cross <<- rep(0, length(range))
    sds_cross <<- rep(0, length(range))
    
    for (k in range) {
        acc <- NULL
        startTime <- Sys.time()
        for(fold in folds){
            minTest <- (fold - 1) *nrow(dataset)/max(folds)
            maxTest <- (fold) * nrow(dataset)/max(folds)
            subset.test <- dataset[ minTest : maxTest, ]
            subset.test.labels  <- labels[ minTest: maxTest]
            
            #BUILD train SET
            subset.train <- dataset[0 : minTest, ]
            subset.train <- rbind(subset.train, dataset[maxTest : nrow(dataset),])
            subset.train.labels <- labels[0 : minTest]
            subset.train.labels <- c( subset.train.labels, labels[maxTest : nrow(dataset)])
            
            #make predictions using knn: pred
            pred <- knn(subset.train, subset.test, cl = subset.train.labels, k = k)
            
            #construct the confusion matrix: conf
            conf <- table(subset.test.labels, pred)
            #calculate the accuracy and store it in accs[k]
            acc <- c(acc, sum(diag(conf)) / sum(conf) )
            print(fold)
        }
        endTime <- Sys.time()
        speeds_cross[k] <- endTime - startTime
        sds_cross[k] <<- sd(acc)
        accs_cross[k] <<- mean(acc)
        print(k)
    }
    
    print('finito')
    # Calculate the best k
    which.max(accs_cross)
    
    plotspeed <- qplot(seq_along(speeds_cross), speeds_cross) + 
        geom_point() + 
        geom_smooth(method="lm",formula = y ~ splines::bs(x,3), se=FALSE)+ 
        xlab("K Value") + 
        ylab("Time")
    
    plotacc <- qplot(seq_along(accs_cross), accs_cross, geom = "line" ) +
        geom_errorbar(aes(x=seq_along(accs_cross), ymin=accs_cross-sds_cross, ymax=accs_cross+sds_cross), width=0.1, alpha= I(1/2)) + 
        xlab("K Value") + 
        ylab("Accuracy")
    
    multiplot(plotspeed, plotacc)
}