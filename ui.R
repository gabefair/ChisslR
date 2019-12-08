library(shiny)
library(sortable)
source("helpers/helper-ui.R") #Put helper functions here and not at the top of this file

fluidPage(
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
            "plot1" = plotOutput("view1", height=50),
            "plot2" = plotOutput("view2", height=50)
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot3" = plotOutput("view3", height=50),
            "plot4" = plotOutput("view4", height=50)
          ),
          input_id = "rank_list_2"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot5" = plotOutput("view5", height=50),
            "plot6" = plotOutput("view6", height=50)
          ),
          input_id = "rank_list_3"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot7" = plotOutput("view7", height=50),
            "plot8" = plotOutput("view8", height=50)
          ),
          input_id = "rank_list_4"
        ),
        add_rank_list(
          text = "Drag from here into playground",
          labels = list(
            "plot9" = plotOutput("view9", height=50),
            "plot10" = plotOutput("view10", height=50)
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