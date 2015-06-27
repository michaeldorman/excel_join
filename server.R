library(shiny)
library(readxl)
library(plyr)

Sys.setlocale(locale = "Hebrew")

shinyServer(function(input, output) {
  
  dat = reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL) 
    file.rename(inFile$datapath,
      paste(inFile$datapath, ".xlsx", sep=""))
    
    df1 = read_excel(
      paste(inFile$datapath, ".xlsx", sep=""),
      1)
    df2 = read_excel(
      paste(inFile$datapath, ".xlsx", sep=""),
      2)  
    colnames(df1)[which(colnames(df1) == "fulcrum_id")] = "ID"
    colnames(df2)[which(colnames(df2) == "fulcrum_parent_id")] = "ID"
    dat = join(df1, df2, by = "ID", type = "right")
    dat
      })
  
  output$Tab <- renderTable({
    dat()
  })
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    
    content = function(file) {
        write.csv(dat(), file, row.names = FALSE, fileEncoding = "iso8859-8")
    }
  )
})