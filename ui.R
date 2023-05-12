shinyUI(
  pageWithSidebar(
    headerPanel("Monte Carlo Simulation"),
    sidebarPanel(
      sliderInput ("Simulation", "Please select the number of simulation to be performed",
                    min = 1000, max = 10000,value = 1000, step = 1000)
    ),
    mainPanel(
      plotOutput("myplot"),
      tableOutput("Sim_data")
    )
  )
)
