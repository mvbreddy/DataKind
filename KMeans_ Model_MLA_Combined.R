
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
library(quanteda)

library(topicmodels)

colnames(dataset)[5]<- c("item_description")


dataset[5] <- as.character(dataset[5])

text_mining = function(sample){
  cat("\014")
  sample$item_description = ifelse(grepl('No description yet',sample$item_description , ignore.case = TRUE ,perl = TRUE) , '',sample$item_description)
  gc()
  cat("tolower...\n")
  sample$item_description = tolower(sample$item_description)
  cat("creating corpus...\n")
  corpus = Corpus(VectorSource(sample$item_description))
  cat("stop words...\n")
  corpus = tm_map(corpus , removeWords , stopwords('english'))
  cat("punct...\n")
  corpus = tm_map(corpus , removePunctuation)
  #cat("tolower...\n")
  #corpus = tm_map(corpus , tolower) #taking longer time!
  cat("stem doc...\n")
  corpus = tm_map(corpus , stemDocument)
  cat("creating quanteda...\n")
  
  corpus1 = quanteda::corpus(corpus)
  
  cat("creating dfm matrix...\n")
  dfm_matrix = quanteda::dfm(quanteda::tokens(corpus1 ) ,
                             ngrams =2 , tolower = FALSE , stem = FALSE , remove_punct = FALSE)
  return (dfm_matrix)
}


str(dataset)

dfm <- text_mining(dataset)

dfm


MLA_lda <- LDA(dfm, k = 10, control = list(seed = 1234))
MLA_lda

library(tidytext)

MLA_topics <- tidy(MLA_lda, matrix = "beta")
MLA_topics


unique(MLA_topics$term)
write.csv(MLA_lda,"test.csv") 





#k-MODES

install.packages("klaR")

library(klaR)

kmeasn_output <- kmodes(dataset[5], 10,iter.max = 10, weighted = FALSE, fast = TRUE)



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


count(kmeansResult$cluster)


output <- cbind(dataset[5],kmeansResult$cluster)


write.csv(output,"kmeans_output.csv")


output1 <- cbind(dataset[,c(2,5:6)],kmeansResult$cluster)


write.csv(output1,"kmeans_output1.csv")



