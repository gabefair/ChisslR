library(shiny)
library(shinythemes)
# library(sortable)
library(cowplot)
source("helpers/helper-ui.R") #Put helper functions here and not at the top of this file

fluidPage(theme = shinytheme("cerulean"),
  
  titlePanel("Welcome to the chisslR app!"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      h3('Exploring the 20-newsgroups dataset'),
      p('Use the tabs in the main panel to epxlore various visualization for the 20-newsgroups dataset.'),
      br(),
      p('Tab 1: exploratory data analysis (EDA). 
        It contains 3 sub tabs which show the visualizations for how many messages are present in each group,
        the average sentiments expressed in each newsgroup, and the 
        words that contribute most to the sentiment expression.'),
      p("Tab 2: explore the 'science' group from the newsgroups. 
        It contains 3 plots that show the most frequent words by TF-IDF, a topic model for the subgroups
        in the science group, and potential misclassifications in the subgroups."),
      p('Tab 3: the `chissl` app. Use it to train a tranductive model!')
    ),
    
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("EDA",
                 tabsetPanel(type = "pills",
                             tabPanel("Messages in each group", 
                                      br(),
                                      plotOutput("msg_in_each_newsgroup", width = "85%")),
                             tabPanel("Sentiment Analysis",
                                      br(),
                                      plotOutput("sentiment")),
                             tabPanel("Sentiments expressed by word",
                                      br(),
                                      plotOutput("sentiment_by_word"))
                 ),
        ),
        tabPanel("Exploring the 'science' groups",
         tabsetPanel(type = "pills",
                     tabPanel("TF-IDF", 
                              br(),
                              plotOutput("tfidf_selected")),
                     tabPanel("Topic Model", 
                              br(),
                              plotOutput("sci_topic_model")),
                     tabPanel("Misclassifications", 
                              br(),
                              plotOutput("sci_misclassifications"))
         )
        ),
        tabPanel("chisslR",
                 htmlOutput("react")
        )
      )
    )
  )
)