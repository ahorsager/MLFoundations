#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Data Preprocessing Template

#Importing the libraries
import numpy as np #mathematical tools library
import matplotlib.pyplot as plt #plotting library 
import pandas as pd #importing and managing data sets library

# Import the data set
DataSet = pd.read_csv('Data.csv')
X = DataSet.iloc[:, :-1].values
Y = DataSet.iloc[:, 3].values

# Managing missing data
from sklearn.preprocessing import Imputer
ImputeVals = Imputer(missing_values = 'NaN', strategy = 'mean', axis = 0)
ImputeVals = ImputeVals.fit(X[:, 1:3])
X[:, 1:3] = ImputeVals.transform(X[:, 1:3])

#Encode categorical data as numbers
from sklearn.preprocessing import LabelEncoder, OneHotEncoder

LabelEncoderX = LabelEncoder()
X[:,0] = LabelEncoderX.fit_transform(X[:,0])
CountryEncoder = OneHotEncoder(categorical_features = [0])
X = CountryEncoder.fit_transform(X).toarray()

LabelEncoderY = LabelEncoder()
Y = LabelEncoderY.fit_transform(Y)

#Splitting data into training and test
from sklearn.model_selection import train_test_split
Xtrain, Xtest, Ytrain, Ytest = train_test_split(X, Y, test_size = 0.2, random_state = 0)

#Feature scaling
from sklearn.preprocessing import StandardScaler
ScaleX = StandardScaler()
Xtrain = ScaleX.fit_transform(Xtrain)
Xtest = ScaleX.transform(Xtest)

