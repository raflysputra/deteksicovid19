library(shiny)
library(shinythemes)
ui <- fluidPage(theme = shinytheme("slate"),
                
                
                headerPanel('Peluang Covid & Rekomendasi Swab Test'),
                
                
                sidebarPanel(
                  HTML("<h3>Masukkan Data Anda</h3>"),
                  
                  selectInput("ï..zonakota", label = "Zona Kota:", 
                              choices = list("Merah" = "merah", "Kuning" = "kuning", "Hijau" = "hijau"), 
                              selected = "hijau"),
                  sliderInput("suhubadan", "Suhu Badan Saat ini:",
                              min = 28, max = 45,
                              value = 35),
                  sliderInput("tensi", "Tekanan Darah:",
                              min = 90, max = 161,
                              value = 119),
                  selectInput("keluarkota", label = "Keluar Kota Dua Minggu Terakhir:", 
                              choices = list("Ya" = "TRUE", "Tidak" = "FALSE"), 
                              selected = "Tidak"),
                  
                  actionButton("submitbutton", "Submit", class = "btn btn-primary")
                ),
                
                mainPanel(
                  tags$label(h3('Peluang Covid')), # Status/Output Text Box
                  verbatimTextOutput('contents'),
                  tableOutput('tabledata'), # Prediction results table
                  tags$label(h3('Panduan')),
                  tags$label(h4('Apabila hasil peluang positif covid19 lebih dari 50% maka disarankan untuk swab test '))
                )
)
