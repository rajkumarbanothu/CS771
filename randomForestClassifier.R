library(randomForest)
Dataset=read.csv(file="letter-recognition.csv",header=TRUE)
attach(Dataset)
set.seed(4)

#shuffle dataset indexes

suffle_indexes=sample(1:20000)

#create new shuffled dataset with same instances as in original dataset

suffle_dataset=Dataset[suffle_indexes,]
err_sum=0
first=1
last=9
mid=5
num_of_trees=vector("numeric",length(1:9))
error=vector("numeric",length(1:9))

#getRange function for getting part(i.e 1/5 th) of shuffled dataset

getRange = function(j) {
  switch(j,
         '1'={
           return(c(1:4000))
         },
         '2'={
           return(c(4001:8000))
         },
         '3'={
           return(c(8001:12000))
         },
         '4'={
           return(c(12001:16000))
         },
         '5'={
           return(c(16001:20000))
         },
          {
            #default
          })
}

#trees loop for varying number of trees in random forest creation 

for(trees in 1:9) {

#i loop for 5-fold cross-validation
  
  for(i in 1:5) {
    testing=getRange(i)
    training=-testing
    testing_data=suffle_dataset[testing,]
    training_data=suffle_dataset[training,]
    
# ntree(number of trees in RF) parameter varying in set {2,4,8,16,32,64,128,256,512}    
    
    ranforest=randomForest(lettr ~ ., data=training_data, importance=TRUE,replace = TRUE, mtry=6, ntree = 2^trees)
    
#prediction on testing data

    predict_ranforest=predict(ranforest, testing_data, type = "response")

#error rate calculation

    x=mean(predict_ranforest != suffle_dataset$lettr[testing])
    err_sum = err_sum + x
  }
  print(err_sum/5)
  num_of_trees[trees]=2^trees
  error[trees]=err_sum/5
  err_sum=0
}
print(error)
plot(num_of_trees, error, type="b", xlab="Number of Trees", ylab="Error rate",main="Number of trees vs error rates in RF")

#Binary search to find number of trees at which error level off by giving threshold 0.002
while(first<last) {
  if((error[mid]-error[last])<=0.002) { print(num_of_trees[mid])
    break  }  else {    mid=as.integer((first+last)/2)
    first=mid  }
}

