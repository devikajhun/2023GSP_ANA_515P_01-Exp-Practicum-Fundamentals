#Let's import the dataset into R
df1<- read_xlsx("/Users/devika/Downloads/presidential_polls_2020.xlsx", sheet = "Sheet1")
df2<- read_xlsx("/Users/devika/Downloads/presidential_polls_2020.xlsx", sheet = "Sheet2")

#Let's combine the two sheets
df<- rbind (df1, df2)

#let's have a look at the data
glimpse(df)
summary(df)
str(df)

#let's change the date format to date and numbers
df$modeldate<- as.Date(df$modeldate, origin= "1899-12-30")
df$enddate<- as.Date(as.numeric(df$enddate), origin= "1899-12-30")
df$startdate<- as.Date(as.numeric(as.character(df$startdate)), origin= "1899-12-30")
df$weight <- as.numeric(df$weight)
df$influence <- as.numeric(df$influence)
df$pct <- as.numeric(df$pct)

#let's look at columns with missing values
plot_missing(df)

#column "tracking" has a lot of missing values so let's remove it
df = select(df, -tracking)

#drop NA's
df <- na.omit(df)
df[complete.cases(df),]

#let's look at the unique value sin each column to ensure data is entered consistently
unique(df$cycle)
unique(df$state)
unique(df$candidate_name)
unique(df$pollster)
unique(df$population)

#changing values for consistency
df$cycle[df$cycle == '20'] <- '2020'
df$state[df$state =='WY' ] <- 'Wyoming'
df$state[df$state == 'WI' ] <- 'Wisconsin'
df$state[df$state == 'NATl' ] <- 'National'
df$state[df$state == 'PA' ] <- 'Pennsylvania'
df$state[df$state == 'NC' ] <- 'North Carolina'
df$candidate_name[df$candidate_name == 'Joseph R. Biden Jr.'] <- 'Biden'
df$pollster[df$pollster == 'Morning Con'] <- 'MorningConsult'

#let's see which which states the pollsters came from. We'll create a frequency plot for state.

ggplot(df, aes(state)) +geom_bar()
       
       