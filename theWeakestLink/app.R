library(shiny)
library(shinyjs)
library(dplyr)

source("functions.R")

ui <- fluidPage(
  theme = "theme.css",
  useShinyjs(),
  titlePanel("De Zwakste Schakel"),
  tabsetPanel(
    tabPanel("Speel",
      uiOutput("current_score"),
      uiOutput("total_score"),
      div(class = "players",
        playerButtons("Dennis"),
        playerButtons("Jasper"),
        playerButtons("Lieke"),
        playerButtons("Piet"),
        playerButtons("Lies"),
        playerButtons("Jannes")
      )
    ), 
    tabPanel("Spelers Statestieken",
      div(class = "players",
        playerStatistics("Dennis"),
        playerStatistics("Jasper"),
        playerStatistics("Lieke"),
        playerStatistics("Piet"),
        playerStatistics("Lies"),
        playerStatistics("Jannes")
      )
    )
  )
)

server <- function(input, output, session) {
  
  rv <- reactiveValues(
    current_score = 0,
    total_score = 0,
    player_stats = 0
  )
  
  callModule(observePlayerButtons, "Dennis", rv)
  callModule(observePlayerButtons, "Jasper", rv)
  callModule(observePlayerButtons, "Lieke", rv)
  callModule(observePlayerButtons, "Piet", rv)
  callModule(observePlayerButtons, "Lies", rv)
  callModule(observePlayerButtons, "Jannes", rv)
  
  observe({
    removeAllClasses()
    addClass(as.character(rv$current_score), "current_score")
  })
  
  output$current_score <- renderUI({
    htmlTemplate("templates/current_score.html")
  }) 
  
  output$total_score <- renderUI({
    htmlTemplate("templates/total_score.html",
                 total_score = rv$total_score)
  })
  
}

shinyApp(ui = ui, server = server)

