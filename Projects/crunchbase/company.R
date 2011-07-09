companydata <- read.csv("~/Projects/crunchbase/data/companydata.csv")
library(lattice)

#convert factors to character
companydata$country_code <- as.character(companydata$country_code)

#inc all raises
companydata$raised_amount <- companydata$raised_amount/1000

# only sold
companydatapos <- companydata[companydata$raised_amount > 0  , c('name','country_code', 'raised_amount')]
summary(companydatapos$raised_amount)
sd(companydatapos$raised_amount)

maxproject <- companydata[companydata$raised_amount == '5620000', ]
companydataposmax <- companydatapos[companydatapos$raised_amount >= 1000000, ]
companydataposUKR <- companydatapos[companydatapos$country_code == 'UKR', ]


maincompanydatapos <- companydata[(companydata$raised_amount > 1320 & companydata$raised_amount < 17410) , c('country_code', 'raised_amount')]
lowcompanydatapos <- companydata[companydata$raised_amount <= 1320, c('country_code', 'raised_amount')]
highcompanydatapos <- companydata[companydata$raised_amount >= 17410, c('country_code', 'raised_amount')]

#for all raised_amount >0

minst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = min)
medianst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = median)
meanst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = mean )
maxst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = max)
sumst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = sum)
countst <- tapply(X = companydatapos$raised_amount, INDEX = companydatapos$country_code, FUN = length)


sumcountry <- as.data.frame(cbind(minst, medianst, meanst, maxst, sumst, countst))


Ord <- order(sumcountry$countst, decreasing = TRUE)
sumcountry <- sumcountry[Ord, ]
summary(sumcountry$countst)

sumcountry <- sumcountry[sumcountry$countst >= 50, ]

listofcountry<- rownames(sumcountry)



companydataposx1 <- companydatapos[companydatapos$country_code == listofcountry[1], ]

for (i in 2:length(listofcountry)){
  companydataposx <- companydatapos[companydatapos$country_code == listofcountry[i], ]
  companydataposx1 <- rbind(companydataposx1,companydataposx)
  
}
  
boxplot(companydataposx1$raised_amount ~ companydataposx1$country_code)
  
companydataposx1 <- companydataposx1[(companydataposx1$country_code != "USA" & companydataposx1$country_code != "GBR"), ]
boxplot(companydataposx1$raised_amount ~ companydataposx1$country_code)

# рахуємо відсоток спрацювавших стартапів до всіх

countstall <- tapply(X = companydata$raised_amount, INDEX = companydata$country_code, FUN = length)
sumstall <- tapply(X = companydata$raised_amount, INDEX = companydata$country_code, FUN = sum)
sumcountryall <- as.data.frame(cbind(sumstall, countstall))
 




