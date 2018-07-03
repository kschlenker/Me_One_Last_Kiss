# __________________________________________________________________
#
#  -------------------------  AGE DISAGS  ------------------------- 
# __________________________________________________________________

finaldata <- finaldata %>% 
  #clearn out current MSD age disaggs
  mutate_at(vars(agecoarse, agesemifine, agefine), ~ NA)


# ___________________________________________________
#
#  COARSE AGE DISAGS (<15, 15+) 
#           FOR OVC: (<18, 18+)
# ___________________________________________________


finaldata <- finaldata %>% 
  mutate(agecoarse = case_when((indicator == "OVC_SERV" && 
                                   finaldata$ageasentered %in% c("20-24" , "25-49", "50+", "25-29", 
                                                                 "30-49", "18-24", "25+", "30-34", 
                                                                 "35-39", "40-49", "18+", "20+"))       ~ "18+",
                                (indicator == "OVC_SERV" && 
                                   finaldata$ageasentered %in% c("<01" , "<15", "01-09", "10-14", 
                                                                 "<=02 Months", "02 - 12 Months", 
                                                                 "02 Months - 09 Years", "<02 Months",
                                                                 "<10", "01-04", "05-09", "05-14", 
                                                                 "01-14", "15-17", "<18"))              ~ "<18",
                                (indicator == "OVC_SERV" && 
                                   finaldata$ageasentered %in% c("15+", "15-19"))                       ~ "Not coarse age compatable",
                                ageasentered %in% c("20-24" , "25-49", "15+", "50+", "15-19", 
                                                    "25-29", "30-49", "15-17", "18-24", "25+",
                                                    "30-34", "35-39", "40-49", "18+", "20+")          ~ "15+",
                                ageasentered %in% c("<01" , "<15", "01-09", "10-14", 
                                                    "<=02 Months", "02 - 12 Months", 
                                                    "02 Months - 09 Years", "<02 Months",
                                                    "<10", "01-04", "05-09", "05-14", "01-14")        ~ "<15")
  )


# __________________________________________________________________
#
#  SEMIFINE AGE DISAGS (<01, 1-9. 10-14, 15-19, 20-24, 25-49, 50+)
# __________________________________________________________________


finaldata <- finaldata %>% 
  mutate(agesemifine = case_when(ageasentered %in% c("<01", "<=02 Months", "02 - 12 Months", "<02 Months")  ~ "<01",
                                 ageasentered %in% c("01-09", "01-04", "05-09")                             ~ "01-09",
                                 ageasentered %in% c("10-14", "20-24", "50+")                               ~ ageasentered,
                                 ageasentered %in% c("15-19", "15-17")                                      ~ "15-19",
                                 ageasentered %in% c("25-49", "25-29", "30-49", "30-34", "35-39", "40-49")  ~ "25-49",
                                 ageasentered %in% c("15+", "<15", "02 Months - 09 Years", "<10", 
                                                     "18-24", "25+", "<18", "18+", "05-14", "20+", "01-14") ~ "Not semifine age compatable"))



# _____________________________________________________________________________________
#
#  FINE AGE DISAGS (<01, 1-9. 10-14, 15-19, 20-24, 25-29, 30-34, 35-39, 40-49, 50+)
# _____________________________________________________________________________________


finaldata <- finaldata %>% 
  mutate(agefine = case_when(ageasentered %in% c("<01", "<=02 Months", "02 - 12 Months", "<02 Months")          ~ "<01",
                             ageasentered %in% c("01-09", "01-04", "05-09")                                     ~ "01-09",
                             ageasentered %in% c("15-19", "15-17")                                              ~ "15-19",
                             ageasentered %in% c("10-14", "20-24", "25-29", "30-34", "35-39", "40-49", "50+")   ~ ageasentered,
                             ageasentered %in% c("15+", "<15", "02 Months - 09 Years", "<10", "25-49", "30-49", 
                                                 "18-24", "25+", "<18", "18+", "05-14", "20+", "01-14")         ~ "Not fine age compatable")
         )


# ___________________________________ 
#
#  VMMC AGE DISAGS (<15, 15-29, 30+)
# ___________________________________ 

finaldata <- finaldata %>% 
  mutate(agevmmc = case_when(ageasentered %in% c("30-49", "30-34", "35-39", "40-49", "50+")               ~ "30+",
                             ageasentered %in% c("15-19","20-24" ,"25-29")                                ~ "15-29",
                             ageasentered %in% c("<01", "<02 Months", "02 - 12 Months", "01-09","10-14")  ~ "<15",
                             TRUE                                                                         ~ "Not vmmc age compatable")
         )
    

