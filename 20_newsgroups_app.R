library(shiny)
library(tidyverse)
library(viridis)
library(tm)
library(ggwordcloud)

# currently only works alongside the 20_newsgroups_explore_khyatidemo.Rmd

ui <- fluidPage(
  
  titlePanel("Exploring the 20-newsgroups dataset"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
    ),

    mainPanel(
      tabsetPanel(
        type = "pills",
        tabPanel("EDA",
          tabsetPanel(type = "tabs",
            tabPanel("Messages in each group", plotOutput("msg_in_each_newsgroup")),
            tabPanel("Sentiment Analysis", plotOutput("sentiment")),
            tabPanel("Sentiments expressed by word", plotOutput("sentiment_by_word"))
          ),
        ),
        tabPanel("Exploring the 'science' groups",
          tabsetPanel(type = "tabs",
            tabPanel("TF-IDF", plotOutput("tfidf_selected")),
            tabPanel("Topic Model", plotOutput("sci_topic_model")),
            tabPanel("Misclassifications", plotOutput("sci_misclassifications"))
            )
        )
      )
    )
  )
)

# Define server logic for random distribution app ----
server <- function(input, output) {
  output$msg_in_each_newsgroup <- renderPlot({
    raw_text %>%
      group_by(newsgroup) %>%
      summarize(messages = n_distinct(id)) %>%
      ggplot(aes(reorder(newsgroup, messages), messages)) +
      geom_col(fill = viridis(1), alpha = 0.4) +
      theme_bw() +
      scale_y_continuous(expand = c(0, 0)) +
      coord_flip()
  })
  
  output$sentiment <- renderPlot({
    newsgroup_sentiments %>%
      mutate(newsgroup = reorder(newsgroup, value)) %>%
      ggplot(aes(newsgroup, value, fill = value > 0)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      ylab("Average sentiment value") +
      theme_minimal() +
      scale_fill_viridis_d(end = 0.5)
  })
  
  output$sentiment_by_word <- renderPlot({
    contributions %>%
      top_n(25, abs(contribution)) %>%
      mutate(word = reorder(word, contribution)) %>%
      ggplot(aes(word, contribution, fill = contribution > 0)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      theme_minimal() +
      scale_fill_viridis_d(end = 0.5)
  })
  
  output$tfidf_selected <- renderPlot({
    tf_idf %>%
      filter(str_detect(newsgroup, "^sci\\.")) %>%
      group_by(newsgroup) %>%
      top_n(12, tf_idf) %>%
      ungroup() %>%
      mutate(word = reorder(word, tf_idf)) %>%
      ggplot(aes(word, tf_idf, fill = newsgroup)) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~ newsgroup, scales = "free") +
      ylab("tf-idf") +
      scale_y_continuous(expand = c(0, 0)) +
      coord_flip() +
      theme_bw() +
      scale_fill_viridis_d()
  })
  
  output$sci_topic_model <- renderPlot({
    sci_lda %>%
      tidy() %>%
      group_by(topic) %>%
      top_n(8, beta) %>%
      ungroup() %>%
      mutate(term = reorder_within(term, beta, topic)) %>%
      ggplot(aes(term, beta, fill = factor(topic))) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~ topic, scales = "free_y") +
      scale_y_continuous(expand = c(0, 0)) +
      coord_flip() +
      scale_x_reordered() +
      theme_bw() +
      scale_fill_viridis_d()
  })
  
  output$sci_misclassifications <- renderPlot({
    sci_lda %>%
      tidy(matrix = "gamma") %>%
      separate(document, c("newsgroup", "id"), sep = "_") %>%
      mutate(newsgroup = reorder(newsgroup, gamma * topic)) %>%
      ggplot(aes(factor(topic), gamma)) +
      geom_boxplot() +
      facet_wrap(~ newsgroup) +
      labs(x = "Topic",
           y = "# of messages where this was the highest % topic") +
      theme_bw()
  })
}

shinyApp(ui, server)