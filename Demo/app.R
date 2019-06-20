# Here the code is run once at the launch of the app, so put HERE all 
# the instruction to import libries, datas, whatever must be run 
# once in order to not affect performances
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("..")
library(shiny)
library(bnlearn)

paper_model = model2network("[BirthAsphyxia][Disease|BirthAsphyxia][LVHreport|LVH][LVH|Disease][LowerBodyO2|HypDistrib:HypoxiaInO2][HypDistrib|DuctFlow:CardiacMixing][DuctFlow|Disease][RUQO2|HypoxiaInO2][HypoxiaInO2|CardiacMixing:LungParench][CardiacMixing|Disease][CO2Report|CO2][CO2|LungParench][LungParench|Disease][XrayReport|ChestXray][ChestXray|LungFlow:LungParench][LungFlow|Disease][GruntingReport|Grunting][Grunting|Sick:LungParench][Sick|Disease][Age|Sick:Disease]")
MyData <- read.csv(file="BlueBaby.csv", header=TRUE, sep=",")
dataset <- MyData[sample(nrow(MyData)), ]
paper_full_trained = bn.fit(paper_model, dataset, method = "mle")

# Define UI for app
ui <- shinyUI(
  navbarPage("Blue Baby Disease Prediction",
    tabPanel(
      "Probabilities of disease given some evidences",
      sidebarLayout( # layout with a sidebar
        # position = right to put the sidebar on the right
        
        sidebarPanel( # side bar content
          h2("Select the evidences you have:"),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("Age", h4("Age at presentation"), 
                          choices = list("0-3 days" = "0-3_days", "11-30 days" = "11-30_days",
                                         "4-10 days" = "4-10_days", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("BirthAsphyxia", h4("Birth asphyxia"), 
                          choices = list("No" = "no", "Yes" = "yes", 
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("CO2", h4("CO2"), 
                          choices = list("High" = "High", "Low" = "Low",
                                         "Normal" = "Normal", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("CO2Report", h4("CO2 report"), 
                          choices = list("<7.5" = "<7.5", ">=7.5" = ">=7.5",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("CardiacMixing", h4("Cardiac mixing"), 
                          choices = list("Complete" = "Complete", "Mild" = "Mild",
                                         "None" = "None", "Transp." = "Transp.",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("ChestXray", h4("Chest X-ray"), 
                          choices = list("Asy/Patch" = "Asy/Patch", "Grd Glass" = "Grd_Glass",
                                         "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                         "Plethoric" = "Plethoric", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("DuctFlow", h4("Duct flow"), 
                          choices = list("Left to right" = "Lt_to_Rt", "None" = "None",
                                         "Right to Left" = "Rt_to_Lt", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("Grunting", h4("Grunting"), 
                          choices = list("No" = "no", "Yes" = "yes",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("GruntingReport", h4("Grunting report"), 
                          choices = list("No" = "no", "Yes" = "yes",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("HypDistrib", h4("Hypoxia distribution"), 
                          choices = list("Equal" = "Equal", "Unequal" = "Unequal", 
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("HypoxiaInO2", h4("Hypoxia in O2"), 
                          choices = list("Mild" = "Mild", "Moderate" = "Moderate",
                                         "Severe" = "Severe", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("LVH", h4("LVH"), 
                          choices = list("No" = "no", "Yes" = "yes",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("LVHreport", h4("LVH report"), 
                          choices = list("No" = "no", "Yes" = "yes",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("LowerBodyO2", h4("Lower body O2"), 
                          choices = list("<5" = "<5", "12+" = "12+", 
                                         "5-12" = "5-12", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("LungFlow", h4("Lung flow"), 
                          choices = list("High" = "High", "Low" = "Low",
                                         "Normal" = "Normal", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("LungParench", h4("Lung parenchema"), 
                          choices = list("Abnormal" = "Abnormal", "Congested" = "Congested",
                                         "Normal" = "Normal", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("RUQO2", h4("Right up quad O2"), 
                          choices = list("<5" = "<5", "12+" = "12+", 
                                         "5-12" = "5-12", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          div(style="display: inline-block;vertical-align:top; width: 5%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;",
              selectInput("Sick", h4("Sick"), 
                          choices = list("No" = "no", "Yes" = "yes",
                                         "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 28%;", 
              selectInput("XrayReport", h4("X-ray report"), 
                          choices = list("Asy/Patchy" = "Asy/Patchy", "Grd Glass" = "Grd_Glass",
                                         "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                         "Plethoric" = "Plethoric", "No evidence" = "no_evidence"), 
                          selected = "no_evidence")),
          
          div(style="display: inline-block;vertical-align:top; width: 45%;",HTML("<br>")),
                
          div(style="display: inline-block;vertical-align:bottom; width: 20%;", submitButton("Update", icon("refresh")))
        ),
          
        mainPanel(  # main panel content
          img(src = "paper_structure.png", height = 601, width = 833),
          br(),
          br(),
          span(textOutput("probabilities"), style = "font-size:30px")
        )
      )
    ),
    
    tabPanel(
      "Establish if two variables are dependent or independet given some other evidences",
      sidebarLayout(
        sidebarPanel(
          h2("Select the queries nodes and the known variables:"),
          
          div(style="display: inline-block;vertical-align:top; width: 40%;", 
              selectInput("source", h4("First node:"), 
                          choices = list("Age at presentation" = "Age", "Birth asphyxia" = "BirthAsphyxia", 
                                         "CO2" = "CO2", "CO2 report" = "CO2Report", 
                                         "Cardiac mixing" = "CardiacMixing", "Chest X-ray" = "ChestXray", 
                                         "Disease" = "Disease", "Duct flow" = "DuctFlow", 
                                         "Grunting" = "Grunting", "Grunting report" = "GruntingReport", 
                                         "Hypoxia distribution" = "HypDistrib", "Hypoxia in O2" = "HypoxiaInO2", 
                                         "LVH" = "LVH", "LVH report" = "LVHreport", "Lower body O2" = "LowerBodyO2",
                                         "Lung flow" = "LungFlow", "Lung parenchema" = "LungParench", 
                                         "Right up quad O2" = "RUQO2", "Sick" = "Sick", "X-ray report" = "XrayReport"), 
                          selected = "Age")),
          
          div(style="display: inline-block;vertical-align:top; width: 15%;",HTML("<br>")),
          
          div(style="display: inline-block;vertical-align:top; width: 40%;", 
              selectInput("destination", h4("Second node:"), 
                          choices = list("Age at presentation" = "Age", "Birth asphyxia" = "BirthAsphyxia", 
                                         "CO2" = "CO2", "CO2 report" = "CO2Report", 
                                         "Cardiac mixing" = "CardiacMixing", "Chest X-ray" = "ChestXray", 
                                         "Disease" = "Disease", "Duct flow" = "DuctFlow", 
                                         "Grunting" = "Grunting", "Grunting report" = "GruntingReport", 
                                         "Hypoxia distribution" = "HypDistrib", "Hypoxia in O2" = "HypoxiaInO2", 
                                         "LVH" = "LVH", "LVH report" = "LVHreport", "Lower body O2" = "LowerBodyO2",
                                         "Lung flow" = "LungFlow", "Lung parenchema" = "LungParench", 
                                         "Right up quad O2" = "RUQO2", "Sick" = "Sick", "X-ray report" = "XrayReport"), 
                          selected = "BirthAsphyxia")),
          
          checkboxGroupInput("checkVariables", 
                             h4("Checkbox group"), 
                             choices = list("Age at presentation" = "Age", "Birth asphyxia" = "BirthAsphyxia", 
                                            "CO2" = "CO2", "CO2 report" = "CO2Report", 
                                            "Cardiac mixing" = "CardiacMixing", "Chest X-ray" = "ChestXray", 
                                            "Disease" = "Disease", "Duct flow" = "DuctFlow", 
                                            "Grunting" = "Grunting", "Grunting report" = "GruntingReport", 
                                            "Hypoxia distribution" = "HypDistrib", "Hypoxia in O2" = "HypoxiaInO2", 
                                            "LVH" = "LVH", "LVH report" = "LVHreport", "Lower body O2" = "LowerBodyO2",
                                            "Lung flow" = "LungFlow", "Lung parenchema" = "LungParench", 
                                            "Right up quad O2" = "RUQO2", "Sick" = "Sick", "X-ray report" = "XrayReport"), 
                             selected = NULL
          ),
          submitButton("Update", icon("refresh"))
        ),
        mainPanel(
          img(src = "paper_structure.png", height = 601, width = 833),
          br(),
          br(),
          span(textOutput("dSeparation"), style = "font-size:30px")
        )
      )
    )  
  )
)

# Define server logic
server <- function(input, output) {
  # output$<id_widget_name> <- <render_funciont>({<a complicated function>})
  # input$<id_widget_name> to access the value of the widget
  
  output$probabilities <- renderText({ 
    # creating structure node=evidence
    variables = c(input$BirthAsphyxia, input$HypDistrib, input$HypoxiaInO2, input$CO2, input$ChestXray, input$Grunting, input$LVHreport, input$LowerBodyO2, input$RUQO2, input$CO2Report, input$XrayReport, input$GruntingReport, input$Age, input$LVH, input$DuctFlow, input$CardiacMixing, input$LungParench, input$LungFlow, input$Sick)
    variables_name = c("BirthAsphyxia", "HypDistrib", "HypoxiaInO2", "CO2", "ChestXray", "Grunting", "LVHreport", "LowerBodyO2", "RUQO2", "CO2Report", "XrayReport", "GruntingReport", "Age", "LVH", "DuctFlow", "CardiacMixing", "LungParench", "LungFlow", "Sick")
    ev = list()
    pos <- 1
    for (i in 1 : length(variables)){
      if (variables[i] != "no_evidence"){
        tmp_name = variables_name[i]
        tmp_v = variables[i]
        ev[[tmp_name]] = tmp_v
        pos <- pos + 1
      }
    }
    
    if(length(ev) != 0){
      # variable to store the most likelly disease
      probs = list()
      #for (i in levels(dataset$Disease)){
      #  res = cpquery(paper_full_trained, event=Disease==i, method="lw", evidence = ev)
      #  probs[[pos]] = paste0(i, ": ", res)
      #  pos <- pos + 1
      #}
      
      disease_values = c("Fallot", "Lung", "PAIVS", "PFC", "TAPVD", "TGA")
      tmp = list()
      s <- 0
      res = cpquery(paper_full_trained, event=Disease=="Fallot", method="lw", evidence = ev)
      tmp[[1]] = res
      s <- s + res
      res = cpquery(paper_full_trained, event=Disease=="Lung", method="lw", evidence = ev)
      tmp[[2]] = res
      s <- s + res
      res = cpquery(paper_full_trained, event=Disease=="PAIVS", method="lw", evidence = ev)
      tmp[[3]] = res
      s <- s + res
      res = cpquery(paper_full_trained, event=Disease=="PFC", method="lw", evidence = ev)
      tmp[[4]] = res
      s <- s + res
      res = cpquery(paper_full_trained, event=Disease=="TAPVD", method="lw", evidence = ev)
      tmp[[5]] = res
      s <- s + res
      res = cpquery(paper_full_trained, event=Disease=="TGA", method="lw", evidence = ev)
      tmp[[6]] = res
      s <- s + res
      
      for (i in 1 : 6){
        tmp[[i]] = round((tmp[[i]] / s), digits = 3) * 100
        probs[[i]] = paste0(disease_values[i], " : ", tmp[i], "%")
      }
      
      
      sprintf("%s, %s, %s, %s, %s, %s", probs[1], probs[2], probs[3], probs[4], probs[5], probs[6])
    }
    else{
      sprintf("Insert some evidences, please")
    }
  })
  output$dSeparation <- renderText({
    given = input$checkVariables
    # i'm not looking if a query variable is considered an evidence
    if(is.null(given)){
      sprintf("Please insert some know variables")
    }
    else{
      source = input$source
      destination = input$destination
      is.dSeparated = FALSE
      is.dSeparated = dsep(paper_model, source, destination, given)
      if(is.dSeparated){
        sprintf("%s is INDEPENDENT from %s", source, destination)
      }
      else{
        sprintf("%s is DEPENDENT from %s", source, destination)
      }
    }
  })
}

# Run the app
shinyApp(ui = ui, server = server)