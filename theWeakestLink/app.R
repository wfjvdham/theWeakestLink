library(shiny)
library(shinyjs)
library(dplyr)

ui <- fluidPage(
  theme = "theme.css",
  useShinyjs(),
  titlePanel("De Zwakste Schakel"),
  tabsetPanel(
    tabPanel("Speel",
      uiOutput("current_score"),
      uiOutput("total_score"),
      hr(),
      actionButton("goed", "Goed"),
      actionButton("fout", "Fout"),
      actionButton("bank", "Bank")
    ), 
    tabPanel("Spelers Statestieken")
    )
)

server <- function(input, output) {
  
  rv <- reactiveValues(
    current_score = 0,
    total_score = 0
  )
  
  observeEvent(input$goed, {
    rv$current_score <- case_when(
      rv$current_score == 0 ~ 50,
      rv$current_score == 50 ~ 100,
      rv$current_score == 100 ~ 200,
      rv$current_score == 200 ~ 300,
      rv$current_score == 300 ~ 450,
      rv$current_score == 450 ~ 600,
      rv$current_score == 600 ~ 800,
      rv$current_score == 800 ~ 1000,
      TRUE ~ 1000)
  })
  
  observeEvent(input$fout, {
    rv$current_score <- 0
  })
  
  observeEvent(input$bank, {
    rv$total_score <- rv$total_score + rv$current_score
    rv$current_score <- 0
  })
  
  removeAllClasses <- function () {
    removeClass("1000", "current_score")
    removeClass("800", "current_score")
    removeClass("600", "current_score")
    removeClass("450", "current_score")
    removeClass("300", "current_score")
    removeClass("200", "current_score")
    removeClass("100", "current_score")
    removeClass("50", "current_score")
    removeClass("0", "current_score")
  }
  
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

