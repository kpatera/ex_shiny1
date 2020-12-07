library(shiny)

xAxisGroup <- c("Heap", "CPU", "Volume","slider","slider2")

ui <- shinyUI(fluidPage(
  
  titlePanel("Dynamic sliders"),
  
  sidebarLayout(
    sidebarPanel(
      # Create a uiOutput to hold the sliders
      uiOutput("sliders")
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

server <- shinyServer(function(input, output) {
  
  #Render the sliders
  output$sliders <- renderUI({
    # First, create a list of sliders each with a different name
    sliders <- lapply(1:length(xAxisGroup), function(i) {
      inputName <- xAxisGroup[i]
      sliderInput(inputId = inputName, label = inputName, min=0, max=100, value=0, post="%")
    })
    # Create a tagList of sliders (this is important)
    do.call(tagList, sliders)
  })
  
  
  output$distPlot <- renderPlot({
    hist(rnorm(100), col = 'darkgray', border = 'white')
  })
})

shinyApp(ui = ui, server = server)