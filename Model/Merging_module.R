#Merging the 6 module
multmerge = function(mypath){
  using <- c("Time","Date")
  filenames = list.files(path=mypath, full.names=TRUE)
  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
  Reduce(function(x,y) {merge(x,y,by.x=using,by.y=using)}, datalist)
}


#Combining the 4 time zone count

combining_tz <- function(shifted_merged="folder"){
  shifted_merged <- shifted_merged[,-c(3,8,13,18,23,28)] #Exclude the unnecessary column 
  attach(shifted_merged)
  shifted_merged$Central <- Central.x+Central.y+Central.x.1+Central.y.1+Central.x.2+Central.y.2
  shifted_merged$Eastern <- Eastern.x+Eastern.y+Eastern.x.1+Eastern.y.1+Eastern.x.2+Eastern.y.2
  shifted_merged$Pacific <- Pacific.x+Pacific.y+Pacific.x.1+Pacific.y.1+Pacific.x.2+Pacific.y.2
  shifted_merged$Mountain <- Mountain.x+Mountain.y+Mountain.x.1+Mountain.y.1+Mountain.x.2+Mountain.y.2
  shifted_merged <- shifted_merged[,c(1,27:30,2)]
  shifted_merged$Combined_all_tz <- shifted_merged$Central+shifted_merged$Eastern+shifted_merged$Pacific+shifted_merged$ Mountain
  shifted_merged <- shifted_merged[,c(1:5,7,6)]
  return(shifted_merged)
}


#Combining the shifted and non shifted data sets and creating R data frame object for both
Eastern_tz <- combining_tz((multmerge("data/shifted")))
local_tz <- combining_tz((multmerge("data/not shifted")))


#done