Codebook
========
Codebook was generated on 2015-07-21 09:39:59.

Variable list and descriptions
------------------------------

Variable name       | Description
--------------------|---------------------------------------------------------------------------------
Subject             | The ID number of the individual performing the activity. Range: 1 to 30
ActivityNum         | The ID of the activity. Range 1 to 6.
ActivityName        | The descriptive name of the activity.
FeatureCode         | The feature code - this is the feature name from the original dataset
FeatureName         | The description of the feature - this is derived from the FeatureCode
Average             | The average measurement for the particular feature, activity and subject
------------------------------------------------------------------------------------------------------

Dataset structure
-----------------


```r
str(dtTidyDataset)
```

```
## Classes 'data.table' and 'data.frame':	11880 obs. of  6 variables:
##  $ Subject     : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ ActivityNum : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ ActivityName: chr  "WALKING" "WALKING" "WALKING" "WALKING" ...
##  $ FeatureCode : chr  "fBodyAcc-mean()-X" "fBodyAcc-mean()-Y" "fBodyAcc-mean()-Z" "fBodyAcc-std()-X" ...
##  $ FeatureName : chr  "Frequency: Body-Acceleration-Mean: X-axis" "Frequency: Body-Acceleration-Mean: Y-axis" "Frequency: Body-Acceleration-Mean: Z-axis" "Frequency: Body-Acceleration-SD: X-axis" ...
##  $ Average     : num  -0.2028 0.0897 -0.3316 -0.3191 0.056 ...
##  - attr(*, "sorted")= chr  "Subject" "ActivityNum" "ActivityName" "FeatureCode" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

Data table key
--------------


```r
key(dtTidyDataset)
```

```
## [1] "Subject"      "ActivityNum"  "ActivityName" "FeatureCode" 
## [5] "FeatureName"
```

Sample data
-----------


```r
dtTidyDataset
```

```
##        Subject ActivityNum ActivityName           FeatureCode
##     1:       1           1      WALKING     fBodyAcc-mean()-X
##     2:       1           1      WALKING     fBodyAcc-mean()-Y
##     3:       1           1      WALKING     fBodyAcc-mean()-Z
##     4:       1           1      WALKING      fBodyAcc-std()-X
##     5:       1           1      WALKING      fBodyAcc-std()-Y
##    ---                                                       
## 11876:      30           6       LAYING   tGravityAcc-std()-X
## 11877:      30           6       LAYING   tGravityAcc-std()-Y
## 11878:      30           6       LAYING   tGravityAcc-std()-Z
## 11879:      30           6       LAYING tGravityAccMag-mean()
## 11880:      30           6       LAYING  tGravityAccMag-std()
##                                       FeatureName     Average
##     1:  Frequency: Body-Acceleration-Mean: X-axis -0.20279431
##     2:  Frequency: Body-Acceleration-Mean: Y-axis  0.08971273
##     3:  Frequency: Body-Acceleration-Mean: Z-axis -0.33156012
##     4:    Frequency: Body-Acceleration-SD: X-axis -0.31913472
##     5:    Frequency: Body-Acceleration-SD: Y-axis  0.05604001
##    ---                                                       
## 11876:     Time: -Gravity-Acceleration-SD: X-axis -0.97956394
## 11877:     Time: -Gravity-Acceleration-SD: Y-axis -0.98893071
## 11878:     Time: -Gravity-Acceleration-SD: Z-axis -0.98327452
## 11879: Time: -Gravity-Acceleration-Magnitude-Mean -0.96982998
## 11880:   Time: -Gravity-Acceleration-Magnitude-SD -0.96016791
```

Summary of variables
--------------------


```r
summary(dtTidyDataset)
```

```
##     Subject      ActivityNum  ActivityName       FeatureCode       
##  Min.   : 1.0   Min.   :1.0   Length:11880       Length:11880      
##  1st Qu.: 8.0   1st Qu.:2.0   Class :character   Class :character  
##  Median :15.5   Median :3.5   Mode  :character   Mode  :character  
##  Mean   :15.5   Mean   :3.5                                        
##  3rd Qu.:23.0   3rd Qu.:5.0                                        
##  Max.   :30.0   Max.   :6.0                                        
##  FeatureName           Average        
##  Length:11880       Min.   :-0.99767  
##  Class :character   1st Qu.:-0.96205  
##  Mode  :character   Median :-0.46989  
##                     Mean   :-0.48436  
##                     3rd Qu.:-0.07836  
##                     Max.   : 0.97451
```
