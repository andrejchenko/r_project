library(glmnet)
library(R.matlab)


filePath = "D:/Projects/Matlab/oop/Experiments/Complementarity/indian_pines_mlr_pines/R/trainData.mat";
list = readMat(filePath);
trainData = do.call(rBind, list);

filePath = "D:/Projects/Matlab/oop/Experiments/Complementarity/indian_pines_mlr_pines/R/trainLabels.mat";
list = readMat(filePath);
trainLabels = do.call(rBind, list);


filePath = "D:/Projects/Matlab/oop/Experiments/Complementarity/indian_pines_mlr/R/testData.mat";
list = readMat(filePath);
testData = do.call(rBind, list);

filePath = "D:/Projects/Matlab/oop/Experiments/Complementarity/indian_pines_mlr/R/testLabels.mat";
list = readMat(filePath);
testLabels = do.call(rBind, list);


cvfit=cv.glmnet(trainData, trainLabels, family="multinomial", parallel = TRUE);
predicted = predict(cvfit, testData, s = "lambda.min", type = "response");

filename = "D:/Projects/Matlab/oop/Experiments/Complementarity/indian_pines_mlr/R/Rpredicted.mat";

writeMat(filename, predicted=predicted);


