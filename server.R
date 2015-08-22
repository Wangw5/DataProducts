# load libraries
library(shiny)

# begin shiny server
shinyServer(function(input, output) {
  # Return the selected distribution
  data <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   exp = rexp,
                   rnorm)
    all <- c()
    for (i in 1:input$num_sim){
      s <- dist(input$sam_size)
      all <- c(all, mean(s))
    }
    all
  })
  
  pop_mean <- reactive({
    pm <- ifelse(input$dist == "norm", 0, ifelse(input$dist == "unif", 0.5, 1))
    pm
  })
  
  pop_sd <- reactive({
    psd <- ifelse(input$dist == "norm", 1, ifelse(input$dist == "unif", 1/sqrt(12), 1))
    psd/sqrt(as.numeric(input$sam_size))
  }) 
 
  
  # Generate summary and plot of the simulated dataset
  output$summary <- renderPrint({
      cat("Mean of the sample means: ")
      cat(mean(data()))
      cat("\n")
      cat("Standard deviation of the sample means: ")
      cat(sd(data()))
      cat("\n")
      cat("Approximation to Normal with mean: ")
      cat(pop_mean())
      cat("\n")
      cat("and standard deviation: ")
      cat(pop_sd())
      cat("\n")
  })
  
  output$test <- renderPrint({
    shapiro.test(data())
  })
  
  output$plot <- renderPlot({
    hist(data(),main = "Distribution of the sample mean", col = "blue",prob=T)
    lines(density(data()),col="red",lwd=2)
  })
})