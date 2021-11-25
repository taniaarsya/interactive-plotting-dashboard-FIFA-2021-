#sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Data Analyst", icon = icon("home"),
             tabName = "summary"),
    menuItem(text = "Player Data", icon = icon("users"),
             tabName = "player_data")
  )
)

#tabPlayerData
fluidPlayerData <- fluidRow(
  box(width = 12, title = "Player Database", solidHeader = T, status = "primary",
      tabsetPanel(
        tabPanel("Data base",
                 dataTableOutput(outputId = "playerDatabase")
        )
      )
  )
)

#tabHome
fluidSummary <- fluidRow(
  valueBoxOutput("totalPlayersBox"),
  valueBoxOutput("totalClubBox"),
  valueBoxOutput("totalNationalityBox"),
  box( width = 12, title = "Data Analyst", solidHeader = T, status = "primary",
       tabBox( width = 12,
               tabPanel("Best Player Overall Skill",
                        plotlyOutput(outputId = "playerOverall")
               ),
               tabPanel("Player Nationality",
                        plotlyOutput(outputId = "playersNationality"),
               ),
               tabPanel("Distribution Skill With Age",
                        plotlyOutput(outputId = "playerOverallByAge"),
               ),
               tabPanel("Distribution Player Position",
                        plotlyOutput(outputId = "playerByPosition")
               )
       )
  )
)

#body
body <- dashboardBody(
  tabItems(tabItem(tabName = "summary", fluidSummary),
           tabItem(tabName = "player_data", fluidPlayerData)
  )
)

page <- dashboardPage(
  dashboardHeader(title = "Dashboard Analysis of FIFA 2021"),
  sidebar,
  body
)


shinyUI(page)
