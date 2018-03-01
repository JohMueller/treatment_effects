
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyServer(function(input, output) {

  rand_prop<- sample(c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9),1)
  
  data <- as.data.frame(cbind(treatment = c("1","0"),
                              proportion = as.numeric(c(rand_prop,1-rand_prop)),
                              y1 = c(sample(c(5:10),1), sample(c(1:7),1)),
                              y0 = c(sample(c(2:7),1), sample(c(1:4),1))))
  
  
  
  data$proportion <- as.numeric(as.character(data$proportion))
  data$y1 <- as.numeric(as.character(data$y1))
  data$y0 <- as.numeric(as.character(data$y0))
  
  ## Calculate effects
  calculations <- as.data.frame(cbind(
    nate = data$y1[1] - data$y0[2],
    att = data$y1[1] - data$y0[1],
    atc = data$y1[2] - data$y0[2],
    ate = data$proportion[1]*(data$y1[1] - data$y0[1]) + data$proportion[2]*(data$y1[2] - data$y0[2]),
    #ate_alt  = (data$proportion[1]*data$y1[1] + data$proportion[2]*(data$y1[2])-(data$proportion[1]*data$y0[1] + data$proportion[2]*(data$y0[2]))),
    bias = (data$y1[1] - data$y0[2])-(data$proportion[1]*(data$y1[1] - data$y0[1]) + data$proportion[2]*(data$y1[2] - data$y0[2])),
    bb = data$y0[1] - data$y0[2],
    dteb = data$proportion[2] * ((data$y1[1] - data$y0[1])-(data$y1[2] - data$y0[2]))
  ))
  
  names(calculations) <- c("NATE", "ATT", "ATC","ATE", "Total Bias", "Baseline Bias", "DTEB")
  names(data) <- c("Treatment Status", "Proportion", "E(Y_1)", "E(Y_0)")
  

  output$table1 <- renderTable({
   data
  }, bordered = TRUE, align = 'c')
  

  observeEvent(input$go, {
   output$table2 <- renderTable({
     calculations
   }, align = 'c')})   

})
