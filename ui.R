library(shiny)
# begin shiny UI
shinyUI(navbarPage("A litte Shiny project",
                   # create first tab for documentation
                   tabPanel("Documentation",
                            # load MathJax library so LaTeX can be used for math equations
                            withMathJax(), h2("What is Central Limit Theorem?"),
                            # paragraph and bold text
                            p("Let ", "\\(\\bar X\\)", "be the mean of a simple random sample,",
                              "\\(X_1, X_2, ..., X_n\\)", "of size ","\\(n\\)"," from a population with mean",
                              "\\(\\mu\\)"," and standard deviation","\\(\\sigma .\\)",
                              "The Central limit theorem says that the sampling distribution of the sample mean",
                              "\\(\\bar X\\)"," is approximately",strong("Normal"), "with mean \\(\\mu\\)", 
                              " and standard deviation \\(\\frac{\\sigma}{\\sqrt{n}} \\) for large enough sample size \\(n\\)."
                              ),
                            p(strong("Moreover, this theorem holds for any random samples regardless which distribution they are drawn from!")),
                            # break used to space sections
                            br(), p("To show this numerically, we simulated the following in the ",
                                    strong("Simulation Experiments"), " tab: "), br(),
                            # ordered list
                            tags$ol(
                              tags$li("Choose a distribution where the samples are from."),
                              tags$li("Draw a specified number of samples of specified size from the distribution."),
                              tags$li("Plot histogram of the sample means and run normality test on sample means."),
                              tags$li("Fit a kernal density to the sample means.")
                            )),
                   # second tab
                   tabPanel("Simulation Experiment",
                            fluidPage(
                              sidebarLayout(
                                sidebarPanel(
                                  radioButtons("dist", "Distribution type:",
                                               c("Standard Normal" = "norm",
                                                 "Uniform between 0 and 1" = "unif",
                                                 "Exponential (lambda = 1)" = "exp")),
                                  
                                  numericInput("num_sim", "Number of simulations to run:", 1000),
                                  
                                  selectInput("sam_size","Sample size:",
                                              choices = c(1,30,100)),
                                  
                                  hr(),
                                  helpText("Note: please make sure the number of simulations is an integer between 1 and 1000",
                                           ", otherwise the code will take too long to run."),
                                  
                                  submitButton("Let's look at the results!")
                                ),
                                
                                # Show a summary of the simulated data and histogram
                                mainPanel(
                                  h4("Comparison of mean and standard deviation of sample and population"),
                                  verbatimTextOutput("summary"),
                                  
                                  h4("Normality test on sample means"),
                                  verbatimTextOutput("test"),
                                  
                                  h4("Distribution of the sample mean"),
                                  plotOutput("plot")
                                )
                              )
                            )                          
                   )
))