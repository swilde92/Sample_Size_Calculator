#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pwr)

############################################################

shinyServer(function(input, output, session) {
    observeEvent(input$dist, {
        updateTabsetPanel(session, "params", selected = input$type)
    }) 
    
    sample_size <- reactive({
        switch(input$type,
               one.sample.c = power.t.test(delta=input$delta1,sig.level=(1-input$alpha1),sd=input$sigma1,power=input$power1,type=c("one.sample"),alternative=c("two.sided"))$n,
               two.sample.c = power.t.test(delta=input$delta2,sig.level=(1-input$alpha2),sd=input$sigma2,power=input$power2,type=c("two.sample"),alternative=c("two.sided"))$n,
               paired.c = power.t.test(delta=input$delta3,sig.level=(1-input$alpha3),sd=input$sigma3,power=input$power3,type=c("paired"),alternative=c("two.sided"))$n,
               one.sample.d = pwr.p.test(h=input$e4,sig.level=(1-input$alpha4),power=input$power4,alternative=c("two.sided"))$n,
               two.sample.d = pwr.2p.test(h=input$e5,sig.level=(1-input$alpha5),power=input$power5,alternative=c("two.sided"))$n
               
        )
    })
    

    
    sample_sizes <- reactive({
        deltas1 <- input$delta1/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
        deltas2 <- input$delta2/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
        deltas3 <- input$delta3/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
        e_prop <- 1:100/100
        sss1 <- deltas1
        sss2 <- deltas2
        sss3 <- deltas3
        sss4 <- e_prop
        sss5 <- e_prop
        for (i in 1:length(deltas1)) {
            sss1[i] <- power.t.test(delta=deltas1[i],sig.level=(1-input$alpha1),sd=input$sigma1,power=input$power1,type=c("one.sample"),alternative=c("two.sided"))$n
            sss2[i] <- power.t.test(delta=deltas2[i],sig.level=(1-input$alpha2),sd=input$sigma2,power=input$power2,type=c("two.sample"),alternative=c("two.sided"))$n
            sss3[i] <- power.t.test(delta=deltas3[i],sig.level=(1-input$alpha3),sd=input$sigma3,power=input$power3,type=c("paired"),alternative=c("two.sided"))$n
        }
        for (i in 1:length(e_prop)) {
            sss4[i] <- pwr.p.test(h=e_prop[i],sig.level=(1-input$alpha4),power=input$power4,alternative=c("two.sided"))$n
            sss5[i] <- pwr.2p.test(h=e_prop[i],sig.level=(1-input$alpha5),power=input$power5,alternative=c("two.sided"))$n
            
        }
        
        
        switch(input$type,

               one.sample.c = sss1,
               two.sample.c = sss2,
               paired.c = sss3,
               one.sample.d = sss4,
               two.sample.d = sss5
        )
    })
    
    
    
    # output$ss <- renderPlot(plot(input$delta,sample_sizes(),xlab="difference to detect",ylab="sample size needed"))

    output$ssplot <- renderPlot({
        if (input$type == c("one.sample.c")) {
          
          plot(input$delta1/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
               ,sample_sizes(),type="l",
               xlab="difference to detect",ylab="sample size needed"
               ,xlim=c(0, 3), ylim=c(0, input$sigma1*6000)
               )
          points(input$delta1,sample_size(),col="red",pch=2)
          abline(v=input$delta1,col="blue")
          
        } else 
            
            
            
        if (input$type == c("two.sample.c")) {
                
                plot(input$delta2/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
                     ,sample_sizes(),type="l",
                     xlab="difference to detect",ylab="sample size needed"
                     ,xlim=c(0, 3), ylim=c(0, input$sigma2*6000)
                )
                points(input$delta2,sample_size(),col="red",pch=2)
                abline(v=input$delta2,col="blue")
                
            } else      
        if (input$type == c("paired.c")) {
                    
                    plot(input$delta3/c(30,25,20,18,16,14,12,10,8,6,4,3,2,1,.75,.5,.375,.25,.1875,.125,.0625,.03)
                         ,sample_sizes(),type="l",
                         xlab="difference to detect",ylab="sample size needed"
                         ,xlim=c(0, 3), ylim=c(0, input$sigma3*6000)
                    )
                    points(input$delta3,sample_size(),col="red",pch=2)
                    abline(v=input$delta3,col="blue")
                    
                } else      
                    
        
        
        
        if (input$type == c("one.sample.d"))  { 
            plot(1:100/100
                 ,sample_sizes(),type="l",
                 xlab="difference to detect",ylab="sample size needed"
                 ,xlim=c(0, 1), ylim=c(0,1200/input$e4)
            )
            points(input$e4,sample_size(),col="red",pch=2)
            abline(v=input$e4,col="blue")
            
            
            } else  { 
                plot(1:100/100
                     ,sample_sizes(),type="l",
                     xlab="difference to detect",ylab="sample size needed"
                     ,xlim=c(0, 1), ylim=c(0,1200/input$e5)
                )
                points(input$e5,sample_size(),col="red",pch=2)
                abline(v=input$e5,col="blue")
                
                
            } 
          
        
          })

          
    #output$ss <- renderText("sample size needed:" sample_size()) 
    output$ss <- renderText({
         paste("<span style='font-weight:bold;color:green'>sample size needed:",round(sample_size()),"</span>")  })
    
       
    })
        
         
     
        
        
         
       # plot(input$delta,sample_size(),xlab="difference to detect",ylab="sample size needed")
    #    abline(h=sample_size())
       # points(rv$m$x[-1],rv$m$y[-1])

    
