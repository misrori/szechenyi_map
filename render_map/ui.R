library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  leafletOutput("megye"),
  plotlyOutput('summary_plot'),

  
  textOutput('enyiazoom'),
  textOutput('ezenvagyok')
  # Sidebar with a slider input for number of bins 

))


