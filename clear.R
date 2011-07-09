branchesdata <- read.csv("~/Projects/crunchbase/data/branches.csv", na.strings = "\\N", dec = ".")
str(branchesdata)

country_codes <- read.csv("~/Projects/crunchbase/data/CountryCodes.csv")

branchesdata$country_code <- as.character(branchesdata$country_code)
summary(branchesdata$amount_raised)

branchesdata1 <- branchesdata[(as.character(branchesdata$country_code) %in% country_codes$Country.Code), ]
startups <- branchesdata1[, c('name', 'country_code', 'amount_raised', 'category_code','number_of_employees','founded_year')]

# stats for categories
categorysum <- as.data.frame(table(startups$category_code))
colnames(categorysum) <- c('category', 'amount')
# cleaning data
categorysum <- categorysum[categorysum$amount >= 50  , ] 
categorysum <- categorysum[nchar(categorysum$category) > 2 , ]
Ord <- order(categorysum$amount, decreasing =  TRUE)
categorysum <- categorysum[Ord, ]
pie(categorysum$amount, labels = categorysum$category )

startups <- startups[startups$category_code %in% categorysum$category, ]

str(startups)
startups$name <- as.character(startups$name)
startups$amount_raised <- as.numeric(as.character(startups$amount_raised))
startups$amount_raised <- startups$amount_raised /1000
startups$category_code <- as.character(startups$category_code)
startups$number_of_employees <- as.character(startups$number_of_employees)
startups$founded_year <- as.character(startups$founded_year)

table(startups$category_code)
table(startups$founded_year)

summary(startups$amount_raised)

plusstartups <- startups[startups$amount_raised > 0, ]

summary(plusstartups$amount_raised)

# saving clear data
setwd("~/Projects/crunchbase/data/")
write.csv(startups, file = "startups.csv")
write.csv(plusstartups, file = "plusstartups.csv")











### clear data
# if (country_code) not in country list
# name <- name + country_code
# country_code <- state_code
# amount_raised <- category_code
# category_code <- number_of_employees
# number_of_employees <- founded_year
# founded_year <-founded_month
###


for (i in 1:length(branchesdata$id)) {
  if (branchesdata$country_code[i] %in% nocountry) {
    branchesdata$name[i] <- paste(branchesdata$name[i], branchesdata$country_code[i])
    branchesdata$country_code[i] <-  branchesdata$state_code[i]
    branchesdata$amount_raised[i] <- branchesdata$category_code[i]
    branchesdata$category_code[i] <- branchesdata$number_of_employees[i]
    branchesdata$number_of_employees[i] <- branchesdata$founded_year[i] 
    branchesdata$founded_year[i] <- branchesdata$founded_month[i]    
  }
}



