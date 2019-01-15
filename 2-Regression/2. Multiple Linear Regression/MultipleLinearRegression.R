# MultipleLinearRegression.R
# A template for a multiple linear regression model
# Author: Alan Horsager
# Created: 13-DEC-2018

#### DATA PREPROCESSING ####
# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLTraining/2-Regression/Multiple Linear Regression")
DataSet = read.csv('50Startups.csv')

#Convert categorical data into factors
DataSet$State = factor(DataSet$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Split data into training and test sets
set.seed(123)
Split = sample.split(DataSet$Profit, SplitRatio = 0.8)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE) 

#### MODEL ####
# Fitting linear regression to the data set
regressor = lm(formula = Profit ~ ., # Profit a linear combination of all ind vars
               data = TrainingSet)
summary(regressor) # Summary of lm fit results

# Predict test set results
TestPredict = predict(regressor, newdata = TestSet)

# Use step-by-step Backward Elimination to optimize model
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State, 
               data = DataSet)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend, 
               data = DataSet)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend, 
               data = DataSet)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend, 
               data = DataSet)
summary(regressor)

#Automated Backward Elimination to optimize model
BackwardElimination <- function(x, sl) {
    numVars = length(x)
    for (i in c(1:numVars)){
        regressor = lm(formula = Profit ~ ., data = x)
        maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
        if (maxVar > sl){
            j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
            x = x[, -j]
        }
        numVars = numVars - 1
    }
    return(summary(regressor))
}

SL = 0.05
DataSet = DataSet[, c(1,2,3,4,5)]
BackwardElimination(TrainingSet, SL)

#### DATA VISUALIZATION ####
