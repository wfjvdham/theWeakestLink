library(shiny)
library(shinyjs)
library(dplyr)

source("functions.R")

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
        playerButtons("Bruna"),
        playerButtons("Dennis"),
        playerButtons("Jannes"),
        playerButtons("Jasper"),
        playerButtons("Lieke"),
        playerButtons("Lies"),
        playerButtons("Lindsey"),
        playerButtons("Piet")
      )
    ), 
    tabPanel("Spelers Statestieken",
      div(id = "players_list", class = "players",
        playerStatistics("Bruna"),
        playerStatistics("Dennis"),
        playerStatistics("Jannes"),
        playerStatistics("Jasper"),
        playerStatistics("Lieke"),
        playerStatistics("Lies"),
        playerStatistics("Lindsey"),
        playerStatistics("Piet")
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
  
  callModule(observePlayerButtons, "Bruna", rv)
  callModule(observePlayerButtons, "Dennis", rv)
  callModule(observePlayerButtons, "Jasper", rv)
  callModule(observePlayerButtons, "Lieke", rv)
  callModule(observePlayerButtons, "Piet", rv)
  callModule(observePlayerButtons, "Lies", rv)
  callModule(observePlayerButtons, "Lindsey", rv)
  callModule(observePlayerButtons, "Jannes", rv)
  
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

