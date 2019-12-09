library(shiny)
# library(sortable)
library(cowplot)
source("helpers/helper-ui.R") #Put helper functions here and not at the top of this file

fluidPage(
  fluidRow(
    column(
      tags$b("Current predictions"),
      width = 12,
      bucket_list(
        header = "Each class represented by the most confident and least confident prediction samples - drag from here into playground for exploration",
        group_name = "all",
        orientation = "horizontal",
        add_rank_list(
          text = "",
          labels = list(
            "pred0" = plotOutput("view0", height=50, width = 50),
            "pred1" = plotOutput("view1", height=50, width = 50)
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "",
          labels = list(
            "pred2" = plotOutput("view2", height=50, width = 50),
            "pred3" = plotOutput("view3", height=50, width = 50)
          ),
          input_id = "rank_list_2"
        ),
        add_rank_list(
          text = "",
          labels = list(
            "pred4" = plotOutput("view4", height=50, width = 50),
            "pred5" = plotOutput("view5", height=50, width = 50)
          ),
          input_id = "rank_list_3"
        ),
        add_rank_list(
          text = "",
          labels = list(
            "pred6" = plotOutput("view6", height=50, width = 50),
            "pred7" = plotOutput("view7", height=50, width = 50)
          ),
          input_id = "rank_list_4"
        ),
        add_rank_list(
          text = "",
          labels = list(
            "pred8" = plotOutput("view8", height=50, width = 50),
            "pred9" = plotOutput("view9", height=50, width = 50)
          ),
          input_id = "rank_list_5"
        )
      )
    ),
    column(
      tags$b("Playground"),
      width = 4,
      bucket_list(
        header = "Drag classes here for exploration",
        group_name = "all",
        orientation = "horizontal",
        add_rank_list(
          text = "",
          labels = list(
            
          ),
          input_id = "playground_1"
        )
      )
    ),
    column(
      width = 4,
      # plotOutput("see_this", height=50, width = 50)
      verbatimTextOutput("see_this")
    ),
    column(
      tags$b("Confidence plots"),
      width = 4,
      column(
        tags$b(""),
        width = 12,
        
        tags$p("input$playground_1"),
        verbatimTextOutput("playground_1")
      )
    )
  )
)