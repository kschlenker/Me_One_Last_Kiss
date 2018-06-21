
fc <- grep("4 Children|4Children", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), fc, "4Children")

aidsfree <- grep("AIDSFREE|AIDS-free|AIDSFree", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), aidsfree, "AIDSFree")

assist <- grep("ASSIST", finaldata$implementingmechanismname)
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), assist, "ASSIST")

challengetb <- finaldata[grep("Challenge TB|CHALLENGE TB", finaldata$implementingmechanismname), ]
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), challengetb, "Challenge TB")

linkages <- finaldata[grep("LINKAGES|Linkages", finaldata$implementingmechanismname), ]
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), linkages, "LINKAGES")

youthpower <- finaldata[grep("Youth Power|YouthPower", finaldata$implementingmechanismname), ]
finaldata$implementingmechanismname <- replace(as.character(finaldata$implementingmechanismname), youthpower, "YouthPower")

m2m <- finaldata[grep("mother2mothers|Mothers 2 Mothers|Mothers to Mothers", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), m2m, "Mothers 2 Mothers")

uspc <- finaldata[grep("Peace Corps", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), uspc, "U.S. Peace Corps")

jsi <- finaldata[grep("John Snow", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), jsi, "John Snow Inc (JSI)")

rtc <- finaldata[grep("Right to Care|Right To Care", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), rtc, "Right To Care, South Africa")

ccrd <- finaldata[grep("Center for Community Health and Development|CENTER FOR COMMUNITY HEALTH RESEARCH AND DEVELOPMENT", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), ccrd, "Center for Community Health Research and Development")

fhi360 <- finaldata[grep("FHI 360|LINKAGES", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), fhi360, "FHI 360")

pact <- finaldata[grep("Pact", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), pact, "Pact")

wvi <- finaldata[grep("World Vision", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), wvi, "World Vision")

psi <- finaldata[grep("Population Services International", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), psi, "Population Services International")

uzsom <- finaldata[grep("University of Zambia", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), uzsom, "University of Zambia School of Medicine")

urc <- finaldata[grep("University Research Corporation|University Research Council", finaldata$primepartner), ]
finaldata$primepartner <- replace(as.character(finaldata$primepartner), urc, "University Research Corporation, LLC")

remove(fc, aidsfree, assist, challengetb, linkages, youthpower, m2m, uspc, jsi, rtc, ccrd, fhi360, pact, wvi, psi, uzsom, urc)





