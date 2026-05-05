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
    tabPanel(
      tags$i("Amblyomma americanum"),
      br(),
      tags$iframe(
        src = "map_aa_monthly.html",
        style = "width:100%; height:850px; border:none;"
      )
    ),
    tabPanel(
      tags$i("Dermacentor variabilis"),
      br(),
      tags$iframe(
        src = "map_dv_monthly.html",
        style = "width:100%; height:850px; border:none;"
      )
    ),
    tabPanel(
      tags$i("Ixodes scapularis"),
      br(),
      tags$iframe(
        src = "map_is_monthly.html",
        style = "width:100%; height:850px; border:none;"
      )
    ),
    tabPanel(
      "Heat Maps",
      br(),
      tags$iframe(
        src = "maps_combined_idw.html",
        style = "width:100%; height:850px; border:none;"
      )
    )
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)