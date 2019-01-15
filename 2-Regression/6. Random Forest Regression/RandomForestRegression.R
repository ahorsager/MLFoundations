# RandomForestRegression.R
# A template for a random forest regression model. Random forest is an
# ensemble model that uses multiple decision trees. The values in each leaf are
# then averaged across all of the decision trees to come up with a more 
# accurate prediction for a Y value. These models are both nonlinear and 
# noncontinuous. 
# Author: Alan Horsager
# Created: 14-DEC-2018

# Activate commonly-used libraries 
library(caTools)
library(randomForest)
library(ggplot2)
library(rpart)
library(e1071)

#### DATA PREPROCESSING ####

# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLFoundations/2-Regression/Random Forest Regression")
DataSet = read.csv('PositionSalaries.csv')
DataSet = DataSet[2:3]

# Convert categorical data into factors

# Split data into training and test sets

#### MODEL ####
# Fitting random forest regression to the data set
set.seed(1234)
regressor = randomForest(x = DataSet[1],
                         y = DataSet$Salary,
                         ntree = 500)
summary(regressor) # Summary of lm fit results

PredVal = predict(regressor, newdata = data.frame(Level = 6.5))

#### DATA VISUALIZATION ####
x_grid = seq(min(DataSet$Level), max(DataSet$Level), 0.01)
ggplot() +
    geom_point(aes(x = DataSet$Level, y = DataSet$Salary), 
               color = 'red') +
    geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
              color = 'blue') +
    ggtitle('Salary vs. Level') + 
    xlab('Level') +
    ylab('Salary')
