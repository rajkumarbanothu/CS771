library(tree)
library(oblique.tree)
Auto = read.csv(file = "moviereviews.csv",header = TRUE)
#Attach dataset to R
Auto=Auto[1:5000,]
attach(Auto)
head(Auto)
length(Auto$class)
#create categorical variable
High= ifelse(V51>=1, "Yes", "No")
length(High)
Auto=data.frame(Auto,High)
Auto=Auto[,51]
names(Auto)
#split testing and training sets
set.seed(1)
training=sample(1:nrow(Auto),4*nrow(Auto)/5)
testing = training
training_data=Auto[training,]
dim(training_data)
testing_data=Auto[testing,]
dim(testing_data)
testing_High=High[testing]
length(testing_High)
#fit the tree model using tree data
tree_model=tree(High~., training_data)
plot(tree_model)
text(tree_model,pretty=0)
title(main="Classification Tree")
#grow the tree as long as possible
ob_tree=oblique.tree(formula=High~.,
data=Auto,
oblique.splits="on")
plot(ob_tree)
text(ob_tree)
title(main="Maximum Grown Tree")
tree_pred=predict(ob_tree,testing_data,type="class")
mean(tree_pred != testing_High)
#check how model doing using test data
tree_pred1=predict(tree_model,testing_data,type="class")
errr=mean(tree_pred1 != testing_High)
print(errr)
#do pruning to reduce misclassification error
#to do pruning first do cross validation to know where to stop
pruning
set.seed(2)
cv_tree=cv.tree(tree_model,FUN=prune.misclass)
names(cv_tree)
plot(cv_tree$size,
cv_tree$dev,
type="b")
title(main="Cross Validation")
#now prune tree
#create prune model
pruned_model=prune.misclass(tree_model,best = 4)
plot(pruned_model)
text(pruned_model,pretty=0)
title(main="Pruned Tree")
#check misclassification error % now
tree_pred2=predict(pruned_model,testing_data,type="class")
err=mean(tree_pred2 != testing_High)
print(err)
