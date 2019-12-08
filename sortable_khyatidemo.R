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
            "plot1" = plotOutput("view1", height=50, width = 50),
            "plot2" = plotOutput("view2", height=50, width = 50)
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot3" = plotOutput("view3", height=50, width = 50),
            "plot4" = plotOutput("view4", height=50, width = 50)
          ),
          input_id = "rank_list_2"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot5" = plotOutput("view5", height=50, width = 50),
            "plot6" = plotOutput("view6", height=50, width = 50)
          ),
          input_id = "rank_list_3"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot7" = plotOutput("view7", height=50, width = 50),
            "plot8" = plotOutput("view8", height=50, width = 50)
          ),
          input_id = "rank_list_4"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot9" = plotOutput("view9", height=50, width = 50),
            "plot10" = plotOutput("view10", height=50, width = 50)
          ),
          input_id = "rank_list_5"
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
          input_id = "playground_1"
        ),
        add_rank_list(
          text = "Explore class here",
          labels = list(
            "seven",
            "eight",
            "nine"
          ),
          input_id = "playground_2"
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
        verbatimTextOutput("results_4"),
        
        tags$p("input$rank_list_5"),
        verbatimTextOutput("results_5"),
        
        tags$p("input$playground_1"),
        verbatimTextOutput("playground_1"),
        
        tags$p("input$playground_2"),
        verbatimTextOutput("playground_2")
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
  
  output$view1 <- renderPlot(get_image(selected_sample_data, 1))
  output$view2 <- renderPlot(get_image(selected_sample_data, 2))
  output$view3 <- renderPlot(get_image(selected_sample_data, 3))
  output$view4 <- renderPlot(get_image(selected_sample_data, 4))
  output$view5 <- renderPlot(get_image(selected_sample_data, 5))
  output$view6 <- renderPlot(get_image(selected_sample_data, 6))
  output$view7 <- renderPlot(get_image(selected_sample_data, 7))
  output$view8 <- renderPlot(get_image(selected_sample_data, 8))
  output$view9 <- renderPlot(get_image(selected_sample_data, 9))
  output$view10 <- renderPlot(get_image(selected_sample_data, 10))
}


shinyApp(ui, server)