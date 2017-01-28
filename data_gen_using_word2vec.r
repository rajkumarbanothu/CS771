# https://www.kaggle.com/c/word2vecnlptutorial/details/
# gerating actual working table from google word2vec result
# google command
# ./word2vec train ~/Desktop/sentences.txt output ~/Desktop/vec.csv size 50 window 5 sample 1e-4 negative 5 hs 0 binary 0 cbow 5 iter 5

setwd("C:/data") # working directory
train= read.table("labeledTrainData.tsv", sep="\t", header=TRUE,quote="") #kaggle train data
vec = read.csv(file = "vec.csv", sep=" ", header=FALSE,na.string="?") # result of google word2vec
vec = vec [, 1:51]
library(tm.plugin.webmining) #remove html tag
library(tm) #stopwords
# tab_frame= data.frame(tab)
# write.table(tab_frame, file = "tab_frame.csv",
# row.names=FALSE, na="",col.names=FALSE, sep=",") #writing csv
# tab_frame2 = read.csv(file = "tab_frame.csv",header=FALSE, na.string="0") #reading tab_frame
my_cor <Corpus(VectorSource(train$review)) #make corpus of training data
tab_request= matrix(0, nrow=25000, ncol=51, byrow = T) # making final required table matrix

for(i in 1:25000)
{
	x3= strsplit(gsub("[^[:alnum:] ]", "", my_cor[[i]]), " +")
	#remove symbols
	y3=unlist(x3) # unlist review
	c=0
	r1.vector= vector(mode="numeric", length=50)
	for(j in 1:(length(y3)))
	{
		row= which(vec$V1 == y3[j])
		if(!(is.integer(row) && length(row) == 0L))
		{
			r2.vector=as.numeric(vec[row,2:51])
			r1.vector= as.numeric(r2.vector)+ as.numeric(r1.vector)
			c=c+1
		}
	}
	tab_request[i,1:50] = r1.vector
	tab_request[i,] = (tab_request[i, ])/c
	print(i)
}
tab_request[,51] = train$sentiment
write.table(tab_request, file = "my_final_data.csv", row.names=FALSE, quote=FALSE, na="",col.names=FALSE, sep=",") # writing output csv
my_final_data= read.csv(file = "my_final_data.csv", header=TRUE, na.string=c("", "NA", "NULL"))
for ( i in 1:25000)
{
	for ( j in 1:50)
	{
		if ( is.na(my_final_data[i,j]) || ! (is.numeric(my_final_data[i,j])) )
		{
			my_final_data[i,j] = 0
			print(i)
		}
	}
}
write.csv(x=my_final_data, file = "final.csv",row.names=FALSE ,
quote = FALSE)
###########data
generated