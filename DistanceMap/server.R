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


shinyServer(
      function(input, output) {
            city1 <- reactive({as.character(input$cit1)})
            city2 <- reactive({as.character(input$cit2)})
            
            output$info <- renderText({
                  "This app shows the straight line distance between two cities and displays their location on a map. 
                  To begin, select two cities on the right and press submit."})
            
            output$text1 <- renderText({
                  input$goButton
                  if (input$goButton == 0) {
                        "Waiting for input..."
                  }
                  else {
                        isolate(
                        paste("Distance between ", city1(), " and ", city2(), ": ", 
                              distance[city1(), city2()], 
                              " miles (", round(distance[as.character(city1()), 
                                                         as.character(city2())] * 1.609344,
                                                digits = 0), 
                              " kilometers).", sep = "")
                        )
                  }
            })
            
            
            
            output$usa <-                 
                  renderMap({
                  input$goButton
                  if(input$goButton == 0){
                        usa <- Leaflet$new()
                        usa$setView(c(37, -95), zoom = 4)
                        return(usa)
                  } else {
                        isolate({usa <- Leaflet$new()
                        usa$setView(c(37, -95), zoom = 4)
                        usa$marker(as.numeric(as.vector(coordinates[city1(),])), 
                                   bindPopup = city1())
                        usa$marker(as.numeric(as.vector(coordinates[city2(),])), 
                                   bindPopup = city2())
                        return(usa)
                        })
                  }
            })
            
      }
)

