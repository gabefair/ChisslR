library(shiny)
library(sparklines)

ui <- fluidPage(
  titlePanel("reactR HTMLWidget Example"),
  sparklinesOu tput('widgetOutput')
)

server <- function(input, output, session) {
  output$widgetOutput <- renderSparklines(
    sparklines("Hello world!")
  )
}

shinyApp(ui, server)
