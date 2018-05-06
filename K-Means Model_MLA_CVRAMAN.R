
# install.packages('devtools')
# library(devtools)
# 
# slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
# install_url(slam_url)
# 
# update.packages('Rcpp')# 
# install.packages('tm')
# install.packages('quanteda')



setwd("C:/Users/vijay.bhaskar/Desktop/MLA LADS/")

dataset <- read.csv('MLA_LAD_CVRAMANNAGAR.csv')


library(tm)
library(quanteda)

library(topicmodels)

colnames(dataset)[5]<- c("item_description")


dataset[5] <- as.character(dataset[5])


#Creating a Corpus

corpus <- Corpus(VectorSource(dataset$item_description))

corpus

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('english'))

#Converting Corpus into a dtm

mat <- DocumentTermMatrix(corpus)
mat

#Calculating tfidf

mat4 <- weightTfIdf(mat)
mat4 <- as.matrix(mat4)
mat4

# Function for calculating Euclidean distance

norm_eucl <- function(m)
  m/apply(m,1,function(x) sum(x^2)^.5)

mat_norm <- norm_eucl(mat4)

#K-means clustering

set.seed(5)
k <- 10
kmeansResult <- kmeans(mat_norm, k)

table(kmeansResult$cluster)


#Output of K-means

output1 <- cbind(dataset[,c(2,5:6)],kmeansResult$cluster)

colnames(output1)[4]<- c("Topic_Category")

write.csv(output1,"kmeans_output2.csv")



