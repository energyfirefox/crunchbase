#interquartile (>1q & <3q)

medianst <- tapply(X = maincompanydatapos$raised_amount, INDEX = maincompanydatapos$country_code, FUN = median)
meanst <- tapply(X = maincompanydatapos$raised_amount, INDEX = maincompanydatapos$country_code, FUN = mean )
maxst <- tapply(X = maincompanydatapos$raised_amount, INDEX = maincompanydatapos$country_code, FUN = max)
countst <- tapply(X = maincompanydatapos$raised_amount, INDEX = maincompanydatapos$country_code, FUN = length)

  
mainsumcountry <- as.data.frame(cbind(medianst, meanst, maxst, countst))
mainsumcountry <- mainsumcountry[mainsumcountry$countst > 5, ]

listofcountry<- rownames(mainsumcountry)

companydataposx1 <- maincompanydatapos[maincompanydatapos$country_code == listofcountry[1], ]

for (i in 2:length(listofcountry)){
  companydataposx <- maincompanydatapos[maincompanydatapos$country_code == listofcountry[i], ]
  companydataposx1 <- rbind(companydataposx1,companydataposx)
  
}
boxplot(companydataposx1$raised_amount ~ companydataposx1$country_code)