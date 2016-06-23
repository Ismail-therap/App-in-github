

shinyUI(fluidPage(
  #titlePanel("Selecting the data"),
  
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("file_name", label = h3("Choose the data"),
                   choices = list("ISP","Bill"),selected ="ISP"),
      
      #checkboxGroupInput("file_name", label = h3("Choose the data"),
                         #choices = list("ISP","Bill"),selected ="ISP"),
      
      dateInput("date", label = h3("Select Date"),value = "2016-03-10")
      
     
      
      
      
      ),
    
    mainPanel(htmlOutput("Linechart"))
  )
)
)

#?radioButtons
#?checkboxGroupInput
