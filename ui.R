#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pwr)

#################################################################

shinyUI(fluidPage(
    titlePanel("Sample Size Calculator"),
    sidebarLayout(
        sidebarPanel(

            selectInput("type", "type of test:",
                         choices = c("One sample, continuous outcome" = "one.sample.c",
                                "Two sample, continuous outcome" = "two.sample.c",
                                "Paired sample, continuous outcome" = "paired.c",
                                "One sample, discrete outcome (proportion)" = "one.sample.d",
                                "Two sample, discrete outcome (proportion)" = "two.sample.d")),
            conditionalPanel(
                condition = "input.type == 'one.sample.c'",
                numericInput("delta1", "raw change in mean to detect", value = .1,step=.1),
                numericInput("sigma1", "standard deviation of control", value = 1,step=1),
                numericInput("power1", "power", value = .9,step=.1),
                numericInput("alpha1", "confidence level", value = .95,step=.01)),
            
            conditionalPanel(
                condition = "input.type == 'two.sample.c'",
                numericInput("delta2", "raw change in mean to detect", value = .1,step=.1),
                numericInput("sigma2", "standard deviation of control", value = 1,step=1),
                numericInput("power2", "power", value = .9,step=.1),
                numericInput("alpha2", "confidence level", value = .95,step=.01)),
            
            
            conditionalPanel(
                condition = "input.type == 'paired.c'",
                numericInput("delta3", "raw change in mean to detect", value = .1,step=.1),
                numericInput("sigma3", "standard deviation of control", value = 1,step=1),
                numericInput("power3", "power", value = .9,step=.1),
                numericInput("alpha3", "confidence level", value = .95,step=.01)),


            conditionalPanel(
                condition = "input.type == 'one.sample.d'",
                numericInput("e4", "effect size", value = .05,step=.1),
                numericInput("power4", "power", value = .9,step=.1),
                numericInput("alpha4", "confidence level", value = .95,step=.01)),
                
            conditionalPanel(
                condition = "input.type == 'two.sample.d'",
                numericInput("e5", "difference in proportions", value = .05,step=.1),
                numericInput("power5", "power", value = .9,step=.1),
                numericInput("alpha5", "confidence level", value = .95,step=.01))


            

        ),
        mainPanel(p("This is a sample size calculator to be used when planning an experiment. 
                    Before the test starts, use this tool to calculate the sample size you
                    will need to attain the desired power and confidence level. Remember, low 
                    power will mean your test has more false negatives and low confidence 
                    means your test has more false positives. Use the panel to the left to select
                    the test scenario you are working with. From there, the other input fields in 
                    the panel will adjust to take the needed parameters for the sample size
                    calculation."),
            plotOutput("ssplot"),
            htmlOutput("ss")
        )
    )
)
)
