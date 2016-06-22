library(shiny)
library(googleVis)
source("Service/google_vis_chart.R")
source("Model/Merging_module.R")


ispdata <- "data/ispDataUsageShifted.csv"
billdata <- "data/billDataUsageShifted.csv"
mar <- "data/marUsageShifted.csv"
att <- "data/attendanceUsageShifted.csv"
ger <- "data/GerdataUsageShifted.csv"
scMail <- "data/scMailBoxUsageShifted.csv"

ispdataLocal <- "data/ispDataUsageNotShifted.csv"
billdataLocal <- "data/billDataUsageNotShifted.csv"
marLocal <- "data/marUsageNotShifted.csv"
attLocal <- "data/attendanceUsageNotShifted.csv"
gerLocal <- "data/GerdataUsageNotShifted.csv"
scMailLocal <- "data/scMailBoxUsageNotShifted.csv"


Eastern_tz <- Eastern_tz
local_tz <- local_tz




shinyServer(
  
  function(input, output) {
    
    chart_input<-reactive({
      
      if(input$Time_zone_option == "Eastern"){
        inputdat = switch(input$data,
                          "ISP" = ispdata,
                          "Bill" = billdata,
                          "Mar" = mar,
                          "Attendance" = att,
                          "GER" = ger,
                          "scMail" = scMail, 
                          "Combined" = Eastern_tz)
    
        google_vis_line_chart(inputdat = inputdat,inputdate = input$date)
         
      }
        else if (input$Time_zone_option == "Local"){
          inputdat = switch(input$data,
                          "ISP" = ispdataLocal,
                          "Bill" = billdataLocal,
                          "Mar" = marLocal,
                          "Attendance" = attLocal,
                          "GER" = gerLocal,
                          "scMail" = scMailLocal,
                          "Combined" = local_tz)
          
          google_vis_line_chart(inputdat = inputdat,inputdate = input$date)
        }
          })
   
    output$Linechart<- renderGvis({
      chart_input()
      })
    
  })  

#setwd("E:/Project-first-shiny_app")
#runApp(host="192.168.5.16",port=5050)

#Helo
