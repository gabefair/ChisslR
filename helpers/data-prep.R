library(readr)
library(dplyr)

download_mnist_data <- function() {
  if (!file.exists('data/mnist_raw.csv')){
    #mnist_raw <- read_csv("https://pjreddie.com/media/files/mnist_train.csv", col_names = FALSE)
    write_csv(read_csv("https://pjreddie.com/media/files/mnist_train.csv", col_names = FALSE),"data/mnist_raw.csv")
  }
  else {print("mnist_raw.csv already downloaded")}
} #This function might seem to freze for one or two mins. Give it time


download_chissl_mongodb <- function() {
  if (!file.exists('data/chissl.agz')){
    download.file("https://github.com/pnnl/chissl/raw/e20193546b2a81f4906fa5316868181e527e1fc2/dumps/chissl", destfile="data/chissl.agz", method="libcurl")
  }
  else {print("chissl.agz already downloaded")}
}

download_newsgroups_byDate <- function() {
  if (!file.exists('data/20news-bydate.tar.gz')){
    download.file("http://qwone.com/~jason/20Newsgroups/20news-bydate.tar.gz", destfile = "data/20news-bydate.tar.gz", method="libcurl")
  }
  else {print("20news-bydate.tar.gz already downloaded")}
}

extract_newsgroups_byDate <- function() {
  
}
