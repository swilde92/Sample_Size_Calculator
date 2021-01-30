
presentation for sample size calculator app
========================================================
author: SarahLynn
date: 1/29/2021
autosize: true
font-family: 'Helvetica'

Motivation
========================================================

why use a sample size calculator?

- When you are designing an experiment, you need to know ahead of time
how many observations to collect
  - If not planned correctly, when you try to analyze your test results you may find you dont have enough data to detect a difference that is truely there. On the flip side, you do not want to collect more data than you have to.
- The calculator presented here allows for selection of your specific experiment type (ie one sample continuous outcome like if you are looking to see if mean height for a population is greater than X, or a two sample discrete outcome like if you are looking to compare conversion rates between a test and control group.)

Underlying code for sample size calculator app
========================================================

The sample size calculator app presented here uses the following formulas to calculate sample size for the various scenarios. Here we are using defualt parameters, but note that the app will allow you to change them.



```r
#for one sample continuous outcome
one.sample.c <-  power.t.test(delta=.1,sd=1,power=.9,type=c("one.sample"),
                              alternative=c("two.sided"))$n

#for two sample continuous outcome
two.sample.c <-  power.t.test(delta=.1,sd=1,power=.9,type=c("two.sample"),
                              alternative=c("two.sided"))$n

#for paired continuous outcome
paired.c <- power.t.test(delta=.1,sd=1,power=.9,type=c("paired"),
                         alternative=c("two.sided"))$n

#for one sample discrete outcome
one.sample.d <-pwr.p.test(h=.05,sig.level=.05,power=.9,alternative=c("two.sided"))$n

#for two sample discrete outcome
two.sample.d <- pwr.2p.test(h=.05,sig.level=.05,power=.9,alternative=c("two.sided"))$n
```

Visuals in sample size calculator app
========================================================

The app will not only calculate the sample size needed, but it will display a graph that demonstrates how the sample size needed will change as you adjust the difference to detect or other input parameters. See an example of this visual below, using the defualt values in the app. 

<img src="presentation for sample size calculator app-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

Conclusion
========================================================

A well conducted experiment requires a pre-thought out sample size calculation and plan for collecting the appropriate data. A calculator like the one in this app will reduce the friction in gathering this information and hopefully make this step easier.

The sample size calculator app can be found here: 
https://swilde92.shinyapps.io/sample_size_calculator_r/ 
