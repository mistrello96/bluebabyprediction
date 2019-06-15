library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel(h1("This is a title")),
  
  sidebarLayout( # layout with a sidebar
    # position = right to put the sidebar on the right
    
    sidebarPanel( # side bar content
      "sidebar panel"),
      
    mainPanel(  # main panel content
      h1("First level title"), # , align = "center" to center the text
      h2("Second level title"),
      h3("Third level title"),
      h4("Fourth level title"),
      h5("Fifth level title"),
      h6("Sixth level title")
      
      # look lesson 2 for formatted text and insert images
      
      
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

}

shinyApp(ui = ui, server = server)