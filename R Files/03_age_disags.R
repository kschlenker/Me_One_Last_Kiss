# __________________________________________________________________
#
#  -------------------------  AGE DISAGS  ------------------------- 
# __________________________________________________________________


finaldata$agecoarse=NA
finaldata$agesemifine=NA
finaldata$agefine=NA
finaldata$ageovc=NA
finaldata$agevmmc=NA


# ___________________________________________________
#
#  COARSE AGE DISAGS (<15, 15+) 
#           FOR OVC: (<18, 18+)
# ___________________________________________________

coarse_15plus <- finaldata$ageasentered %in% c("20-24" , "25-49", "15+", "50+", "15-19", 
                                               "25-29", "30-49", "15-17", "18-24", "25+",
                                               "30-34", "35-39", "40-49", "18+", "20+")
coarse_u15 <- finaldata$ageasentered %in% c("<01" , "<15", "01-09", "10-14", "<=02 Months",
                                            "02 - 12 Months", "02 Months - 09 Years", "<02 Months",
                                            "<10", "01-04", "05-09", "05-14", "01-14")
coarse_incompatable <- finaldata$ageasentered %in% c("<18")

finaldata$agecoarse[coarse_15plus] <- "15+"
finaldata$agecoarse[coarse_u15] <- "<15"
finaldata$agecoarse[coarse_incompatable] <- "Not coarse age compatable"


ovc_18plus <- grepl("OVC", finaldata$indicator) & 
  finaldata$ageasentered %in% c("20-24" , "25-49", "50+", "25-29", "30-49", 
                                "18-24", "25+", "30-34", "35-39", "40-49", "18+", "20+")


ovc_u18 <- grepl("OVC", finaldata$indicator) & 
  finaldata$ageasentered %in% c("<01" , "<15", "01-09", "10-14", "<=02 Months",
                                "02 - 12 Months", "02 Months - 09 Years", "<02 Months",
                                "<10", "01-04", "05-09", "05-14", "01-14", "15-17", "<18")

ovc_incompatable <- grepl("OVC", finaldata$indicator) & finaldata$ageasentered %in% c("15+", "15-19")

finaldata$agecoarse[ovc_18plus] <- "18+"
finaldata$agecoarse[ovc_u18] <- "<18"
finaldata$agecoarse[ovc_incompatable] <- "Not coarse age compatable"

# __________________________________________________________________
#
#  SEMIFINE AGE DISAGS (<01, 1-9. 10-14, 15-19, 20-24, 25-49, 50+)
# __________________________________________________________________

semifine_u1 <- finaldata$ageasentered %in% c("<01", "<=02 Months", "02 - 12 Months", "<02 Months")
semifine_1.9 <- finaldata$ageasentered %in% c("01-09", "01-04", "05-09")
semifine_10.14 <- finaldata$ageasentered %in% c("10-14")
semifine_15.19 <- finaldata$ageasentered %in% c("15-19", "15-17")
semifine_20.24 <- finaldata$ageasentered %in% c("20-24" )
semifine_25.49 <- finaldata$ageasentered %in% c("25-49", "25-29", "30-49", "30-34", "35-39", "40-49")
semifine_50plus <- finaldata$ageasentered %in% c("50+")
semifine_incompatable <- finaldata$ageasentered %in% c("15+", "<15", "02 Months - 09 Years", "<10", 
                                                       "18-24", "25+", "<18", "18+", "05-14", "20+", "01-14")

finaldata$agesemifine[semifine_u1] <- "<01"
finaldata$agesemifine[semifine_1.9] <- "01-09"
finaldata$agesemifine[semifine_10.14] <- "10-14"
finaldata$agesemifine[semifine_15.19] <- "15-19"
finaldata$agesemifine[semifine_20.24] <- "20-24"
finaldata$agesemifine[semifine_25.49] <- "25-49"
finaldata$agesemifine[semifine_50plus] <- "50+"
finaldata$agesemifine[semifine_incompatable] <- "Not semifine age compatable"


# _____________________________________________________________________________________
#
#  FINE AGE DISAGS (<01, 1-9. 10-14, 15-19, 20-24, 25-29, 30-34, 35-39, 40-49, 50+)
# _____________________________________________________________________________________

fine_u1 <- finaldata$ageasentered %in% c("<01", "<=02 Months", "02 - 12 Months", "<02 Months")
fine_1.9 <- finaldata$ageasentered %in% c("01-09", "01-04", "05-09")
fine_10.14 <- finaldata$ageasentered %in% c("10-14")
fine_15.19 <- finaldata$ageasentered %in% c("15-19", "15-17")
fine_20.24 <- finaldata$ageasentered %in% c("20-24" )
fine_25.29 <- finaldata$ageasentered %in% c("25-29")
fine_30.34 <- finaldata$ageasentered %in% c("30-34")
fine_35.39 <- finaldata$ageasentered %in% c("35-39")
fine_40.49 <- finaldata$ageasentered %in% c("40-49")
fine_50plus <- finaldata$ageasentered %in% c("50+")
fine_incompatable <- finaldata$ageasentered %in% c("15+", "<15", "02 Months - 09 Years", "<10", "25-49", "30-49",
                                                   "18-24", "25+", "<18", "18+", "05-14", "20+", "01-14")

finaldata$agefine[fine_u1] <- "<01"
finaldata$agefine[fine_1.9] <- "01-09"
finaldata$agefine[fine_10.14] <- "10-14"
finaldata$agefine[fine_15.19] <- "15-19"
finaldata$agefine[fine_20.24] <- "20-24"
finaldata$agefine[fine_25.29] <- "25-29"
finaldata$agefine[fine_30.34] <- "30-34"
finaldata$agefine[fine_35.39] <- "35-39"
finaldata$agefine[fine_40.49] <- "40-49"
finaldata$agefine[fine_50plus] <- "50+"
finaldata$agefine[fine_incompatable] <- "Not fine age compatable"


# ___________________________________ 
#
#  VMMC AGE DISAGS (<15, 15-29, 30+)
# ___________________________________ 

vmmc_30plus <- finaldata$ageasentered %in% c("50+", "30-49", "30-34", "35-39", "40-49")
vmmc_15.29 <- finaldata$ageasentered %in% c("15-19","20-24" ,"25-29", "15-17", "18-24")
vmmc_u15 <- finaldata$ageasentered %in% c("<01" , "<15", "01-09", "10-14", "<=02 Months",
                                          "02 - 12 Months", "02 Months - 09 Years", "<02 Months",
                                          "<10", "01-04", "05-09", "05-14", "01-14")
vmmc_incompatable <- finaldata$ageasentered %in% c("<18", "25-49","15+", "25+", "18+", "20+")

finaldata$agevmmc[vmmc_30plus] <- "30+"
finaldata$agevmmc[vmmc_15.29] <- "15-29"
finaldata$agevmmc[vmmc_u15] <- "<15"
finaldata$agevmmc[vmmc_incompatable] <- "Not vmmc age compatable"


rm (coarse_15plus, coarse_u15, coarse_incompatable, semifine_u1, semifine_1.9, semifine_10.14, semifine_15.19, 
    semifine_20.24, semifine_25.49, semifine_50plus, semifine_incompatable, fine_u1, fine_1.9, fine_10.14, fine_15.19,
    fine_20.24, fine_25.29, fine_30.34, fine_35.39, fine_40.49, fine_50plus, fine_incompatable, ovc_18plus, ovc_u18,
    ovc_incompatable, vmmc_30plus, vmmc_15.29, vmmc_u15, vmmc_incompatable)
