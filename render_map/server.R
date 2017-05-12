library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
library(shiny)
library(plotly)
source('load_map.R')
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  values <- reactiveValues(A=1)
  regio_map = readOGR("../geo_map/regio.geojson", "OGRGeoJSON")
  adat <- data.table(read.csv('../data_eredmeny/szechenyi2020_adatok.csv'))
  adat$ev <- year(adat$datum)

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
    input$megye_shape_mouseover$id
    print(input$megye_shape_mouseover$id)
  })
  
  output$ezenvagyok <- renderText(my_mouse_on())
  
  
  cliked <- reactive({
    input$megye_shape_click$id
    print(input$megye_shape_click$id)
  })
  
  output$ezclik <- renderText(cliked())
  
  my_p_plotly<- reactive({
    adatom <- adat[MEGYE ==cliked(),list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=c('MEGYE','operativ_program' )]
    
    p <- plot_ly(adatom, x =~operativ_program, y = ~osszeg, type = 'bar')#%>%
      #layout(autosize = F, width = 1000, height = 800, margin = m, yaxis = y, xaxis = x )
    return(p)
  })
  
  output$summary_plot <- renderPlotly({
    my_p_plotly()
  })
  
  
  my_p_plotly2<- reactive({
        adatom2 <- adat[MEGYE ==cliked(),list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=c('MEGYE','ev' )]
    
    p <- plot_ly(adatom2, x =~ev, y = ~osszeg, type = 'bar')
    return(p)
  })
  
  output$summary_plot2 <- renderPlotly({
    my_p_plotly2()
  })

  
  
    
})



