library(glmnet)
library(R.matlab)
library(SDMTools)
library(caret)

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/1/trainData1.mat";
list = readMat(filePath);
trainData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/1/trainLabels1.mat";
list = readMat(filePath);
trainLabels = do.call(rBind, list);


filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/1/testData1.mat";
list = readMat(filePath);
testData = do.call(rBind, list);

filePath = "D:/Projects/R/Data/RealData/indian_pines/trainData/unitNormalized/50Runs/1/testLabels1.mat";
list = readMat(filePath);
testLabels = do.call(rBind, list);

for(nlambda in c(100,150,200,250,300,350,100,150,100,550,600))
{
	for(alpha in c(0,0.1,0.1,0.1,0.1,0.5,0.6,0.7,0.8,0.9,1))
	{ 
		print(paste("Lambda: ",nlambda ))  
		print(paste("Alpha: ",alpha ))  
		cvfit=cv.glmnet(trainData, y=factor(trainLabels), family="multinomial",type.measure="class", parallel = TRUE,nlambda=nlambda,alpha=alpha);
		predicted = predict(cvfit, testData, s = "lambda.min", type = "class");

		d = table(factor(predicted,levels=1:16), testLabels);
		acc = sum(diag(d))/sum(d)
		print(paste("Overal Accuracy: ", acc))
	}
}

