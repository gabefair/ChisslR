library(shiny)
# library(sortable)
library(cowplot)
source("helpers/helper-ui.R") #Put helper functions here and not at the top of this file

fluidPage(
  
  titlePanel("Exploring the 20-newsgroups dataset"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
    ),
    
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("EDA",
                 tabsetPanel(type = "pills",
                             tabPanel("Messages in each group", plotOutput("msg_in_each_newsgroup", width = "85%")),
                             tabPanel("Sentiment Analysis", plotOutput("sentiment")),
                             tabPanel("Sentiments expressed by word", plotOutput("sentiment_by_word"))
                 ),
        ),
        tabPanel("Exploring the 'science' groups",
         tabsetPanel(type = "pills",
                     tabPanel("TF-IDF", plotOutput("tfidf_selected")),
                     tabPanel("Topic Model", plotOutput("sci_topic_model")),
                     tabPanel("Misclassifications", plotOutput("sci_misclassifications"))
         )
        ),
        tabPanel("UI",
                 htmlOutput("react")
        )
      )
    )
  )
)