######################

fourchildren <- finaldata$implementingmechanismname %in% c("Coordinating Comprehensive Care for Children (4Children)", 
                                                           "4Children", "4Children â???" Coordinating Comprehensive Care for Children", 
                                                           "4 Children (Coordinating Comprehensive Care for Children)", "4 Children")

finaldata$implementingmechanismname[fourchildren] <- "4Children"

######################

aidsfree <- finaldata$implementingmechanismname %in% c("AIDSFREE", "AIDS-free Malawi",
                                                       "Strengthening High Impact Interventions for an AIDS-Free Generation (AIDSFree) Project",
                                                       "AIDSFree", "AIDSFree ZAMBIA")

finaldata$implementingmechanismname[aidsfree] <- "AIDSFree"

######################

assist <- finaldata$implementingmechanismname %in% c("ASSIST", "Applying Science to Strengthen and Improve Systems (ASSIST)",
                                                     "ASSIST (former Health Care Improvement) Project",
                                                     "Applying Science to Strengthen and Improve Systems (ASSIST) Project")

finaldata$implementingmechanismname[assist] <- "ASSIST"

######################

challengetb <- finaldata$implementingmechanismname %in% c("Challenge TB", "Challenge TB Fund", "CHALLENGE TB")
 
finaldata$implementingmechanismname[challengetb] <- "Challenge TB"

######################

linkages <- finaldata$implementingmechanismname %in% c("LINKAGES", "Linkages Across the Continuum of HIV Services for Key Populations Affected by HIV (LINKAGES) Project",
                                                       "Strengthening services for key populations/LINKAGES", "Linkages",
                                                       "Linkages Across the Continuum of HIV Services for Key Populations Affected by HIV (Linkages)",
                                                       "FHI 360 Linkages for Care")

finaldata$implementingmechanismname[linkages] <- "LINKAGES"

######################

youthpower <- finaldata$implementingmechanismname %in% c("Youth Power", "YouthPower Implementation -  Task Order 1", 
                                                         "Youth Power Action")

finaldata$implementingmechanismname[youthpower] <- "YouthPower"

######################
######################
######################

m2m <- finaldata$primepartner %in% c("mother2mothers organisation", "Mothers 2 Mothers", "Mothers to Mothers (M2M)")

finaldata$primepartner[m2m] <- "Mothers 2 Mothers"

######################

uspc <- finaldata$primepartner %in% c("Peace Corps  Volunteers", "U.S. Peace Corps")

finaldata$primepartner[uspc] <- "U.S. Peace Corps"

######################

jsi <- finaldata$primepartner %in% c("John Snow Inc (JSI)", "John Snow, Inc.")

finaldata$primepartner[jsi] <- "John Snow Inc (JSI)"

######################

rtc <- finaldata$primepartner %in% c("Right to Care", "Right To Care, South Africa")

finaldata$primepartner[rtc] <- "Right To Care, South Africa"

######################

ccrd <- finaldata$primepartner %in% c("Center for Community Health and Development", 
                                      "CENTER FOR COMMUNITY HEALTH RESEARCH AND DEVELOPMENT")

finaldata$primepartner[ccrd] <- "Center for Community Health Research and Development"

######################

fhi360 <- finaldata$primepartner %in% c("FHI 360", "LINKAGES")

finaldata$primepartner[fhi360] <- "FHI 360"

######################

pact <- finaldata$primepartner %in% c("Pact", "Pact, Inc.")

finaldata$primepartner[pact] <- "Pact"

######################

wvi <- finaldata$primepartner %in% c("World Vision", "World Vision International")

finaldata$primepartner[wvi] <- "World Vision"

######################

psi <- finaldata$primepartner %in% c("Population Services International", 
                                     "Population Services International/Society for Family Health")

finaldata$primepartner[psi] <- "Population Services International"

######################

uzsom <- finaldata$primepartner %in% c("University of Zambia School of Medicine", "University of Zambia")

finaldata$primepartner[uzsom] <- "University of Zambia School of Medicine"

######################

urc <- finaldata$primepartner %in% c("University Research Corporation, LLC", "University Research Council")

finaldata$primepartner[urc] <- "University Research Corporation, LLC"

######################
