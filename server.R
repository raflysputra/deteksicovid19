library(data.table)
library(randomForest)

model <- readRDS("model.rds")
server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
  
    df <- data.frame(
      Name = c("ï..zonakota",
               "suhubadan",
               "tensi",
               "keluarkota"),
      Value = as.character(c(input$ï..zonakota,
                             input$suhubadan,
                             input$tensi,
                             input$keluarkota)),
      stringsAsFactors = FALSE)
    
    peluangcovid <- "peluangcovid"
    df <- rbind(df, peluangcovid)
    input <- t(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    test$ï..zonakota <- factor(test$ï..zonakota, levels = c("merah", "kuning", "hijau"))
    
    
    Output <- data.frame(COVID19=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Prediksi") 
    } else {
      return("Masukkan data disamping.")
    }
    
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}
