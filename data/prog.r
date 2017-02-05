# sushil kumar verma   - initial project in r
# date 02/04/2015
 # https://www.kaggle.com/c/word2vec-nlp-tutorial/details/
 # gerating actual working table from google word2vec result


setwd("G:/Machine Learning Tools and Techniques/project/data") # working directory
train= read.table("labeledTrainData.tsv", sep="\t", header=TRUE,quote="") #kaggle train data
#library(tm.plugin.webmining) #remove html tag
library(tm) #stopwords


tab_frame2 = read.csv(file = "tab_frame.csv",header=FALSE, na.string="0") #reading tab_frame  
my_cor <- Corpus(VectorSource(train$review)) #make corpus of training data 

tab_req= matrix(0, nrow=25000, ncol=51, byrow = T) # making final required table matrix

#for(i in 15001:20000)
#{ 
  i=15001
x3= strsplit(gsub("[^[:alnum:] ]", "", my_cor[[i]]), " +") #remove symbols
y3=unlist(x3)  # unlist review 
c=0
r1.vector= vector(mode="numeric", length=50)
for(j in 1:(length(y3)))
{ 
   row= which(tab_frame2$V1 == y3[j]) 
   if(!(is.integer(row) && length(row) == 0L)) 
    {
     r2.vector=as.numeric(tab_frame2[row,2:51])
     r1.vector= as.numeric(r2.vector)+ as.numeric(r1.vector) 
     c=c+1 
   }
 } 
tab_req[i,1:50] = r1.vector
tab_req[i,] = (tab_req[i, ])/c
print(i)
#}
tab_req[15001,]
 
tab_req[,51] = train$sentiment 




