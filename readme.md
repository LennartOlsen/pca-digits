##PCA on handwritten digits
_This is excersise 2 of the Machine Learning Course on SDU_

Exercises :
> 1.1 Perform a PCA on the data for the person dependent and the person independent data set.
> 1.1.1 Show the Eigenvalues, variance and the accumulated variance of the principal components. (In the report 10-20 values equally distributed, should be sufficient to illustrate the tendencies.)
> 1.2 Show the performance of selecting enough principal components to represent 80%, 90%, 95%, 99% of the accumulated variance. For each test vary K.
> 1.3 Measure run times for the prediction step of the KNN-classifier with PCA based dimensionality reduction.
> 1.4 Interpret the results.

###Excersise 1.1 & 1.1.1
The following graphs show the influence/variance (the y axis) for the first 10pcs (the x axis).
Graph pca_set_group_10_12 hows the data for the person independent data set, this includes all memebers of group 10 and 12.
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/pca_set_group_10_12.png "graph")
Graph pca_set_group_10 shows the data for the person dependent data set, this includes member 1 of group 12
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/pca_set_group_12.png "graph")

#####Summaries (cover 0-20 in descendingly ordered)
**Eigen Values :**

Group 12 : 
|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.30    |21.65    |29.36    |34.66    |40.97    |83.28    |

Group 10 & 12 :
|Min.     |1st Qu.  |Median   |Mean     |3rd Qu.  |Max.     |
|---------|---------|---------|---------|---------|---------|
|17.27    |23.81    |31.11    |40.56    |40.75    |124.50   | 

**Accumulated variance**

Group 12 :
> 1445

Group 10 & 12 :
> 1445