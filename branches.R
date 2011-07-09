startups <- read.csv("~/Projects/crunchbase/data/startups.csv")
plusstartups <- read.csv("~/Projects/crunchbase/data/plusstartups.csv")

x1 <- table(startups$category)
x2 <- table(plusstartups$category)

x <- rbind(table(startups$category), table(plusstartups$category))


barplot(x, beside = TRUE,  col = gray(c(0.5, 1)))