library(glmnet)
library(R.matlab)

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/trainData.mat";
list = readMat(filePath);
trainData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/trainLabels.mat";
list = readMat(filePath);
trainLabels = do.call(rBind, list);


filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/testData.mat";
list = readMat(filePath);
testData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/testLabels.mat";
list = readMat(filePath);
testLabels = do.call(rBind, list);


cvfit=cv.glmnet(trainData, trainLabels, family="multinomial", parallel = TRUE);
predicted = predict(cvfit, testData, s = "lambda.min", type = "class");

filename = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/Rpredicted.mat";

writeMat(filename, predicted=predicted);

