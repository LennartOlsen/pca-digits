##PCA on handwritten digits
_This is excersise 2 of the Machine Learning Course on SDU (all excersises are completed with the 100dpi setting)_

Exercises :
> 1.1 Perform a PCA on the data for the person dependent and the person independent data set. 

> 1.1.1 Show the Eigenvalues ( std ), variance and the accumulated variance of the principal components. (In the report 10-20 values equally distributed, should be sufficient to illustrate the tendencies.) 

> 1.2 Show the performance of selecting enough principal components to represent 80%, 90%, 95%, 99% of the accumulated variance. For each test vary K.

> 1.3 Measure run times for the prediction step of the KNN-classifier with PCA based dimensionality reduction.

> 1.4 Interpret the results.

###Excersise 1.1 & 1.1.1
The following graphs show the influence/variance (the y axis) for the first 10pcs (the x axis).
Graph pca_set_group_10_12 hows the data for the person independent data set, this includes all memebers of group 10 and 12.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/pca_set_pid.png "graph")
Graph pca_set_group_10 shows the data for the person dependent data set, this includes member 1 of group 12
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/pca_set_pd.png "graph")

#####Summaries (cover 0-20 in descendingly ordered)
**Eigen Values :**

Person Dependent :

|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.30    |21.65    |29.36    |34.66    |40.97    |83.28    |

Person Independent :

|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.27    |23.81    |31.11    |40.56    |40.75    |124.50   | 

**Accumulated variance**

Person Dependent :
> 0.4796575

Person Independent :
> 0.5613603

###Excersise 1.2-1.4
* Performance seems to be odd in all results. *

First off lets look at the baseline for the person independent data, the baseline is just a KNN prediction as done in previous tasks with a 90% split.
We see that the performance is the same as earlier tests. Once again the speeds cannot be trusted, but used as a guideline.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-baseline-pid.png "graph")

Going on to testing a 100% variance with KNN, which means all our PCs. 
We see that we get a accuracyof about 20% which indicates that there is some problems with my algorithm.
We do see that the time performance is roughly the same as the baseline.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-100-pid.png "graph")

Working on with on to 80% variance coverage (which is around 53 PCs) we see that our accuracy again is around 16% which is very low, though compared to my full coverage test 100% variance we see that we see that our performance is rougly 4% lower which compares nicely to the 20% difference between the two.
But we see that our compression have done wonders in computation time
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-80-pid.png "graph")

Working with 90% variance we see a slight increase in accuracy to 20%.
We see that the run time is still low, and thats good.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-90-pid.png "graph")

Skipping past 95% and on to 99% we see thar our performance is lower and our compute times raises a bit, 99% variance is covered by the first 252 PCs.
This once again might indicate that something is very wrong with my algorithm.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-99-pid.png "graph")


** Restults are the same for person dependent data see https://github.com/LennartOlsen/pca-digits/blob/master/images/ for more graphs **
