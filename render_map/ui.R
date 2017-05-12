library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  tabsetPanel(
    tabPanel("Régió",
             fluidRow(
             column(8, leafletOutput("regio")),
             column(12, textOutput("ezenvagyok"))
             
             
             )),
    tabPanel("Megye", leafletOutput("megye")),
    textOutput('ezenvagyok')
    ),

  
  textOutput('enyiazoom'),
  textOutput('ezenvagyok')
  # Sidebar with a slider input for number of bins 

))


