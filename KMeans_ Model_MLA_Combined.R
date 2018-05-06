
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

dataset <- read.csv('Combined_data_v1.csv')


library(tm)




corpus <- Corpus(VectorSource(dataset$item_description))

corpus

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('english'))

mat <- DocumentTermMatrix(corpus)
mat


mat4 <- weightTfIdf(mat)
mat4 <- as.matrix(mat4)
mat4


norm_eucl <- function(m)
  m/apply(m,1,function(x) sum(x^2)^.5)
mat_norm <- norm_eucl(mat4)


set.seed(5)
k <- 10
kmeansResult <- kmeansruns(mat_norm, k)


table(kmeansResult$cluster)




write.csv(output,"kmeans_output.csv")


output1 <- cbind(dataset[,c(2,5:6)],kmeansResult$cluster)


write.csv(output1,"kmeans_output1.csv")



