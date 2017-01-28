setwd("C:/data") # working directory
my_rawdata = read.csv(file = "final.csv", header=TRUE, na.string="?")
set.seed(17) # seed=2
my_rawdata <my_rawdata[sample(nrow(my_rawdata)),]
attach(my_rawdata)
library(nnet) # for nn
for(k in 1:5)
{
	print("size of hidden layer is ")
	print(2*k)
	sum=0
	for (i in 1:5)
	{
		# i=1
		test=c(((i1)*
		5000+1):(i*5000))
		train=test
		testing_data=my_rawdata[test,]
		test_output_col=V51[test]
		test_output_col=test_output_col[c(1:5000)]
		training_data=my_rawdata[train,]
		my_model= nnet( as.factor(V51)~ . , data=training_data, size=0 , maxit=150, trace =FALSE)
		my_predict<predict(my_model, testing_data, type = "class" )
		# for(m in 1:5000){
		# if(my_predict[m]>0.5){my_predict[m]=1}
		# else {my_predict[m]=0} }
		x=mean(my_predict != test_output_col)
		print((1x)*100)
		sum=sum+x
	}
	print("average error is ")
	print((1sum/5)*100) # average result 84.144
}
# [1] "size of hidden layer is "
# [1] 1
# [1] 84.28
# [1] 84.78
# [1] 83.9
# [1] 84.08
# [1] 83.76
# [1] "average error is "
# [1] 84.16
# [1] "size of hidden layer is "
# [1] 2
# [1] 84.08
# [1] 84.64
# [1] 83.74
# [1] 84.08
# [1] 83.88
# [1] "average error is "
# [1] 84.084
# [1] "size of hidden layer is "
# [1] 4
# [1] 83.8
# [1] 84.7
# [1] 83.96
# [1] 83.48
# [1] 83.5
# [1] "average error is "
# [1] 83.888
# [1] "size of hidden layer is "
# [1] 6
# [1] 83.4
# [1] 84.42
# [1] 84.1
# [1] 83.78
# [1] 83.54
# [1] "average error is "
# [1] 83.848
# [1] "size of hidden layer is "
# [1] 8
# [1] 83.42
# [1] 83.86
# [1] 83.48
# [1] 83.54
# [1] 83.84
# [1] "average error is "
# [1] 83.628
# [1] "size of hidden layer is "
# [1] 10
# [1] 82.56
# [1] 84.44
# [1] 82.94
# [1] 83.7
# [1] 83.34
# [1] "average error is "
# [1] 83.396


