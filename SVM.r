setwd("C:/data") # working directory
my_rawdata = read.csv(file = "final.csv", header=TRUE, na.string="?")
set.seed(2) # seed=2
my_rawdata <my_rawdata[sample(nrow(my_rawdata)),]
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
	my_model<svm(V51~ ., data=training_data, type="Cclassification")
	my_predict<predict(my_model, testing_data)
	my_predict=(unlist(my_predict,use.names = FALSE))
	x=mean(my_predict != test_output_col)
	print((1x)*100)
	sum=sum+x
}
print((1sum/5)*100


