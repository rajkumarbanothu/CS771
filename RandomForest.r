#generating random forests for ntree =302 , and varying mtry
library(randomForest)
#attach(my_final_data)
setwd("/home/raj/IITK/ML") # working directory
my_final_data= read.csv(file = "final.csv", header=TRUE,
na.string=c("", "NA", "NULL"))
my_data = my_final_data[sample(1:nrow(my_final_data),nrow(my_final_data)), ]
names(my_data)
attach(my_data)
my_final_data[18959,]
error = array(1:5)
acc = array(1:4)
set.seed(2)
k=1
i =302
m = 2
while ( m <= 8 )
{
	sum = 0
	j=1
	for ( j in 1:5 )
	{
		test = c(((5000*(j1))+1):(5000*(j)))
		train=test
		training_data = my_data[train,]
		testing_data= my_data[test,]
		label = V51[test]
		label = label[c(1:5000)]
		rand_For = randomForest(as.factor(V51)~. ,training_data , ntree=i ,mtry = m , na.action = na.omit)
		tree_pred = predict(rand_For , testing_data , type = "response")
		# print(tree_pred)
		#print(label)
		error1 =mean( tree_pred != label)
		error[j] =error1
		print (error1)
		sum = sum + error1
	}
	m=m*2
	avg = sum/5
	#print(avg)
	accuracy = 1 avg
	print(error)
	print(accuracy)
	acc[k]= accuracy
	k =k+1
}