library(shiny)
library(bs4Dash)
source("helpers/helper-ui.R") #Put helper functions here and not at the top of this file

bs4DashPage(
  navbar = bs4DashNavbar(),
  sidebar = bs4DashSidebar(
    skin = "light",
    bs4SidebarMenu(
      bs4SidebarHeader("Main content"),
      bs4SidebarMenuItem(
        "Classic theme",
        tabName = "classic",
        icon = "desktop"
      )
    )
  ),
  controlbar = bs4DashControlbar(
    skin = "light"
  ),
  
  footer = bs4DashFooter(),
  title = "Classic theme",
  body = bs4DashBody(
    plotOutput("view", height=50, click = "plot_click"),
    bs4TabItems(
      bs4TabItem(
        tabName = "classic",
        fluidRow(
          bs4Box(
            height = "600px",
            title = "Box 1"
          ),
          bs4Box(
            height = "600px",
            title = "Box 2"
          ),
          sliderInput("bins",
                      "Number of bins:",
                      min = 1,
                      max = 50,
                      value = 30)
        ), 
        plotOutput("distPlot")
        
      )
    )
  )
)