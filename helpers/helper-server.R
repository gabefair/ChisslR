source("helpers/data-prep.R")

load_data <- function() {
  showModal(modalDialog("Loading dataset", footer=NULL))
  
  download_mnist_data()
  train1 <- read_csv("data/selected-sample-data.csv")
  
  removeModal()
  
  return(train1)
}

get_image <- function(data, index_of_plot) {
  m = t(apply(matrix(unlist(data[index_of_plot,-1]), nrow=28, byrow=TRUE), 2, rev))
  par(mfrow=c(1,1),
      oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
      mar = c(0,0,0,0) + 0.1)
  image(m, col=grey.colors(255), axes=FALSE, asp=1)
}