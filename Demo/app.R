# Here the code is run once at the launch of the app, so put HERE all 
# the instruction to import libries, datas, whatever must be run 
# once in order to not affect performances
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("..")
print(getwd())
library(shiny)
library(bnlearn)

paper_model = model2network("[BirthAsphyxia][Disease|BirthAsphyxia][LVHreport|LVH][LVH|Disease][LowerBodyO2|HypDistrib:HypoxiaInO2][HypDistrib|DuctFlow:CardiacMixing][DuctFlow|Disease][RUQO2|HypoxiaInO2][HypoxiaInO2|CardiacMixing:LungParench][CardiacMixing|Disease][CO2Report|CO2][CO2|LungParench][LungParench|Disease][XrayReport|ChestXray][ChestXray|LungFlow:LungParench][LungFlow|Disease][GruntingReport|Grunting][Grunting|Sick:LungParench][Sick|Disease][Age|Sick:Disease]")
MyData <- read.csv(file="BlueBaby.csv", header=TRUE, sep=",")
dataset <- MyData[sample(nrow(MyData)), ]
paper_full_trained = bn.fit(paper_model, dataset, method = "mle")

# Define UI for app
ui <- fluidPage(
  titlePanel(h1("This is a title")),
  
  sidebarLayout( # layout with a sidebar
    # position = right to put the sidebar on the right
    
    sidebarPanel( # side bar content
      h2("Select the evidences you have:"),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("BirthAsphyxia-value", h4("Birth asphyxia"), 
                      choices = list("No" = "no", "Yes" = "yes", 
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("HypDistrib-value", h4("Hypoxia distribution"), 
                      choices = list("Equal" = "Equal", "Unequal" = "Unequal", 
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("HypoxiaInO2-value", h4("Hypoxia in O2"), 
                      choices = list("Mild" = "Mild", "Moderate" = "Moderate",
                                     "Severe" = "Severe", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("CO2-value", h4("CO2"), 
                      choices = list("High" = "High", "Low" = "Low",
                                     "Normal" = "Normal", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("ChestXray-value", h4("Chest X-ray"), 
                      choices = list("Asy/Patch" = "Asy/Patch", "Grd Glass" = "Grd_Glass",
                                     "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                     "Plethoric" = "Plethoric", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("Grunting-value", h4("Grunting"), 
                      choices = list("No" = "no", "Yes" = "yes",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("LVHreport-value", h4("LVH report"), 
                      choices = list("No" = "no", "Yes" = "yes",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("LowerBodyO2-value", h4("Lower body O2"), 
                      choices = list("<5" = "<5", "12+" = "12+", 
                                     "5-12" = "5-12", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("RUQO2-value", h4("Right up quad O2"), 
                      choices = list("<5" = "<5", "12+" = "12+", 
                                     "5-12" = "5-12", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("CO2Report-value", h4("CO2 report"), 
                      choices = list("<7.5" = "<7.5", ">=7.5" = ">=7.5",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("XrayReport-value", h4("X-ray report"), 
                      choices = list("Asy/Patch" = "Asy/Patch", "Grd Glass" = "Grd_Glass",
                                     "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                     "Plethoric" = "Plethoric", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("GruntingReport-value", h4("Grunting report"), 
                      choices = list("No" = "no", "Yes" = "yes",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
     
       div(style="display: inline-block;vertical-align:top; width: 150px;", 
           selectInput("Age-value", h4("Age at presentation"), 
                       choices = list("0-3 days" = "0-3_days", "11-30 days" = "11-30_days",
                                       "4-10 days" = "4-10_daysl", "No evidence" = "no_evidence"), 
                       selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("LVH-value", h4("LVH"), 
                      choices = list("No" = "no", "Yes" = "yes",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("DuctFlow-value", h4("Duct flow"), 
                      choices = list("Left to right" = "Lt_to_Rt", "None" = "None",
                                     "Right to Left" = "Rt_to_Lt", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("CardiacMixing-value", h4("Cardiac mixing"), 
                      choices = list("Complete" = "Complete", "Mild" = "Mild",
                                     "None" = "None", "Transp." = "Transp.",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("LungParench-value", h4("Lung parenchema"), 
                      choices = list("Abnormal" = "Abnormal", "Congested" = "Congested",
                                     "Normal" = "Normal", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 50px;",HTML("<br>")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;", 
          selectInput("LungFlow-value", h4("Lung flow"), 
                      choices = list("High" = "High", "Low" = "Low",
                                     "Normal" = "Normal", "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      
      div(style="display: inline-block;vertical-align:top; width: 150px;",
          selectInput("Sick-value", h4("Sick"), 
                      choices = list("No" = "no", "Yes" = "yes",
                                     "No evidence" = "no_evidence"), 
                      selected = "no_evidence")),
      div(style="display: inline-block;vertical-align:top; width: 275px;",HTML("<br>")),
            
      div(style="display: inline-block;vertical-align:bottom; width: 100px;", submitButton("Hello there", icon("refresh")))
    ),
      
    mainPanel(  # main panel content
      img(src = "paper_structure.png", height = 830, width = 800),
      textOutput("probabilities")
            
      # look lesson 2 for formatted text and how insert images

          
      
    )
  )
)

# Define server logic
server <- function(input, output) {
  # output$<id_widget_name> <- <render_funciont>({<a complicated function>})
  # input$<id_widget_name> to access the value of the widget
  
  output$probabilities <- renderText({ 
    # creating structure node=evidence
    ev = list(LVHreport = "yes")
    # variable to store the most likelly disease
    new_cpt = list()
    #for (i in levels(dataset$Disease)){
    #  res = cpquery(paper_full_trained, event=Disease==i, method="lw", evidence = ev)
    #  new_cpt[[pos]] = paste0(i, ": ", res)
    #  pos <- pos + 1
    #}
    
    s <- 0
    res = cpquery(paper_full_trained, event=Disease=="Fallot", method="lw", evidence = ev)
    new_cpt[[1]] = paste0("Fallot", ": ", res)
    s <- s + res
    res = cpquery(paper_full_trained, event=Disease=="Lung", method="lw", evidence = ev)
    new_cpt[[2]] = paste0("Lung", ": ", res)
    s <- s + res
    res = cpquery(paper_full_trained, event=Disease=="PAIVS", method="lw", evidence = ev)
    new_cpt[[3]] = paste0("PAIVS", ": ", res)
    s <- s + res
    res = cpquery(paper_full_trained, event=Disease=="PFC", method="lw", evidence = ev)
    new_cpt[[4]] = paste0("PFC", ": ", res)
    s <- s + res
    res = cpquery(paper_full_trained, event=Disease=="TAPVD", method="lw", evidence = ev)
    new_cpt[[5]] = paste0("TAPVD", ": ", res)
    s <- s + res
    res = cpquery(paper_full_trained, event=Disease=="TGA", method="lw", evidence = ev)
    new_cpt[[6]] = paste0("TGA", ": ", res)
    s <- s + res
    
    #for (i in 1 : 6){
    #  new_cpt[i] = new_cpt[i] / s
    #}
    
    print(new_cpt)
    sprintf("%s, %s, %s, %s, %s, %s", new_cpt[1], new_cpt[2], new_cpt[3], new_cpt[4], new_cpt[5], new_cpt[6])
  })
}

# Run the app
shinyApp(ui = ui, server = server)