library(glmnet)
library(R.matlab)
library(SDMTools)
library(caret)

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/50/trainData50.mat";
list = readMat(filePath);
trainData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/50/trainLabels50.mat";
list = readMat(filePath);
trainLabels = do.call(rBind, list);


filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/50/testData50.mat";
list = readMat(filePath);
testData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/50/testLabels50.mat";
list = readMat(filePath);
testLabels = do.call(rBind, list);

for(alpha in c(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))
	{ 
		print(paste("Alpha: ",alpha ))  
		cvfit=cv.glmnet(trainData, y=factor(trainLabels), family="multinomial",type.measure="class", parallel = TRUE,nlambda=100,alpha=alpha);
		predicted = predict(cvfit, testData, s = "lambda.min", type = "response");

		d = table(factor(predicted,levels=1:16), testLabels);
		acc = sum(diag(d))/sum(d)
		print(paste("Overal Accuracy: ", acc))
	}
