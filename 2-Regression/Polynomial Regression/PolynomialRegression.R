# PolynomialRegression.R
# A template for a polynomial linear regression model
# Author: Alan Horsager
# Created: 13-DEC-2018

#### DATA PREPROCESSING ####
# Import data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLTraining/2-Regression/Polynomial Regression")
DataSet = read.csv('PositionSalaries.csv')
DataSet = DataSet[2:3]

# Convert categorical data into factors

# Split data into training and test sets

#### MODEL ####
# Fitting polynomial regression to the data set
DataSet$Level2 = DataSet$Level^2
DataSet$Level3 = DataSet$Level^3
DataSet$Level4 = DataSet$Level^4
regressor = lm(formula = Salary ~ ., 
               data = DataSet)
summary(regressor) # Summary of lm fit results

PredVal = predict(regressor, newdata = data.frame(Level = 6.5,
                                                  Level2 = 6.5^2,
                                                  Level3 = 6.5^3,
                                                  Level4 = 6.5^4))

#### DATA VISUALIZATION ####
ggplot() +
    geom_point(aes(x = DataSet$Level, y = DataSet$Salary), 
               color = 'red') +
    geom_line(aes(x = DataSet$Level, y = predict(regressor, newdata = DataSet)),
              color = 'blue') +
    ggtitle('Salary vs. Level') + 
    xlab('Level') +
    ylab('Salary')
