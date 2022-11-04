library(shiny)
library(ggplot2)


data_a <- data.frame(dose=c("D0.5", "D1", "D2", "D4"),
                     len=c(4.2, 10, 29.5, 18))

data_b <- data.frame(dose=c("D3", "D4", "D5", "D9", "D11"),
                     len=c(30, 15, 9.3, 14, 22))


ui <- fluidPage(
  #First input
  selectInput("data", "Pick a data", c('DataA','DataB')),
  #Second input
  selectInput("graph", "Pick a display type", c('bar graph', 'line chart')),
  #Output
  plotOutput("plot", width = "400px")
)

server <- function(input, output, session) {
  curdata <- reactive({
    switch(input$data, DataA = data_a, DataB = data_b)
  })

  output$plot <- renderPlot({
    if (input$graph == "bar graph"){
      ggplot(data=curdata(),
             aes(x=curdata()$dose, y=curdata()$len)) + geom_bar(stat="identity")
    } else if (input$graph == "line chart"){
      ggplot(data=curdata(),
             aes(x=curdata()$dose, y=curdata()$len, group=1)) + geom_line()+geom_point()
    }
  })
}

shinyApp(ui, server)

