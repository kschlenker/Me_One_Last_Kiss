# ____________________________________
#
#  RENAME THE HIV TESTING MODALITIES 
# ____________________________________

finaldata <- finaldata %>% 
  mutate(modality = case_when(modality == "OtherMod"                                                 ~ "Other Community",
                               modality == "IndexMod"                                                 ~ "Community Index",
                               modality == "VCTMod"                                                   ~ "Community VCT",
                               modality %in% c("HomeMod", "Home-based")                               ~ "Community Home-Based",
                               modality %in% c("MobileMod", "Mobile")                                 ~ "Community Mobile",
                               modality %in% c("VCT", "Voluntary Counseling & Testing standalone", 
                                               "Voluntary Counseling & Testing co-located")           ~ "VCT",
                               modality %in% c("VMMC", "Voluntary Medical Male Circumcision")         ~ "VMMC",
                               modality %in% c("Other PITC", "OtherPITC", "Other Service Delivery Point")           ~ "Other PITC",
                               modality %in% c("Index", "Index Testing")                              ~ "Index",
                               modality %in% c("PMTCT", "PMTCT ANC", "Antenatal Clinic")              ~ "PMTCT (ANC)",
                               modality %in% c("Pediatric", "Pediatrics","Under 5 Clinic")            ~ "Pediatrics",
                               modality %in% c("TBClinic", "Tuberculosis")                            ~ "TB",
                               modality %in% c("Malnutrition", "Malnutrition facilities")             ~ "Malnutrition",
                               modality == "STI Clinic"                                               ~ "STI",
                               modality %in% c("Inpat", "Inpatient")                                  ~ "Inpatient",
                               modality %in% c("Emergency", "Emergency Ward")                         ~ "Emergency",
                               modality == "Outpatient Department"                                    ~ "Outpatient",
                               modality == "Labor & Delivery"                                         ~ "L&D",
                               modality == "HIV Care and Treatment Clinic"                            ~ "Care and Treatment",
                               modality == "KeyPop"                                                   ~ "Key Populations"
  )) 

