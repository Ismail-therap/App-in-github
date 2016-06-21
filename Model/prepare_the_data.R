
###########################READ ME#################################################################################
# Subsetting the data set for a day=1/week=2/mont=3 (at first file name, selected date and for which perod we want)
###################################################################################################################

#cal_use_count_time_zone("../data/ispDataUsageShifted.csv","2016-03-03",1)


cal_use_count_time_zone<-function(file_name,inidate, period){
  
 
  
  if(period == 1){
    n_day =1
  }
  else if(period == 2){
    n_day =7
  }
  else if(period ==3){
    library(Hmisc)
    inidate<-as.Date(inidate,"%Y-%m-%d")
    n_day=monthDays(inidate)
  }
  
  ########################################################################
  

  
  days<-seq(as.Date(inidate),by = "days",length.out=n_day) #No of day selection
  dat<- read.csv(file_name)    #Getting the input file
  dat$Date<-as.Date(dat$Date,"%Y-%m-%d")
  
  ################# Subsetting and calculating the percentage ###################
  susetted_data<-subset(dat,format(dat$Date,'%Y-%m-%d')==days[1])
  
  if(period != 1){
    for (i in 2:length(days) ){
      data_dayn<-subset(dat,format(dat$Date,'%Y-%m-%d')==days[i])
      susetted_data<-rbind(susetted_data,data_dayn)
    }
  }
  
  #return(susetted_data)
  if(ncol(susetted_data)>7) {
    susetted_data<-aggregate(susetted_data[,3:7],by=list(susetted_data$Time),FUN=sum)
    
  }
  
  else{
    susetted_data<-aggregate(susetted_data[,3:6],by=list(susetted_data$Time),FUN=sum)
  }
  
  
  #return(susetted_data)
  order_the_data_set_by_minutes(susetted_data)
  
  
}



#### Order the data set by minutes #####

order_the_data_set_by_minutes<-function(inputdata){
  
  susetted_data=inputdata
  
  tm_as_char<-grep("\\-",susetted_data$Group.1, value = TRUE)
  splt_tm_intrvl<-strsplit(tm_as_char,"-") #Seperating for "-"
  splt_intrvl<-0 #Using the 2nd interval
  splt_hours_and_min<-0 #Seperating for ":"
  susetted_data$Minutes<-0 #Converting the time in minutes
  
  for (i in 1:length(splt_tm_intrvl)){
    splt_intrvl[i]<-splt_tm_intrvl[[i]][2]
    
    splt_hours_and_min[i]<-strsplit(splt_intrvl[i],":")
    susetted_data$Minutes[i]<-as.numeric(splt_hours_and_min[[i]][1])*60+as.numeric(splt_hours_and_min[[i]][2])
  }
  
  sorted_susetted_data <-susetted_data[order(susetted_data$Minutes),]
  colnames(sorted_susetted_data)[1]<-"Time"
  
  if(ncol(susetted_data)>6){
    return(sorted_susetted_data[,1:6])
  }
  
  else{
    return(sorted_susetted_data[,1:5])
    
  }
  
}

