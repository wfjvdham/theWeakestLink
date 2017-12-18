playerButtons <- function(id) {
  ns <- NS(id)
  
  div(class="player_buttons",
    h1(id),
    actionButton(ns("goed"), "Goed"),
    actionButton(ns("fout"), "Fout"),
    actionButton(ns("bank"), "Bank")
  )
}

playerStatistics <- function(id) {
  ns <- NS(id)
  
  div(class="player_buttons",
    h1(id),
    uiOutput(ns("stats"))
  )
}

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

observePlayerButtons <- function (input, output, session, rv) {
  
  rv_player <- reactiveValues()
  rv_player[[session$ns("stats")]] <- reactiveValues(
    n_goed = 0,
    n_fout = 0,
    cash = 0
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
    rv_player[[session$ns("stats")]]$n_goed <- 
      rv_player[[session$ns("stats")]]$n_goed + 1
  })
  
  observeEvent(input$fout, {
    rv$current_score <- 0
    rv_player[[session$ns("stats")]]$n_fout <- 
      rv_player[[session$ns("stats")]]$n_fout + 1
  })
  
  observeEvent(input$bank, {
    rv_player[[session$ns("stats")]]$cash <- 
      rv_player[[session$ns("stats")]]$cash + rv$current_score
    rv$total_score <- rv$total_score + rv$current_score
    rv$current_score <- 0
  })
  
  output$stats <- renderUI({
    n_goed <- rv_player[[session$ns("stats")]]$n_goed
    n_fout <- rv_player[[session$ns("stats")]]$n_fout
    perc_goed <- 0
    if (n_goed + n_fout > 0) {
      perc_goed <- round(n_goed / (n_goed + n_fout) * 100)
    } 
    cash <- rv_player[[session$ns("stats")]]$cash
    htmlTemplate("templates/stats.html",
                 n_goed = n_goed,
                 n_fout = n_fout,
                 perc_goed = perc_goed,
                 cash = cash)
  })
}

