# SupportVectorRegression.R
# A template for a support vector regression (SVR) model. From what I can tell,
# SVR is a useful regression method when there are obvious outliers that 
# should be ignored during the modeling process.
# Author: Alan Horsager
# Created: 13-DEC-2018

#### DATA PREPROCESSING ####
# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLTraining/2-Regression/Support Vector Regression")
DataSet = read.csv('PositionSalaries.csv')
DataSet = DataSet[2:3]

# Convert categorical data into factors

# Split data into training and test sets

#### MODEL ####
# Fitting SVR to the data set
regressor = svm(formula = Salary ~ ., 
               data = DataSet,
               type = 'eps-regression')
summary(regressor) # Summary of lm fit results

PredVal = predict(regressor, newdata = data.frame(Level = 6.5))

#### DATA VISUALIZATION ####
ggplot() +
    geom_point(aes(x = DataSet$Level, y = DataSet$Salary), 
               color = 'red') +
    geom_line(aes(x = DataSet$Level, y = predict(regressor, newdata = DataSet)),
              color = 'blue') +
    ggtitle('Salary vs. Level') + 
    xlab('Level') +
    ylab('Salary')
