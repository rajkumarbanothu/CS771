setwd("C:/data") # working directory
my_rawdata = read.csv(file = "final.csv", header=TRUE, na.string="?")
set.seed(2) # seed=2
my_rawdata <my_
rawdata[sample(nrow(my_rawdata)),]
attach(my_rawdata)
library(e1071) # for svm
sum=0
for (i in 1:5)
{
	# i=1
	test=c(((i1)*5000+1):(i*5000))
	train=test
	testing_data=my_rawdata[test,]
	test_output_col=V51[test]
	test_output_col=test_output_col[c(1:5000)]
	training_data=my_rawdata[train,]
	my_model<naiveBayes(as.factor(V51)~ ., data=training_data )
	my_predict<predict(my_model, testing_data,type = c("class"), threshold = 0.001, eps = 0)
	# for(m in 1:5000)
	{
		# if(my_predict[m]>0.5){my_predict[m]=1}
		# else {my_predict[m]=0}
	}
	x=mean(my_predict != test_output_col)
	print((1x)*100)
	sum=sum+x
}
# # five times cross validation result
# [1] 72.76
# [1] 72.16
# [1] 72.06
# [1] 73.4
# [1] 73.1
print((1sum/5)*100) # average result 72.7


