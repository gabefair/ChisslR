library(shiny)
library(sortable)
library(patchwork)

ui <- fluidPage(
  titlePanel(h1("App Title", align = "center")),
  
  sidebarLayout(position = "left",
                sidebarPanel(h4("Choose a class to explore:", align = "center"),
                             width = 3,
                             selectInput(inputId = "selected_class",
                                         label = "Select class:",
                                         choices = c("0" = "zero",
                                                     "1" = "one",
                                                     "2" = "two",
                                                     "3" = "three",
                                                     "4" = "four",
                                                     "5" = "five",
                                                     "6" = "six",
                                                     "7" = "seven",
                                                     "8" = "eight",
                                                     "9" = "nine")),
                             verbatimTextOutput("info")
                ),
                mainPanel(h4("Main panel title", align = "center"),
                          fluidRow(
                            h5("Main classes:", align = "center"),
                            splitLayout(cellWidths = c("10%", "10%"),
                                        plotOutput("view0", height=50, width = 50),
                                        plotOutput("view1", height=50, width = 50),
                                        plotOutput("view2", height=50, width = 50),
                                        plotOutput("view3", height=50, width = 50),
                                        plotOutput("view4", height=50, width = 50),
                                        plotOutput("view5", height=50, width = 50),
                                        plotOutput("view6", height=50, width = 50),
                                        plotOutput("view7", height=50, width = 50),
                                        plotOutput("view8", height=50, width = 50),
                                        plotOutput("view9", height=50, width = 50))
                          ),
                          fluidRow(
                            h5("Exploration playground:", align = "center"),
                            splitLayout(cellWidths = c("10%", "10%"),
                                        plotOutput("explore0", height=50, width = 50),
                                        plotOutput("explore1", height=50, width = 50),
                                        plotOutput("explore2", height=50, width = 50),
                                        plotOutput("explore3", height=50, width = 50),
                                        plotOutput("explore4", height=50, width = 50),
                                        plotOutput("explore5", height=50, width = 50),
                                        plotOutput("explore6", height=50, width = 50),
                                        plotOutput("explore7", height=50, width = 50),
                                        plotOutput("explore8", height=50, width = 50),
                                        plotOutput("explore9", height=50, width = 50))
                          )
                )
  )
)


server <- function(input,output) {
  get_image <- function(data, index) {
    m = t(apply(matrix(unlist(data[index,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  }
  
  # get_grid <- function(data, indices) {
  #   g <- get_image(data, 1)
  #   for (i in indices) {
  #     g <- g + get_image(data, i)
  #   }
  #   return(g)
  # }
  
  load_data <- function() {
    data <- read_csv("Rhissl/data/selected-sample-data.csv")
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
  
  index <- 1
  pred_list <- load_data()
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
  
  output$info <- renderText({
    paste("Selected class: ", input$selected_class)
  })
  
  index_to_explore <- 2
  output$explore0 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore1 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore2 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore3 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore4 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore5 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore6 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore7 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore8 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
  output$explore9 <- renderPlot({
    validate(need(input$selected_class == "one", ""))
    index_to_explore <- index_to_explore + 1
    get_image(pred_list$pred1, index_to_explore)
  })
}


shinyApp(ui, server)