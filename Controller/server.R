########################
#######Server###########
########################

########################
### Package and Data ###
########################

#library(maps)
#library(mapproj)
library(shiny)
library(googleVis)
source("gvis_line_chart.R")

ispdata<-"data/ispDataUsageNotShifted.csv"
billdata<-"data/billDataUsageNotShifted.csv"



#day_select(file_name=ispdata,unidate="2016-03-10",period=1)

#######################


shinyServer(
  function(input, output) {
    
    data<-reactive({
      switch(input$file_name, 
             "ISP" =ispdata,
             "Bill"=billdata)})
    
    date<-reactive({
      input$date
    })
    
    #period<-reactive({
      #input$period
    #})
    
    output$Linechart<- renderGvis({
      
      single_day<-gvisLineChart(cal_use_count_time_zone(file_name=data(),inidate=date(),period=1),
                                xvar="Time",options=list(title="For a single day",vAxes="[{viewWindowMode:'explicit',viewWindow:{min:0}}]", width=600, height=300))
      seven_day<-gvisLineChart(cal_use_count_time_zone(file_name=data(),inidate=date(),period=2),xvar="Time",options=list(title="For seven days",vAxes="[{viewWindowMode:'explicit',viewWindow:{min:0}}]", width=600, height=300))
      merged.output.chart<- gvisMerge(single_day,seven_day,horizontal=FALSE)
      for_a_month<-gvisLineChart(cal_use_count_time_zone(file_name=data(),inidate=date(),period=3),xvar="Time",options=list(title="For a month",vAxes="[{viewWindowMode:'explicit',viewWindow:{min:0}}]", width=600, height=300))
      merged.output.chart<-gvisMerge(merged.output.chart,for_a_month,horizontal=FALSE)
      return( merged.output.chart)
  
      })
    
  })  













