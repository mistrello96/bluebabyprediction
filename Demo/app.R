# Here the code is run once at the launch of the app, so put HERE all 
# the instruction to import libries, datas, whatever must be run 
# once in order to not affect performances
library(shiny)

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
                      selected = "no_evidence"))
    ),
      
    mainPanel(  # main panel content
      h1("First level title"), # , align = "center" to center the text
      h2("Second level title"),
      h3("Third level title"),
      h4("Fourth level title"),
      h5("Fifth level title"),
      h6("Sixth level title")
      
      # look lesson 2 for formatted text and how insert images

          
      
    )
  )
)

# Define server logic
server <- function(input, output) {
  # output$<id_widget_name> <- <render_funciont>({<a complicated function>})
  # input$<id_widget_name> to access the value of the widget
}

# Run the app
shinyApp(ui = ui, server = server)