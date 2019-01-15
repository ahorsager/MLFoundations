# DecisionTreeRegression.R
# A template for a decision tree regression model. It appears that decision
# trees assume that data group together based on information entropy. The 
# boundaries of groupings or leafs are determined by this model. Decision tree
# models are both nonlinear and noncontinuous. 
# Author: Alan Horsager
# Created: 13-DEC-2018

# Activate commonly-used libraries 
library(caTools)
library(ggplot2)
library(rpart)
library(e1071)

#### DATA PREPROCESSING ####

# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLFoundations/2-Regression/Decision Tree Regression")
DataSet = read.csv('PositionSalaries.csv')
DataSet = DataSet[2:3]

# Convert categorical data into factors

# Split data into training and test sets

#### MODEL ####
# Fitting decision tree regression to the data set
regressor = rpart(formula = Salary ~ ., 
               data = DataSet,
               control = rpart.control(minsplit = 1))
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
