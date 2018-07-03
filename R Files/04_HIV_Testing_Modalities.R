# ____________________________________
#
#  RENAME THE HIV TESTING MODALITIES 
# ____________________________________

finaldata <- finaldata %>% 
  mutate(modality = case_when(modality == "Emergency Ward"                     ~ "Emergency",
                              modality == "HomeMod"                            ~ "Community Home-Based",
                              modality == "IndexMod"                           ~ "Community Index",
                              modality == "Inpat"                              ~ "Inpatient",
                              modality == "MobileMod"                          ~ "Community Mobile",
                              modality == "OtherMod"                           ~ "Other Community",
                              modality == "OtherPITC"                          ~ "Other PITC",
                              modality == "PMTCT ANC"                          ~ "PMTCT (ANC)",
                              modality == "STI Clinic"                         ~ "STI",
                              modality == "TBClinic"                           ~ "TB",
                              modality == "VCTMod"                             ~ "Community VCT",
                              modality %in% c("Index" , "Malnutrition", 
                                              "Pediatric", "VCT", "VMMC")      ~ modality)
  ) 
