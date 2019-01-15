# LogisticRegression.R
# A template for a logistic regression model used for classification. 
# Logistic regression models are mathematical tranformations of linear 
# regressions that create a sigmoid shaped function that allows you to find 
# the probability of a binomial dependent variable based on one or more  
# independent variables.
# Author: Alan Horsager
# Created: 14-JAN-2018

# Activate commonly-used libraries 
library(caTools)
library(ElemStatLearn)

#### DATA PREPROCESSING ####
# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLFoundations/3-Classification/1. Logistic Regression/")
DataSet = read.csv('SocialNetworkAds.csv')
DataSet = DataSet[, 3:5]

# Convert categorical data into factors

# Split data into training and test sets
set.seed(123)
Split = sample.split(DataSet$Purchased, SplitRatio = 0.75)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE) 

# Scale features to reduce bias of features based on numerical size
TrainingSet[, 1:2] = scale(TrainingSet[, 1:2])
TestSet[, 1:2] = scale(TestSet[, 1:2])

#### MODEL ####
# Fitting logistic regression to the TrainingSet
classifier = glm(formula = Purchased ~ .,
                 family = binomial, 
                 data = TrainingSet)

# Predicting the probability of TestSet data
PredP = predict(classifier, type = 'response', newdata = TestSet[-3])
PredY = ifelse(PredP > 0.5, 1, 0)

# Confusion Matrix for evaluating performance of model
ConMatrix = table(TestSet[, 3], PredY)

#### DATA VISUALIZATION ####

# Visualising the Training set results
set = TrainingSet
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
GridSet = expand.grid(X1, X2)
colnames(GridSet) = c('Age', 'EstimatedSalary')
PSet = predict(classifier, type = 'response', newdata = GridSet)
YGrid = ifelse(PSet > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Training set)',
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
PSet = predict(classifier, type = 'response', newdata = GridSet)
YGrid = ifelse(PSet > 0.5, 1, 0)
plot(set[, -3],
     main = 'Logistic Regression (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(YGrid), length(X1), length(X2)), add = TRUE)
points(GridSet, pch = '.', col = ifelse(YGrid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
