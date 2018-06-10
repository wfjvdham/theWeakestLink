library(shiny)
library(dplyr)
library(purrr)

source("functions.R")

PLAYERS <- c("Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6")

ui <- fluidPage(
  theme = "theme.css",
  tags$head(
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/TweenMax.min.js"),
    tags$script(src = "script.js")
  ),
  titlePanel("De Zwakste Schakel"),
  tabsetPanel(
    tabPanel("Speel",
      uiOutput("current_score"),
      uiOutput("total_score"),
      div(class = "players",
          map(PLAYERS, playerButtons)
      )
    ), 
    tabPanel("Spelers Statestieken",
      div(id = "players_list", class = "players",
          map(PLAYERS, playerStatistics)
      )
    )
  )
)

server <- function (input, output, session, rv) {
  
  rv <- reactiveValues(
    current_score = 0,
    total_score = 0,
    player_stats = 0
  )
  
  map(PLAYERS, ~ callModule(observePlayerButtons, .x, rv))
  
  output$current_score <- renderUI({
    htmlTemplate("templates/current_score.html")
  }) 
  
  output$total_score <- renderUI({
    htmlTemplate("templates/total_score.html",
                 total_score = rv$total_score)
  })
  
}

shinyApp(ui = ui, server = server)

