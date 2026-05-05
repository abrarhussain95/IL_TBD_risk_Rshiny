library(shiny)
library(htmltools)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .container-fluid {
        width: 100%;
        max-width: 1600px;
      }
      iframe {
        background-color: white;
      }
    "))
  ),
  
  titlePanel("Monthly tick-borne diseases' risk in Illinois"),
  
  tabsetPanel(
    
    # ── COUNTY BASED MAPS ──
    tabPanel(
      "County Based Maps",
      br(),
      tabsetPanel(
        tabPanel(
          tags$span(tags$i("Amblyomma americanum"), " (Lone Star Tick)"),
          br(),
          tags$iframe(
            src = "map_aa_monthly.html",
            style = "width:100%; height:850px; border:none;"
          )
        ),
        tabPanel(
          tags$span(tags$i("Dermacentor variabilis"), " (American Dog Tick)"),
          br(),
          tags$iframe(
            src = "map_dv_monthly.html",
            style = "width:100%; height:850px; border:none;"
          )
        ),
        tabPanel(
          tags$span(tags$i("Ixodes scapularis"), " (Black-legged Tick)"),
          br(),
          tags$iframe(
            src = "map_is_monthly.html",
            style = "width:100%; height:850px; border:none;"
          )
        )
      )
    ),
    
    # ── HEAT MAPS ──
    tabPanel(
      "Heat Maps",
      br(),
      tabsetPanel(
        tabPanel(
          tags$span(tags$i("Amblyomma americanum"), " (Lone Star Tick)"),
          br(),
          tags$iframe(
            src = "map_aa_idw.html",
            style = "width:100%; height:850px; border:none;"
          )
        ),
        tabPanel(
          tags$span(tags$i("Dermacentor variabilis"), " (American Dog Tick)"),
          br(),
          tags$iframe(
            src = "map_dv_idw.html",
            style = "width:100%; height:850px; border:none;"
          )
        ),
        tabPanel(
          tags$span(tags$i("Ixodes scapularis"), " (Black-legged Tick)"),
          br(),
          tags$iframe(
            src = "map_is_idw.html",
            style = "width:100%; height:850px; border:none;"
          )
        )
      )
    )
    
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)