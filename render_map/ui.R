library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  div(h1(textOutput('ezenvagyok'), align = "center")),
  
  hr(),
  leafletOutput("megye"),
  hr(),

  
fluidRow(
  column(6, plotlyOutput('summary_plot', height = 250), plotlyOutput('summary_plot2', height = 250))
),

  
  textOutput('ezclik')
  # Sidebar with a slider input for number of bins 

))


