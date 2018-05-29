library(shiny)
library(shinyjs)
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
  useShinyjs(),
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
  
  observe({
    addClass(as.character(rv$current_score), "current_score")
    if (rv$current_score == 0) {
      removeClass("1000", "current_score")
      removeClass("800", "current_score")
      removeClass("600", "current_score")
      removeClass("450", "current_score")
      removeClass("300", "current_score")
      removeClass("200", "current_score")
      removeClass("100", "current_score")
      removeClass("50", "current_score")
    }
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

