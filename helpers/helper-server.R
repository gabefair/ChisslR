source("helpers/data-prep.R")


load_newsgroups_data <- function(){
  showModal(modalDialog("Downloading dataset", footer=NULL))
  download_newsgroups_byDate()
  removeModal()
  
  showModal(modalDialog("Extracting dataset", footer=NULL))
  extract_newsgroups_byDate()
  removeModal()
  
  showModal(modalDialog("Building Model", footer=NULL))
  train_newsgroups_model()
  removeModal()
  
}

load_data <- function() {
  showModal(modalDialog("Loading dataset", footer=NULL))
  
  download_mnist_data()
  data <- read_csv("data/selected-sample-data.csv")
  pred0 <- data %>% filter(label == 0)
  pred1 <- data %>% filter(label == 1)
  pred2 <- data %>% filter(label == 2)
  pred3 <- data %>% filter(label == 3)
  pred4 <- data %>% filter(label == 4)
  pred5 <- data %>% filter(label == 5)
  pred6 <- data %>% filter(label == 6)
  pred7 <- data %>% filter(label == 7)
  pred8 <- data %>% filter(label == 8)
  pred9 <- data %>% filter(label == 9)
  
  removeModal()
  
  return_list <- list("pred0" = pred0,
                      "pred1" = pred1,
                      "pred2" = pred2,
                      "pred3" = pred3,
                      "pred4" = pred4,
                      "pred5" = pred5,
                      "pred6" = pred6,
                      "pred7" = pred7,
                      "pred8" = pred8,
                      "pred9" = pred9)
  return(return_list)
}

get_image <- function(data, index_of_plot) {
  m = t(apply(matrix(unlist(data[index_of_plot,-1]), nrow=28, byrow=TRUE), 2, rev))
  par(mfrow=c(1,1),
      oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
      mar = c(0,0,0,0) + 0.1)
  image(m, col=grey.colors(255), axes=FALSE, asp=1)
}