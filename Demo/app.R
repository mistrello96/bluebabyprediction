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
      selectInput("BirthAsphyxia-value", h4("Birth asphyxia"), 
                  choices = list("no" = "no", "yes" = "yes"), selected = 1),
      selectInput("HypDistrib-value", h4("BirthAsphyxia"), 
                  choices = list("Equal" = "Equal", "Unequal" = "Unequal"), selected = 1),
      selectInput("HypoxiaInO2-value", h4("BirthAsphyxia"), 
                  choices = list("Mild" = "Mild", "Moderate" = "Moderate",
                                 "Severe" = "Severe"), selected = 1),
      selectInput("CO2-value", h4("BirthAsphyxia"), 
                  choices = list("High" = "High", "Low" = "Low",
                                 "Normal" = "Normal"), selected = 1),
      selectInput("ChestXray-value", h4("BirthAsphyxia"), 
                  choices = list("Asy/Patch" = "Asy/Patch", "Grd Glass" = "Grd_Glass",
                                 "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                 "Plethoric" = "Plethoric"), selected = 1),
      selectInput("Grunting-value", h4("BirthAsphyxia"), 
                  choices = list("no" = "no", "yes" = "yes"), selected = 1),
      selectInput("LVHreport-value", h4("BirthAsphyxia"), 
                  choices = list("no" = "no", "yes" = "yes"), selected = 1),
      selectInput("LowerBodyO2-value", h4("BirthAsphyxia"), 
                  choices = list("<5" = "<5", "12+" = "12+", 
                                 "5-12" = "5-12"), selected = 1),
      selectInput("RUQO2-value", h4("BirthAsphyxia"), 
                  choices = list("<5" = "<5", "12+" = "12+", 
                                 "5-12" = "5-12"), selected = 1),
      selectInput("CO2Report-value", h4("BirthAsphyxia"), 
                  choices = list("<7.5" = "<7.5", ">=7.5" = ">=7.5"), selected = 1),
      selectInput("XrayReport-value", h4("BirthAsphyxia"), 
                  choices = list("Asy/Patch" = "Asy/Patch", "Grd Glass" = "Grd_Glass",
                                 "Normal" = "Normal", "Oligaemic" = "Oligaemic",
                                 "Plethoric" = "Plethoric"), selected = 1),
      selectInput("GruntingReport-value", h4("BirthAsphyxia"), 
                  choices = list("no" = "no", "yes" = "yes"), selected = 1),
      selectInput("Age-value", h4("BirthAsphyxia"), 
                  choices = list("0-3 days" = "0-3_days", "11-30 days" = "11-30_days",
                                 "" = "Normal"), selected = 1),
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