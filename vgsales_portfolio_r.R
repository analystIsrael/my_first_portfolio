# VGSALES
# YEAR: 1980 - 2020
# SOURCE: KAGGLE

#THE NO OF VIDEO GAMES SOLD BY EACH PUBLISHER
View(vgsales %>% group_by(Publisher) %>% summarise(n = n()) %>% arrange(-n))
#Electronic Arts sold the most games

#THE COMPANIES/PUBLISHERS THAT SOLD MORE THAN 100 VIDEO GAMES
View(vgsales %>% group_by(Publisher) %>% summarise(n = n()) %>% 
      filter(n > 100)  %>% arrange(-n)) 

# THE MOST SUCCESSFUL Publisher
vgsales %>% group_by(Publisher) %>% 
  summarise(GlobalSales = sum(Global_Sales)) %>% 
  arrange(-GlobalSales)


# THE NO OF INDIVIDUAL GENRES SOLD
View(vgsales %>% group_by(Genre) %>% summarise(n=n()) %>% 
  arrange(-n))
ggplot(vgsales, aes(Genre)) + geom_bar() + coord_flip()
  

#THE MOST PROFITABLE YEAR
View(vgsales %>% group_by(Year) %>% 
  summarise(GlobalSales = sum(Global_Sales), n = n()) %>% 
    arrange(-GlobalSales))

# THE MOST PROFITABLE PLATFORM
vgsales %>% group_by(Platform) %>% 
  summarise(GlobalSales = sum(Global_Sales)) %>% 
  arrange(-GlobalSales)
# the most profitable platform is the PS2



# IN EU
# THE MOST SUCCESSFUL PUBLISHER
vgsales %>% group_by(Publisher) %>% summarise(EUSales = sum(EU_Sales)) %>% 
  arrange(-EUSales)
# Nintendo is the most successful Publisher in Europe

# THE MOST SUCCESSFUL GENRE
vgsales %>% group_by(Genre) %>% summarise(EUSales = sum(EU_Sales)) %>% 
  arrange(-EUSales)
# Action is the most successful genre in Europe

# THE MOST PROFITABLE PLATFORM
vgsales %>% group_by(Platform) %>% 
  summarise(EUSales = sum(EU_Sales)) %>% 
  arrange(-EUSales)
# the most profitable platform in Europe is the PS3.



# IN JP
# THE MOST SUCCESSFUL PUBLISHER
vgsales %>% group_by(Publisher) %>% summarise(JPSales = sum(JP_Sales)) %>% 
  arrange(-JPSales)
# Nintendo is the most successful Publisher in JP

# THE MOST SUCCESSFUL GENRE
vgsales %>% group_by(Genre) %>% summarise(JPSales = sum(JP_Sales)) %>% 
  arrange(-JPSales)
# Role-Playing is the most successful GENRE in JP

# THE MOST PROFITABLE PLATFORM
vgsales %>% group_by(Platform) %>% 
  summarise(JPSales = sum(JP_Sales)) %>% 
  arrange(-JPSales)
# the most profitable platform in JP is the DS.










 


