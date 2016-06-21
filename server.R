library(shiny)
library(googleVis)


## Hello Ismail

source("Service/google_vis_chart.R")


ispdata<-"data/ispDataUsageShifted.csv"
billdata<-"data/billDataUsageShifted.csv"
mar<-"data/marUsageShifted.csv"
att<-"data/attendanceUsageShifted.csv"
ger<-"data/GerdataUsageShifted.csv"
scMail<-"data/scMailBoxUsageShifted.csv"

ispdataLocal<-"data/ispDataUsageNotShifted.csv"
billdataLocal<-"data/billDataUsageNotShifted.csv"
marLocal<-"data/marUsageNotShifted.csv"
attLocal<-"data/attendanceUsageNotShifted.csv"
gerLocal<-"data/GerdataUsageNotShifted.csv"
scMailLocal<-"data/scMailBoxUsageNotShifted.csv"


Eastern_tz<-"data/combined_tz_all_moudule_shifted.csv"
local_tz<-"data/combined_tz_all_moudule_notshifted.csv"




shinyServer(
  
  
  function(input, output) {
    
    
    chart_input<-reactive({
      
      if(input$Time_zone_option=="Eastern"){
        
        google_vis_line_chart(inputdat=switch(input$data,"ISP"=ispdata,"Bill"=billdata,"Mar"=mar,"Attendance"=att,
                                              "GER"=ger,"scMail"=scMail,"Combined"=Eastern_tz),inputdate=input$date)
         
      }
        else if (input$Time_zone_option=="Local"){
          google_vis_line_chart(inputdat=switch(input$data,"ISP"=ispdataLocal,"Bill"=billdataLocal,"Mar"=marLocal,"Attendance"=attLocal,
                                                "GER"=gerLocal,"scMail"=scMailLocal,"Combined"=local_tz),inputdate=input$date)
        }
          })
   
    
    output$Linechart<- renderGvis({
      
      chart_input()
      
      })
    
  })  

#setwd("E:/Project-first-shiny_app")
#runApp(host="192.168.5.16",port=5050)
