
#source("Model/prepare_the_data.R")
source("Model/data_preperation_new.R")

google_vis_line_chart<-function(inputdat,inputdate){
  
  ####### Loading data from Model #############################################
  
  single_day_data<-reactive({
    dat <- get_data_frame(inputdat)
    cal_use_count_time_zone(dat,inidate=inputdate,period=1)
  })
  seven_day_data<-reactive({
    
    dat <- get_data_frame(inputdat)
    cal_use_count_time_zone(dat,inidate=inputdate,period=2)
  })   
  a_month_data<-reactive({
    dat <- get_data_frame(inputdat)
    cal_use_count_time_zone(dat,inidate=inputdate,period=3)
  }) 
  
 
  
  ######## Chart options #####################################################
  
  vertical_axis="[{viewWindowMode:'explicit',viewWindow:{min:0}}]"
  width=600
  hgt=300
  
  options_single_day=list(title="For a single day",vAxes=vertical_axis, width=width,height=hgt)
  options_seven_day=list(title="For seven days",vAxes=vertical_axis, width=width, height=hgt)
  options_month=list(title="For a month",vAxes=vertical_axis, width=width, height=hgt)
  
  ###### Creating gvis objects ################################################
  single_day<-gvisLineChart(single_day_data(),xvar="Time",option=options_single_day)
  seven_day<-gvisLineChart(seven_day_data(),xvar="Time",option=options_seven_day)
  for_a_month<-gvisLineChart(a_month_data(),xvar="Time",option=options_month)
  
  ##### Merging the charts ###################################################
  merged.output.chart<- gvisMerge(single_day,seven_day,horizontal=FALSE)
  merged.output.chart<-gvisMerge(merged.output.chart,for_a_month,horizontal=FALSE)
  
  return(merged.output.chart)
 
}




