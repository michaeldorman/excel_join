library(shiny)

shinyUI(fluidPage(
  titlePanel("Joining first two excel sheets by fulcrum_id and fulcrum_parent_id"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose Excel File'),
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput('Tab')
    )
  )
))