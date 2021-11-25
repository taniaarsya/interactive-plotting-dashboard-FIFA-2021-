#add library processing data 
library(dplyr)
library(readr)
library(tidyr)
library(stringr)
library(lubridate)
library(httr)
library(rvest)
library(stringi)

# Aplikasi
library(shiny)
library(shinydashboard)
library(DT)

#visualisasi
library(ggplot2)
library(plotly)
library(scales)
library(glue)
library(leaflet)
library(maps)
# install.packages("igraph")
library(igraph)
# install.packages("ggraph")
library(ggraph)
# install.packages("geojsonio")
library(geojsonio)

#import data
player_data_6 <- read_csv("data/players_20.csv")
team <- read_csv("data/teams_and_leagues.csv")
player_data_2019 <- read_csv("data/FIFA 19 Player DB.csv")


# Bind seperate data
player_data <- rbind(player_data_6)

# data wrangling 

glimpse(player_data_2019)

encode <- function(x) {
  Encoding(x) <- 'latin1'
  return(stri_trans_general(x, 'Latin-ASCII'))
}

goalkeeper_position <- c("GK")
defender_position <- c("RCB","RB","LB","CB","SW","RWB","LWB")
midfielder_position <- c("RCM","LCM","CM","CDM","DM","RW","LW","RM","LM","AM","CAM")
forward_position <- c("ST","CF","RF","LF")

league <- player_data_2019 %>% 
  mutate(club = encode(Club),
         league = encode(League)) %>% 
  select(league,club) %>%
  group_by(league) %>% 
  unique()

player_data <- player_data %>%
  distinct(long_name, .keep_all = T) %>% 
  filter(is.na(short_name) == F,
         is.na(long_name) == F,
         is.na(club) == F
  ) %>% 
  mutate(short_name = as.character(short_name),
         long_name = as.character(long_name),
         dob = ymd(dob),
         joined = ymd(joined),
         club = stri_trans_general(club, 'Latin-ASCII'))

player_data <- left_join(player_data, league)

player_league <- player_data %>%
  select(league) %>%
  distinct(league)


#scrapping 
# url <- "https://sofifa.com/teams?type=national"
# url_text <- read_html(url)
# country_code <- html_nodes(url_text, ".opt.bp3") 
# # %>% html_attr("value")
# # country_name <- html_nodes(url_text, ".opt.bp3") %>% html_text()
# # 
# # country <- cbind(country_code,country_name)
# # country
# 