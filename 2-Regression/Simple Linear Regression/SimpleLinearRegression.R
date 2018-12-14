# SimpleLinearRegression.R
# A template for a simple linear regression model
# Author: Alan Horsager
# Created: 12-DEC-2018

# **DATA PREPROCESSING**
# Importing the data set
setwd("/Users/horsager/Dropbox/projects/analytics/MLTraining/2-Regression/Simple Linear Regression")
DataSet = read.csv('SalaryData.csv')

# **SPLIT TRAINING & TEST DATA**
set.seed(123)
Split = sample.split(DataSet$Salary, SplitRatio = 2/3)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE) 

# **MODEL**
# Fitting linear regression to the data set
regressor = lm(formula = Salary ~ YearsExperience,
               data = TrainingSet)
summary(regressor) # Summary of lm fit results

# Predict test set results
TestPredict = predict(regressor, newdata = TestSet)

# **DATA VISUALIZATION**
# Plot regression fit of training set
ggplot() +
  geom_point(aes(x = TrainingSet$YearsExperience, y = TrainingSet$Salary), 
             color = 'red') +
  geom_line(aes(x = TrainingSet$YearsExperience, y = predict(regressor, newdata = TrainingSet)),
            color = 'blue') +
  ggtitle('Salary vs. Experience (Training Set)') + 
  xlab('Years of Experience') +
  ylab('Salary')

# Plot regression of test set
ggplot() +
  geom_point(aes(x = TestSet$YearsExperience, y = TestSet$Salary), 
             color = 'red') +
  geom_line(aes(x = TrainingSet$YearsExperience, y = predict(regressor, newdata = TrainingSet)),
            color = 'blue') +
  ggtitle('Salary vs. Experience (Test Set)') + 
  xlab('Years of Experience') +
  ylab('Salary')
