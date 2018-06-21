
fc <- grep("4 Children|4Children", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), fc, "4Children")

aidsfree <- grep("AIDSFREE|AIDS-free|AIDSFree", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), aidsfree, "AIDSFree")

assist <- grep("ASSIST", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), assist, "ASSIST")

challengetb <- grep("Challenge TB|CHALLENGE TB", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), challengetb, "Challenge TB")

linkages <- grep("LINKAGES|Linkages", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), linkages, "LINKAGES")

youthpower <- grep("Youth Power|YouthPower", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), youthpower, "YouthPower")

m2m <- grep("mother2mothers|Mothers 2 Mothers|Mothers to Mothers", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), m2m, "Mothers 2 Mothers")

uspc <- grep("Peace Corps", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), uspc, "U.S. Peace Corps")

jsi <- grep("John Snow", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), jsi, "John Snow Inc (JSI)")

rtc <- grep("Right to Care|Right To Care", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), rtc, "Right To Care, South Africa")

ccrd <- grep("Center for Community Health and Development|CENTER FOR COMMUNITY HEALTH RESEARCH AND DEVELOPMENT", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), ccrd, "Center for Community Health Research and Development")

fhi360 <- grep("FHI 360|LINKAGES", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), fhi360, "FHI 360")

pact <- grep("Pact", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), pact, "Pact")

wvi <- grep("World Vision", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), wvi, "World Vision")

psi <- grep("Population Services International", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), psi, "Population Services International")

uzsom <- grep("University of Zambia", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), uzsom, "University of Zambia School of Medicine")

urc <- grep("University Research Corporation|University Research Council", finaldata$primepartner)
finaldata$primepartner <- replace(as.character(finaldata$primepartner), urc, "University Research Corporation, LLC")

rm(fc, aidsfree, assist, challengetb, linkages, youthpower, m2m, uspc, jsi, rtc, ccrd, fhi360, pact, wvi, psi, uzsom, urc)