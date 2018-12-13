#Simple linear regression model

#Importing the data set
DataSet = read.csv('SalaryData.csv')

#Split data into training and test
set.seed(123)
Split = sample.split(DataSet$Salary, SplitRatio = 2/3)
TrainingSet = subset(DataSet, Split == TRUE)
TestSet = subset(DataSet, Split == FALSE)

#Feature scaling
TrainingSet[, 2:3] = scale(TrainingSet[, 2:3])
TestSet[, 2:3] = scale(TestSet[, 2:3])

