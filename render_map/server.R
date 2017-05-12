library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
library(shiny)
source('load_map.R')
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  values <- reactiveValues(A=1)
  regio_map = readOGR("../geo_map/regio.geojson", "OGRGeoJSON")
  
  
  
  my_zoom_level <- reactive({
    return(as.numeric(input$mymap_zoom))
  })
  
 
  

  output$regio <- renderLeaflet({
   
      return(get_regio())
  })
  
  output$megye <- renderLeaflet({
    
    return(get_megye())
  })

  
  output$enyiazoom <- renderText(my_zoom_level())
  
  my_mouse_on <- reactive({
    input$mymap_shape_mouseover$id
    print(input$mymap_shape_mouseover$id)
  })
  
  output$ezenvagyok <- renderText('my_mouse_on()')
  
  
})
