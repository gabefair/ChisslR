library(shiny)
library(bs4Dash)
source("helpers/helper-server.R") #Put helper functions here and not at the top of this file

function(input, output) {
  load_data()
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    
  })
  
  output$view <- renderPlot({
    m = t(apply(matrix(unlist(train1[2,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
}