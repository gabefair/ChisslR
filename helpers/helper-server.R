source("helpers/data-prep.R")

load_data <- function() {
  showModal(modalDialog("Loading dataset", footer=NULL))
  
  download_mnist_data()
  train1 <- read_csv("data/selected-sample-data.csv")
  
  removeModal()
}