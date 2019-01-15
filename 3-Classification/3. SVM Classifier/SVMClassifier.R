# SVMClassifier.R
# A template for a SVM Classifier model used for classification. SVM use two
# "support vectors that provide the greatest margin between the model and the 
# points nearest the model curve. 
# Author: Alan Horsager
# Created: 14-JAN-2018

# Activate commonly-used libraries 
library(caTools)
library(ElemStatLearn)
library(class)

#### DATA PREPROCESSING ####
# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLFoundations/3-Classification/2. KNN/")
DataSet = read.csv('SocialNetworkAds.csv')
DataSet = DataSet[, 3:5]

# Split data into training and test sets
set.seed(123)
Split = sample.split(DataSet$Purchased, SplitRatio = 0.75)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE) 

# Scale features to reduce bias of features based on numerical size
TrainingSet[, 1:2] = scale(TrainingSet[, 1:2])
TestSet[, 1:2] = scale(TestSet[, 1:2])

#### MODEL ####
# Fitting K-NN to the TrainingSet and predicting TestSet
PredY = knn(train = TrainingSet[, -3], 
            test = TestSet[, -3],
            cl = TrainingSet[, 3],
            k = 5)

# Confusion Matrix for evaluating performance of model
ConMatrix = table(TestSet[, 3], PredY)

#### DATA VISUALIZATION ####

# Visualising the Training set results
set = TrainingSet
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
GridSet = expand.grid(X1, X2)
colnames(GridSet) = c('Age', 'EstimatedSalary')
YGrid = knn(train = TrainingSet[, -3], 
           test = GridSet[, -3],
           cl = TrainingSet[, 3],
           k = 5)
plot(set[, -3],
     main = 'K-NN (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(YGrid), length(X1), length(X2)), add = TRUE)
points(GridSet, pch = '.', col = ifelse(YGrid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Visualising the Test set results
set = TestSet
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
GridSet = expand.grid(X1, X2)
colnames(GridSet) = c('Age', 'EstimatedSalary')
YGrid = knn(train = TrainingSet[, -3], 
           test = GridSet[, -3],
           cl = TrainingSet[, 3],
           k = 5)
plot(set[, -3],
     main = 'K-NN (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(YGrid), length(X1), length(X2)), add = TRUE)
points(GridSet, pch = '.', col = ifelse(YGrid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
