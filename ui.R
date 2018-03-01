
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Treatment Effect Exercise for Astrid"),

  # Sidebar with a slider input for number of bins
 # sidebarLayout(
#    sidebarPanel(
#      sliderInput("bins",
#                  "Number of bins:",
#                  min = 1,
#                  max = 50,
#                  value = 30)
#    ),

    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("table1"),
      tags$div(class="header", checked=NA,
               tags$p("Calculate NATE, ATT, ATC, ATE, Total Bias, Baseline Bias, and DTEB")),
      
      
      actionButton("go", "Calculate Results"),
      tableOutput("table2")
    )
  )
)
