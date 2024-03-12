#' library(shiny)
#' library(plotly)
#' library(DT)
#' library(ggplot2)
#' library(shinyWidgets)
#' library(shinythemes)
#' 
#' # Define UIa
#' ui <- fluidPage(theme = shinytheme("cyborg"),
#'                 #darkly, cyborg, cosmo, flatly, slate, cerulean, united
#' 
#'       tags$head(
#'       # Note the wrapping of the string in HTML()
#'       tags$style(HTML("
#'       @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
#'       body {
#'      #   background-color: black;
#'      #   color: white;
#'       }
#'       h2 {
#'         font-family: 'Yusei Magic', sans-serif;
#'       }
#'       .shiny-input-container {
#'        # color: #474747;
#'       }"))),
#' 
#'       tags$style(type="text/css",
#'                  ".shiny-output-error { visibility: hidden; }",
#'                  ".shiny-output-error:before { visibility: hidden; }"
#'       ),
#' 
#' 
#' 
#'   titlePanel("IUCN Red List Data Visualization"),
#'   sidebarLayout(
#'     sidebarPanel(
#'       checkboxGroupInput(
#'         inputId = "Species_regional_category",
#'         label = "Please choose a Red List Category:",
#'         choices = c("Extinct (EX)" = "EX",
#'                     "Extinct in the Wild (EW)" = "EW",
#'                     "Critically Endangered (CR)" = "CR",
#'                     "Endangered (EN)" = "EN",
#'                     "Vulnerable (VU)" = "VU",
#'                     "Near Threatened (NT)" = "NT.or.LR.nt",
#'                     "Least Concern (LC)" = "LC.or.LR.lc",
#'                     "Data Deficient (DD)" = "DD",
#'                     "Select All"= "ALL"),
#'         selected = "DD"
#'       ),
#'       radioButtons(inputId = "Selection", label = "Countries/Region", choices = c("Global", "Region"), selected = "Global"),
#'       selectInput(inputId = "Countries_Region",
#'                   label = "Choose Region",
#'                   choices = c("00. Show All",
#'                               "01. Antarctic",
#'                               "02. Caribbean Islands",
#'                               "03. East Asia",
#'                               "04. Europe",
#'                               "05. Mesoamerica",
#'                               "06. North Africa",
#'                               "07. North America",
#'                               "08. North Asia",
#'                               "09. Oceania",
#'                               "10. South America",
#'                               "11. South And Southeast Asia",
#'                               "12. Saharan Africa",
#'                               "13. West And Central Asia"), selected = "00. Show All"),
#'       numericInput(inputId = "obs",
#'                    label = "Number of data to view:",
#'                    value = 10),
#' 
#'       #
#'       # convertMenuItem(
#'       #   menuItem("Chart",tabName = "chart",icon=icon("pencil"),
#'       #            prettyRadioButtons(
#'       #              inputId = "radio",
#'       #              label = "Choose:",
#'       #              choices = c("01. Mammalia",
#'       #                          "02. Amphibian",
#'       #                          "03. Reptilian",
#'       #                          "04. Insecta")
#'       #            )
#'       #   ),# end of radioButton $ menuItem
#'       #   tabName = "Usecases")
#' 
#' 
#' 
#' 
#'     ),
#'     mainPanel(
#'       plotlyOutput("distribution_Plot", height = "600px"),
#'       plotlyOutput("region_Plot", height = "150px"),
#'       plotOutput("category_Species_Plot", height = "290px"),
#'       plotlyOutput("uncertainty_plot", height = "290px"),
#'       dataTableOutput("Regional_data"),
#'      # dataTableOutput("Regional_RLdata"),
#'       verbatimTextOutput("summary_regional")
#'     )
#'   )
#' )


#' library(shiny)
#' library(plotly)
#' library(DT)
#' library(ggplot2)
#' library(shinyWidgets)
#' library(shinythemes)
#' 
#' # Define UI
#' ui <- fluidPage(theme = shinytheme("cyborg"),
#'                 # Additional themes: darkly, cyborg, cosmo, flatly, slate, cerulean, united
#'                 tags$head(
#'                   # Custom CSS and fonts
#'                   tags$style(HTML("
#'                   @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
#'                   body {
#'                     /* Background and text color */
#'                   }
#'                   h2 {
#'                     font-family: 'Yusei Magic', sans-serif;
#'                   }
#'                   .shiny-input-container {
#'                     /* Text color */
#'                   }")),
#'                   tags$style(type="text/css",
#'                              ".shiny-output-error { visibility: hidden; }",
#'                              ".shiny-output-error:before { visibility: hidden; }")
#'                 ),
#'                 titlePanel("IUCN Red List Data Visualization"),
#'                 sidebarLayout(
#'                   sidebarPanel(
#'                     checkboxGroupInput(
#'                       inputId = "Species_regional_category",
#'                       label = "Please choose a Red List Category:",
#'                       choices = c(
#'                         "Extinct (EX)" = "EX",
#'                         "Extinct in the Wild (EW)" = "EW",
#'                         "Critically Endangered (CR)" = "CR",
#'                         "Endangered (EN)" = "EN",
#'                         "Vulnerable (VU)" = "VU",
#'                         "Near Threatened (NT)" = "NT.or.LR.nt",
#'                         "Least Concern (LC)" = "LC.or.LR.lc",
#'                         "Data Deficient (DD)" = "DD",
#'                         "Select All"= "ALL"
#'                       ),
#'                       selected = "DD"
#'                     ),
#'                     radioButtons(inputId = "Selection", label = "Countries/Region",
#'                                  choices = c("Global", "Region"), selected = "Global"),
#'                     selectInput(inputId = "Countries_Region",
#'                                 label = "Choose Region",
#'                                 choices = c(
#'                                   "00. Show All",
#'                                   "01. Antarctic",
#'                                   "02. Caribbean Islands",
#'                                   "03. East Asia",
#'                                   "04. Europe",
#'                                   "05. Mesoamerica",
#'                                   "06. North Africa",
#'                                   "07. North America",
#'                                   "08. North Asia",
#'                                   "09. Oceania",
#'                                   "10. South America",
#'                                   "11. South And Southeast Asia",
#'                                   "12. Saharan Africa",
#'                                   "13. West And Central Asia"
#'                                 ),
#'                                 selected = "00. Show All"),
#'                     numericInput(inputId = "obs", label = "Number of data to view:", value = 10),
#'                     # Adding the category selection directly in the sidebar
#'                     prettyRadioButtons(inputId = "radio",
#'                                        label = "Choose:",
#'                                        choices = c(
#'                                          "01. Mammalia",
#'                                          "02. Amphibian",
#'                                          "03. Reptilian",
#'                                          "04. Insecta"
#'                                        ))
#'                   ),
#'                   mainPanel(
#'                     plotlyOutput("distribution_Plot", height = "600px"),
#'                     plotlyOutput("region_Plot", height = "150px"),
#'                     plotOutput("category_Species_Plot", height = "290px"),
#'                     plotlyOutput("uncertainty_plot", height = "290px"),
#'                     dataTableOutput("Regional_data"),
#'                     verbatimTextOutput("summary_regional")
#'                   )
#'                 )
#'                 
#'                 
#' )
#' 
#' 
#' 
#' 

library(shiny)
library(plotly)
library(DT)
library(ggplot2)
library(shinyWidgets)
library(shinythemes)

# Define UI
ui <- fluidPage(
  theme = shinytheme("cyborg"), # Theme selection
  # Custom styles
  tags$head(
    tags$style(HTML("
    @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
    body {
      /* Custom body styles */
    }
    h2 {
      font-family: 'Yusei Magic', sans-serif;
    }
    .shiny-input-container {
      /* Input container styles */
    }")),
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    )
  ),
  
  # Title panel
  titlePanel("IUCN Red List Data Visualization"),
  
  # Sidebar layout
  sidebarLayout(
    sidebarPanel(
      # Red List Category selection
      checkboxGroupInput(
        inputId = "Species_regional_category",
        label = "Please choose a Red List Category:",
        choices = c("Extinct (EX)" = "EX",
                    "Extinct in the Wild (EW)" = "EW",
                    "Critically Endangered (CR)" = "CR",
                    "Endangered (EN)" = "EN",
                    "Vulnerable (VU)" = "VU",
                    "Near Threatened (NT)" = "NT.or.LR.nt",
                    "Least Concern (LC)" = "LC.or.LR.lc",
                    "Data Deficient (DD)" = "DD",
                    "Select All"= "ALL"),
        selected = "DD"
      ),
      # Region selection
      radioButtons(inputId = "Selection", label = "Countries/Region", choices = c("Global", "Region"), selected = "Global"),
      # Specific region dropdown
      selectInput(inputId = "Countries_Region",
                  label = "Choose Region",
                  choices = c("00. Show All",
                              "01. Antarctic",
                              "02. Caribbean Islands",
                              "03. East Asia",
                              "04. Europe",
                              "05. Mesoamerica",
                              "06. North Africa",
                              "07. North America",
                              "08. North Asia",
                              "09. Oceania",
                              "10. South America",
                              "11. South And Southeast Asia",
                              "12. Saharan Africa",
                              "13. West And Central Asia"),
                  selected = "00. Show All"),
      # Data observation number input
      numericInput(inputId = "obs", label = "Number of data to view:", value = 10),
      # Use case selection
      prettyRadioButtons(inputId = "radio",
                         label = "Choose a Use Case:",
                         choices = c("01. Mammalia",
                                     "02. Amphibian",
                                     "03. Reptilian",
                                     "04. Insecta"))
    ),
    mainPanel(
      tabsetPanel(
        id = "mainTabset",
        # Overview tab with general plots and data tables
        tabPanel("Overview",
                 plotlyOutput("distribution_Plot", height = "600px"),
                 plotlyOutput("region_Plot", height = "150px"),
                 plotOutput("category_Species_Plot", height = "290px"),
                 plotlyOutput("uncertainty_plot", height = "290px"),
                 dataTableOutput("Regional_data"),
                 verbatimTextOutput("summary_regional")),
        # Detailed analysis and visualization based on user's use case selection
        tabPanel("Detailed Analysis",
                 plotlyOutput("sevenCatgories"),
                 plotlyOutput("DDvsTotal"),
                 plotOutput("pieChart"),
                 plotOutput("Errorbar"))
      )
    )
  )
)

shinyApp(ui = ui, server = server)

