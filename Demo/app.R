# Here the code is run once at the launchof the app, so put HERE all 
# the instruction to import libries, datas, whatever must be run 
# once in order to not affect performances
library(shiny)

# Define UI for app
ui <- fluidPage(
  titlePanel(h1("This is a title")),
  
  sidebarLayout( # layout with a sidebar
    # position = right to put the sidebar on the right
    
    sidebarPanel( # side bar content
      "sidebar panel",
      fluidRow(
        column(12, 
               selectInput("select", h3("Select box"), 
                           choices = list("Choice 1" = 1, "Choice 2" = 2,
                                          "Choice 3" = 3), selected = 1)
        )
      )
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