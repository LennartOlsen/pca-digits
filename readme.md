## PCA on handwritten digits
_This is excersise 2 of the Machine Learning Course on SDU (all excersises are completed with the 100dpi setting)_

Exercises :
> 1.1 Perform a PCA on the data for the person dependent and the person independent data set. 

> 1.1.1 Show the Eigenvalues ( std ), variance and the accumulated variance of the principal components. (In the report 10-20 values equally distributed, should be sufficient to illustrate the tendencies.) 

> 1.2 Show the performance of selecting enough principal components to represent 80%, 90%, 95%, 99% of the accumulated variance. For each test vary K.

> 1.3 Measure run times for the prediction step of the KNN-classifier with PCA based dimensionality reduction.

> 1.4 Interpret the results.

> 2.1 Perform one of the two normalizations suggested in the lecture (min-max normalization and z-score standardization) for the best parameter setting found under 1.3 and apply KNN with 10 fold cross-validation (10 runs, 90% training and 10% test set). Apply the normalization before and after PCA independently and compare the results.

> 2.2 Analyse the results

> 3.1 This task is about reconstructing data using PCA. First using these functions we can plot an image of a single cipher:
*imageSize <- sqrt(ncol(id) - 1)
*imageM <- matrix( id[cipherNumber,2:ncol(id)],nrow = imageSize,ncol = imageSize,byrow = FALSE)
*imageM <- rotate(imageM) # rotate is a function to rotate the image
*image( imageM )
Try plotting one of each cipher.

> 3.2 Try plotting the first 10 eigenvectors/loadingvectors as images. Can you describe what you see?

> 3.3 Try plotting a reconstruction of the images you displayed in 3.1 using all PC’s. This can be done by multiplying the loadings with the scores and adding the removed centering.
* ```trunc <- pca_res$x[cipherNumber,1:nrow(pca_res$rotation)] %*%t(pca_res$rotation[,1:nrow(pca_res$rotation)])```
* ```trunc <- scale(trunc, center = -1 * pca_res$center, scale=FALSE)```

>3.4 Now try re-recreating using 80% of variance, 90% and 95%.
  1. Can you describe what you see?
  2. How much have you reduced the data size?
  
>3.5. Lastly take two different ciphers and compare the 10 first scores and see if you can see a difference. Try also this were you take the mean for all 400 of these ciphers and compare the first 10 scores

### Excersise 1.1 & 1.1.1
The following graphs show the influence/variance (the y axis) for the first 10pcs (the x axis).
Graph pca_set_group_10_12 hows the data for the person independent data set, this includes all memebers of group 10 and 12.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/pca_set_pid.png "graph")
Graph pca_set_group_10 shows the data for the person dependent data set, this includes member 1 of group 12
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/pca_set_pd.png "graph")

##### Summaries (cover 0-20 in descendingly ordered)
**Eigen Values :**

Person Dependent :

|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.30    |21.65    |29.36    |34.66    |40.97    |83.28    |

Person Independent : (Data slightly incorrect)

|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.27    |23.81    |31.11    |40.56    |40.75    |124.50   | 

**Accumulated variance**

Person Dependent :
> 0.4796575

Person Independent :
> 0.5613603

### Excersise 1.2-1.4
**Person independent data is based on the aggregated result set of groups 10 and 12**

Going on to testing a 100% variance with KNN, which means all our PCs. 
We see an accuracy of 90% with K=1, which in turn means that for some reason if we only select our 1 nearest neighbour we are getting the best results.
Consindering run times (in this case minutes) we see that they are over 1 minute pr iteration.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-100-pid.png "graph")

Working on with on to 80% variance coverage (which is the first 53 PCs), interrestingly we get almost the same score here, meaning that our data may contain a lot of noise which is filtered out by PCA.
We see that run times are very low, at around 4 seconds for each K.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-80-pid.png "graph")

Covering 90% variance we see a slight increase in accuracy and actually even lower run times, this could be down to computer stress levels and throtteling of cpu performance, but this is still remarkable.
90% variance coverage has given me the best performance in terms of both accuracy and run times.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-90-pid.png "graph")

95 and 99% coverage proved to give higher run times and slightly lower performance, this is properly due to the noise in the images being part of the knn. Interestingly we see that we need almost 100 more PCs to go from 95 to 99% coverage (from 164 to 251), thats almost one third of the PCs (324) to cover the entire dataset, this tells us that very little data is in the last 150 pcs furthermore we see that we can easily manage with only half the data cutting our runtimes to less than a tenth of running knn on all of our data

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-95-pid.png "graph")
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-99-pid.png "graph")


**Person dependent data based on my self (group 12 member 1) vs group 10 and 1 (member 1 and 2)**

Looking at the person dependt data gave quite different results, run times are through the fucking roof, and results are shaky at best.

The baseline results, which is knn with a 75% split (the other 3 members), gave long running times, roughly 6 minutes and bad prediction of around 40%.
This tells us that comparing handwriting from differnt persons is pretty difficult.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-baseline-pd.png "graph")

Moving on to our 80% coverage we see a slightly higher 44% accuracy and a run time at a lower 15 seconds pr k.
The accuracy is again rising on account of less noise, but in this case this could also be attributed to differences being filtered out, such as pen color, crosses in 7's and other things.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-80-pd.png "graph")

Working with 90% variance coverage gave worse results and even higher runtimes, this indicates a decline in accuracy from 80% and up, so that could mean that some features are being filtered out that are unnessecary for correct predictions.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-90-pd.png "graph")

The pattern presists in 95% variance aswell
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-95-pd.png "graph")

### Excersise 2.1-2.2

> 2.1 Perform one of the two normalizations suggested in the lecture (min-max normalization and z-score standardization) for the best parameter setting found under 1.3 and apply KNN with 10 fold cross-validation (10 runs, 90% training and 10% test set). Apply the normalization before and after PCA independently and compare the results.

Using min-max normalization on PC's covering 90% of the variance (best results from previous) and applying KNN in a 10 fold cross validation.

**Normalization Before:**
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/cross-knn-90-before.png "graph")

**Normalization After:**
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/cross-knn-90-after.png "graph")

#### Analysis

