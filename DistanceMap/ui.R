library(shiny)
library(base64enc)
library(rCharts)
distance <<- read.csv("data/distance.csv", row.names = 1, 
                      header = TRUE, fileEncoding="UTF-8",
                      check.names = FALSE)
coordinates <<- as.matrix(read.csv("data/coordinates.csv", 
                                   row.names = "City", header = TRUE, 
                                   fileEncoding="UTF-8", check.names = FALSE))
Sys.setlocale("LC_ALL","English")


shinyUI(
      fluidPage(theme = "bootstrap.min.css",
            titlePanel("Distances between US cities"),
            
            fluidRow(
                  column(3,
                         br(),
                         br(),
                         br(),
                         textOutput("info")),
                  column(3,
                         br(),
                         selectInput("cit1", "Distance between...", choices = rownames(distance)),
                         selectInput("cit2", "and...", choices = names(distance))),
                  column(3, 
                         br(),
                         br(),
                         br(),
                         br(),
                         actionButton("goButton", "Submit")
                  ),
                  column(3,
                         helpText("App created by ", a("André Martinez", href = "https://github.com/Licister", target = "_blank"), "."),
                         helpText("Repository: ", a("DistanceMap", href = "https://github.com/Licister/DistanceMap", target = "_blank"), "."),
                         helpText("Data set used: ", a("UScitiesD", href = "https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/eurodist.html", target = "_blank"), 
                                  " available in the base R installation; coordinates from ", 
                                  a("Google Maps", href = "https://maps.google.com", target = "_blank"), "."),
                         helpText("Libraries used: ", a("Shiny", href = "http://shiny.rstudio.com/", target = "_blank"), 
                                  " and ", a("rCharts", href = "http://rcharts.io/", target = "_blank"), "."),
                         helpText("CSS theme used: ", a("Darkly", href = "http://bootswatch.com/darkly/", target = "_blank"), ".")
                  )
            ),
            
            mainPanel(
                  h4(textOutput("text1")),
                  chartOutput("usa", "leaflet"),
                  tags$style('.leaflet {height: 400px; width: 750px;}')
            )
      )
)

