# ____________________________________
#
#  RENAME THE HIV TESTING MODALITIES 
# ____________________________________

finaldata$modality <- ifelse(finaldata$modality == "OtherMod", "Other Community",
                             ifelse(finaldata$modality == "IndexMod", "Community Index",
                                    ifelse(finaldata$modality == "VCTMod", "Community VCT",
                                           ifelse(finaldata$modality == "VCT", "VCT",
                                                  ifelse(finaldata$modality == "Voluntary Counseling & Testing standalone", "VCT",
                                                         ifelse(finaldata$modality == "Voluntary Counseling & Testing co-located", "VCT",
                                                                ifelse(finaldata$modality == "VMMC", "VMMC",
                                                                       ifelse(finaldata$modality == "Voluntary Medical Male Circumcision", "VMMC",
                                                                              ifelse(finaldata$modality == "OtherPITC", "Other PITC",
                                                                                     ifelse(finaldata$modality == "Other Service Delivery Point", "Other PITC",
                                                                                            ifelse(finaldata$modality == "Index", "Index",
                                                                                                   ifelse(finaldata$modality == "Index Testing", "Index",
                                                                                                          ifelse(finaldata$modality == "MobileMod", "Community Mobile",
                                                                                                                 ifelse(finaldata$modality == "Mobile", "Community Mobile",
                                                                                                                        ifelse(finaldata$modality == "PMTCT", "PMTCT (ANC)",
                                                                                                                               ifelse(finaldata$modality == "PMTCT ANC", "PMTCT (ANC)",
                                                                                                                                      ifelse(finaldata$modality == "Antenatal Clinic", "PMTCT (ANC)",
                                                                                                                                             ifelse(finaldata$modality == "Pediatric", "Pediatrics",
                                                                                                                                                    ifelse(finaldata$modality == "Pediatrics", "Pediatrics",
                                                                                                                                                           ifelse(finaldata$modality == "Under 5 Clinic", "Pediatrics",
                                                                                                                                                                  ifelse(finaldata$modality == "TBClinic", "TB",
                                                                                                                                                                         ifelse(finaldata$modality == "Tuberculosis","TB",
                                                                                                                                                                                ifelse(finaldata$modality == "Malnutrition", "Malnutrition",
                                                                                                                                                                                       ifelse(finaldata$modality == "Malnutrition facilities", "Malnutrition",
                                                                                                                                                                                              ifelse(finaldata$modality == "STI Clinic", "STI",
                                                                                                                                                                                                     ifelse(finaldata$modality == "Inpat", "Inpatient",
                                                                                                                                                                                                            ifelse(finaldata$modality == "Inpatient", "Inpatient",
                                                                                                                                                                                                                   ifelse(finaldata$modality == "Emergency", "Emergency", 
                                                                                                                                                                                                                          ifelse(finaldata$modality == "Emergency Ward", "Emergency", 
                                                                                                                                                                                                                                 ifelse(finaldata$modality == "HomeMod", "Community Home-Based",
                                                                                                                                                                                                                                        ifelse(finaldata$modality == "Home-based", "Community Home-Based",
                                                                                                                                                                                                                                               ifelse(finaldata$modality == "Outpatient Department", "Outpatient", 
                                                                                                                                                                                                                                                      ifelse(finaldata$modality == "Labor & Delivery", "L&D", 
                                                                                                                                                                                                                                                             ifelse(finaldata$modality == "HIV Care and Treatment Clinic", "Care and Treatment", 
                                                                                                                                                                                                                                                                    ifelse(finaldata$modality == "KeyPop", "Key Populations",
                                                                                                                                                                                                                                                                           "")))))))))))))))))))))))))))))))))))


