library(shiny)
library(stringi)
library (reactR) # devtools::install_github("react-R/reactR")
library (usethis); library(htmlwidgets) # install.packages(c("usethis", "htmlwidgets"))
source("helpers/helper-server.R") #Put helper functions here and not at the top of this file

function(input, output) {
  pred_list <- load_data()
  
  output$playground_1 <-
    renderPrint(
      input$playground_1 # Matches the group_name of the bucket list
    )
  
  index <- 1
  output$view0 <- renderPlot(get_image(pred_list$pred0, index))
  output$view1 <- renderPlot(get_image(pred_list$pred1, index))
  output$view2 <- renderPlot(get_image(pred_list$pred2, index))
  output$view3 <- renderPlot(get_image(pred_list$pred3, index))
  output$view4 <- renderPlot(get_image(pred_list$pred4, index))
  output$view5 <- renderPlot(get_image(pred_list$pred5, index))
  output$view6 <- renderPlot(get_image(pred_list$pred6, index))
  output$view7 <- renderPlot(get_image(pred_list$pred7, index))
  output$view8 <- renderPlot(get_image(pred_list$pred8, index))
  output$view9 <- renderPlot(get_image(pred_list$pred9, index))
  
  
  # output$see_this <- renderPlot({
  #   validate(
  #     need(input$playground_1 != '', "Waiting for the selection of a prediction class...")
  #   )
  # })
    for (i in input$playground_1) {
      output$see_this <- renderPlot(get_image(pred_list[i], 2))
    }
    
    # get_image(pred_list[input$playground_1], 2)
    # if ("pred0" %in% reactiveValuesToList(input$playground_1)) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred0, 2))
    # }
    # } else if ("pred1" %in% reactive(input$playground_1)) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred1, index))
    # } else if ("pred2" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred2, index))
    # } else if ("pred3" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred3, index))
    # } else if ("pred4" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred4, index))
    # } else if ("pred5" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred5, index))
    # } else if ("pred6" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred6, index))
    # } else if ("pred7" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred7, index))
    # } else if ("pred8" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred8, index))
    # } else if ("pred9" %in% in_playground()) {
    #   output$see_this <- renderPlot(get_image(pred_list$pred9, index))
    # } else {
    #   print("ugh")
    # }
  
}