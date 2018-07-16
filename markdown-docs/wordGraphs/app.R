library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Simple .txt file data"),
  mainPanel(
    textInput("delimiter", "Input word delimiter"),
    fileInput("fileInput", "Choose .txt file", accept = c("text/plain")),
    actionButton("fileChosen", "Analyze!"),
    textOutput("avgLen"),
    plotOutput("wordLCount")
  )
)

server <- function(input, output) {
  data <- reactive({
    textFile <- scan(as.character(input$fileInput$datapath),
                     what = "",
                     sep = input$delimiter)
    
    return(textFile)
  })
  
  observeEvent(input$fileChosen, {
    print(sum(nchar(data(), "chars"))/length(data()))
    output$avgLen <- renderText({
      newData <- data()
      paste("Average length of words in file:", sum(nchar(newData, "chars"))/length(newData))})
    
    output$wordLCount <- renderPlot({
      vals <- as.data.frame(table(nchar(data(), "chars")))
      ggplot(vals, aes(Var1, Freq)) +
        labs(y = "Number of Occurrences", x = "Length of Word") +
        geom_bar(stat = "identity")
    })
  })
}

shinyApp(ui = ui, server = server)