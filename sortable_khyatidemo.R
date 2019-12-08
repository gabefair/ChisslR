library(shiny)
library(sortable)


ui <- fluidPage(
  fluidRow(
    column(
      tags$b("Current predictions"),
      width = 12,
      bucket_list(
        header = "Each class represented by the most confident and least confident prediction samples",
        group_name = "all",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot1" = plotOutput("view1", height=50, click = "plot_click"),
            "plot2" = plotOutput("view2", height=50, click = "plot_click"),
            "plot3" = plotOutput("view3", height=50, click = "plot_click")
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot4" = plotOutput("view4", height=50, click = "plot_click"),
            "plot5" = plotOutput("view5", height=50, click = "plot_click"),
            "plot6" = plotOutput("view6", height=50, click = "plot_click")
          ),
          input_id = "rank_list_4"
        )
      )
    ),
    column(
      tags$b("Playground"),
      width = 8,
      bucket_list(
        header = "Classes to explore",
        group_name = "all",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag classes here for exploration",
          labels = list(
            "four",
            "five",
            "six"
          ),
          input_id = "rank_list_2"
        ),
        add_rank_list(
          text = "Explore class here",
          labels = list(
            "seven",
            "eight",
            "nine"
          ),
          input_id = "rank_list_3"
        )
      )
    ),
    column(
      tags$b("Confidence plots"),
      width = 4,
      column(
        tags$b(" "),
        width = 12,
        
        tags$p("input$rank_list_1"),
        verbatimTextOutput("results_1"),
        
        tags$p("input$rank_list_2"),
        verbatimTextOutput("results_2"),
        
        tags$p("input$rank_list_3"),
        verbatimTextOutput("results_3"),
        
        tags$p("input$rank_list_4"),
        verbatimTextOutput("results_4")
      )
    )
  )
)

server <- function(input,output) {
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
  
  output$view1 <- renderPlot({
    m = t(apply(matrix(unlist(train1[1,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
  output$view2 <- renderPlot({
    m = t(apply(matrix(unlist(train1[2,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
  output$view3 <- renderPlot({
    m = t(apply(matrix(unlist(train1[3,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
  output$view4 <- renderPlot({
    m = t(apply(matrix(unlist(train1[4,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
  output$view5 <- renderPlot({
    m = t(apply(matrix(unlist(train1[5,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
  output$view6 <- renderPlot({
    m = t(apply(matrix(unlist(train1[6,-1]), nrow=28, byrow=TRUE), 2, rev))
    par(mfrow=c(1,1),
        oma = c(0,0,0,0) + 0.1, # bottom, left, top, right
        mar = c(0,0,0,0) + 0.1)
    image(m, col=grey.colors(255), axes=FALSE, asp=1)
  })
}


shinyApp(ui, server)