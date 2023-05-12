library(shiny)
library(shinydashboard)
library(ggplot2)

setwd("D:/Sandeep/Personal/Tilburg/RShiny")

set.seed(02112022)

shinyServer(function(input,output,session) {
  
  tea_drinking_sim <- function(nr_cups=8,S=input$Simulation) { 
    ls <- list() ; df <- data.frame()  
    pos_out <- sample(rep(c('Milk','Tea'),each = nr_cups/2)) # 
    for (s in 1:S) {  
      guess <- sample(x=pos_out, size=nr_cups)     
      correct <- sum(guess==pos_out)
      ls[[s]] <- correct
    }
    df <- transform(table(as.data.frame(unlist(transform(t(rbind(df,t(unlist(ls)))))))))
    names(df)[1] <- 'correct_guess' 
    df$freq_dist <- df$Freq/sum(df$Freq)
    return(df)
  }
  
  
  output$myplot <- renderPlot({
    size <- input$Simulation
    hist_sim <- tea_drinking_sim(8,input$Simulation)
    output$Sim_data <- renderTable({
      hist_sim <- tea_drinking_sim(8,input$Simulation)
    })
  ggplot(hist_sim,aes(x= hist_sim$correct_guess, y = hist_sim$Freq,fill = Freq))+
    geom_bar(stat = "identity",position = "dodge")
}
  )
}
)