library(shiny)
library(shinyjs)
library(DT)
library(shinyjqui)
library(ECharts2Shiny)
library(leaflet)
library(ggplot2)
library(plotly)


shinyUI(
  fluidPage(useShinyjs(),
  h3("Analysis App"),
  sidebarPanel(

    fileInput("inputfile","Upload Spreadsheet",accept=c('.xlsx')), # Reference the file using this name
    selectInput("input2","Include Provider 2",choices = c("Option 1","Option 2", "Option 3")),
    numericInput("input3", "Duration", value = 36, min = 12, max = 60, step =12),
    selectInput("input4","Provider",choices = c("New","Existing")),
    numericInput("input6_1", "Min Value 1 (Mbps)", value = 10, min = 0.001, step =1),
    numericInput("input6_2", "Min Value 2 (Mbps)", value = 5, min = 0.001, step =1),
    checkboxInput("input8","Check if need this option",value = FALSE),
    checkboxInput("input9","Check if need this option",value = FALSE),
    orderInput(inputId = 'input10', label = 'Rearrange Options', items = c('ID1','ID2', 'ID3','ID4')),
    br(),
    actionButton("analysis", "Start Analysis", icon("paper-plane"), 
                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
    downloadButton('download', "Download Results"), 
    width = 3),
  mainPanel(
    loadEChartsLibrary(),    
    tags$head(
      tags$style(
        HTML(".shiny-notification {
             height: 50px;
             width: 400px;
             position:fixed;
             top: calc(50% - 50px);;
             left: calc(60% - 400px);;
             }
             "
        )
        )
        ),

    tabsetPanel(id="tabs",
                tabPanel("Summary 1",br(),DT::dataTableOutput("cov_stats"),br(), leafletOutput("Map1")),
                tabPanel("Summary 2",br(),DT::dataTableOutput("tech_summ"),br(), br(),
                         h3("Tech Distro", align = "center"), br(),br(),
                         tags$div(id="testTechSumm",style="width:50%;height:400px;",align = "center"),
                         deliverChart(div_id = "testTechSumm"),
                         plotlyOutput("plot_BestTech", width = "70%", height = "500px")),
                tabPanel("Summary 3",br(),DT::dataTableOutput("cost_summ"),br(),br(),
                         h3("Tech Distro", align = "center"), br(), br(),
                         tags$div(id="testSpeedCostSumm", style="width:50%;height:400px;", align = "center"),
                         deliverChart(div_id = "testSpeedCostSumm"), 
                         plotlyOutput("plot_MinCost", width = "80%", height = "500px")),
                tabPanel("Summary 4",br(),DT::dataTableOutput("cov_summ"),br(), br(),
                         h3("Tech Distro", align = "center"), br(), br(),
                         tags$div(id="testCovSumm", style="width:50%;height:400px;", align = "center"),
                         deliverChart(div_id = "testCovSumm"), 
                         plotlyOutput("plot_MaxCov", width = "80%", height = "500px")),
                navbarMenu("More",
                           tabPanel("Menu 1",br(), DT::dataTableOutput("WideFormat")),
                           tabPanel("Menu 2",br(), DT::dataTableOutput("LongFormat")),
                           tabPanel("Menu 3",br(),DT::dataTableOutput("high_speed_options")),
                           tabPanel("Menu 4",br(),DT::dataTableOutput("technology_details")),
                           tabPanel("Menu 5",br(),DT::dataTableOutput("cost_details")),
                           tabPanel("Menu 6",br(),DT::dataTableOutput("cov_details"))
                          )
                          )
                          )
                          )
)
