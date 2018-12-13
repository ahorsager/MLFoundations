# Data Preprocessing Template

#Importing the data set
DataSet = read.csv('Data.csv')

# Managing missing data
DataSet$Age = ifelse(is.na(DataSet$Age),
                     ave(DataSet$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     DataSet$Age)
DataSet$Salary = ifelse(is.na(DataSet$Salary),
                        ave(DataSet$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        DataSet$Salary)

#Encode categorical data into numeric data
DataSet$Country = factor(DataSet$Country, 
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))
DataSet$Purchased = factor(DataSet$Purchased, 
                         levels = c('No', 'Yes'),
                         labels = c(0, 1))

#Split data into training and test
set.seed(123)
Split = sample.split(DataSet$Purchased, SplitRatio = 0.8)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE)

#Feature scaling
TrainingSet[, 2:3] = scale(TrainingSet[, 2:3])
TestSet[, 2:3] = scale(TestSet[, 2:3])

