library(readr)
library(dplyr)

download_mnist_data <- function() {
  if (FALSE %in% (list.files(path="../data/") == 'mnist_raw.csv')){
    mnist_raw <- read_csv("https://pjreddie.com/media/files/mnist_train.csv", col_names = FALSE)
    write_csv(mnist_raw,"../data/mnist_raw.csv", row.names = FALSE)
  }
}