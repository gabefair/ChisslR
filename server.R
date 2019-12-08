library(shiny)
library(bs4Dash)
source("helpers/helper-server.R") #Put helper functions here and not at the top of this file

function(input, output) {
  train1 <- load_data()
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    
  })
  
  output$results_1 <-
    renderPrint(
      input$rank_list_1 # This matches the input_id of the first rank list
    )
  output$results_2 <-
    renderPrint(
      input$rank_list_2 # This matches the input_id of the second rank list
    )
  output$results_3 <-
    renderPrint(
      input$rank_list_3 # Matches the group_name of the bucket list
    )
  output$results_4 <-
    renderPrint(
      input$rank_list_4 # Matches the group_name of the bucket list
    )
  output$results_5 <-
    renderPrint(
      input$rank_list_5 # Matches the group_name of the bucket list
    )
  output$playground_1 <-
    renderPrint(
      input$playground_1 # Matches the group_name of the bucket list
    )
  output$playground_2 <-
    renderPrint(
      input$playground_2 # Matches the group_name of the bucket list
    )
  
  output$view1 <- renderPlot(get_image(train1, 1))
  output$view2 <- renderPlot(get_image(train1, 2))
  output$view3 <- renderPlot(get_image(train1, 3))
  output$view4 <- renderPlot(get_image(train1, 4))
  output$view5 <- renderPlot(get_image(train1, 5))
  output$view6 <- renderPlot(get_image(train1, 6))
  output$view7 <- renderPlot(get_image(train1, 7))
  output$view8 <- renderPlot(get_image(train1, 8))
  output$view9 <- renderPlot(get_image(train1, 9))
  output$view10 <- renderPlot(get_image(train1, 10))
}