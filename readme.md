## PCA on handwritten digits
_This is excersise 2 of the Machine Learning Course on SDU (all excersises are completed with the 100dpi setting)_

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

Looking at the person dependt data gave quite different results, run times are through the roof, and results are shaky at best.

The baseline results, which is knn with a 75% split (the other 3 members), gave long running times, just below 6 minutes and bad prediction of around 40%.
This tells us that comparing handwriting from differnt persons is pretty difficult.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-baseline-pd.png "graph")

Moving on to our 80% coverage we see a slightly higher 44% accuracy and a run time at a lower 15 seconds pr k.
The accuracy is again rising on account of less noise, but in this case this could also be attributed to differences being filtered out, such as pen color, crosses in 7's and other things.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-80-pd.png "graph")

Working with 90% variance coverage gave worse results and even higher runtimes, this indicates a decline in accuracy from 80% and up, so that could mean that some features are being filtered out that are unnessecary for correct predictions.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-90-pd.png "graph")

The pattern presists in 95% variance aswell, also in the 99% variance. With 99% variance introducing a almost 4 minute runtime. This leads to a conclusion that 80% variance coverage is properly the best for person dependent data.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-95-pd.png "graph")
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/knn-99-pd.png "graph")

### Excersise 2.1-2.2

Using min-max normalization on PC's covering 90% of the variance (best results from previous) and applying KNN (1-10) in a 10 fold cross validation.

**Normalization Before PCA:**

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/cross-knn-90-before.png "graph")

**Normalization After PCA:**

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/cross-knn-90-after.png "graph")

Not much can be said about the results, it seems that they fetch a bit lower accuracy than the regular 90% cross validation, but this can also be attributed to the averageing of the results.

Whats most interresting is proberly the high similarity between the two suggesting that the normailization does not matter in PCA.

### Excersise 3.1

Images were recreated directly from the dataset that were scanned, no using PCA. The ciphers should be an "average" of the sum of all pixels that make up the given cipher.
The ciphers was extracted from my own scans, group12 member 1. Adding in more images (groups and members) makes this really difficult, and i honesly didnt know how to handle them.
What i can see from the images is that some distortion persists in the form of black line, this is very prominent in 9, this is due to distorted scans.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-0.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-1.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-2.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-3.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-4.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-5.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-6.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-7.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-8.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr12-direct-9.png "cipher")

### Excersise 3.2

Covering the 10 first loadings gives us some wierd images, i guess they are meant to point out the egdes of the images, but i really cant decode them.

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-0.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-1.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-2.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-3.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-4.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-5.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-6.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-7.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-8.png "cipher")![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/10-loadings-9.png "cipher")

### Excersise 3.3

I dont know if its due to me not adding other members of other groups but of course they show exactly the same as excersise 3.1 as they cover 100% of the variance

### Excersise 3.4

We see that even at 80% the images are still comprehensible as ciphers and can be fairly easily understood, we also see that the black bars from the mis scans are still there.
The compression should be descriped by dividing the number of PCs with the number of features originally requiered to generate the image:

**80%** requires 70 PCs that is 70/324 or ≈ 21,6% of the original size

**90%** requires 120 PCs that is 120/324 or ≈ 37,0% of the original size

**95%** requires 168 PCs that is 168/324 or ≈ 51,9% of the original size


### Excersise 3.5

** 10 First PCs  0 & 1 **

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr-12-pc10-0.png "cipher")
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr-12-pc10-1.png "cipher")

** All (324) PCs  0 & 1 **

![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr-12-pc324-0.png "cipher")
![alt-text](https://github.com/LennartOlsen/pca-digits/blob/master/images/gr-12-pc324-1.png "cipher")