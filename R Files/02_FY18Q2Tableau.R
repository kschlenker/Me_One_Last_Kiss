##   MAKING THE TABLEAU FILE FROM THE PSNU-IM FACTVIEW
##   Noah Bartlett
##   Date: Decmeber 20, 2017
##   Updated: June 13, 2018


###########
### NOTES
###########

############################################################################################
# Before you run this R code, run the data through the "Consolidate IP Names" code.
############################################################################################


# Import data (Change as needed)
# Uses the PSNU_IM file, already run through the Consolidate IP names code
  data <- read_rds(file.path(datapath, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v2_1_FV_Clean.Rds"))

#########################################################################################
# Select a subset of indicators to be included in the Tableau tool
#########################################################################################

  tokeep <- read_csv("SupportingDocs/ind_to_keep.csv") %>% 
          filter(keep == "X")
  #inner join to keep only rows that match ind/disagg in the tokeep df
  data <- inner_join(data, tokeep)
    rm(tokeep)
  #update some disaggs for continunity
  data <- data %>% 
    filter((standardizeddisaggregate != "Transferred out - non PEPFAR Support Partner" & 
              otherdisaggregate != "Transferred out - non PEPFAR Support Partner")) %>% #duplicates Transferred in FY17
    mutate(standardizeddisaggregate = ifelse(standardizeddisaggregate == "TransferExit", "ProgramStatus", standardizeddisaggregate),
           otherdisaggregate = ifelse(otherdisaggregate %in% c("Transferred out - non PEPFAR Support Partner", "Transferred out - PEPFAR Support Partner"), "Transferred", otherdisaggregate),
           sex = ifelse(indicator == "PMTCT_ART", "Female", sex),
           standardizeddisaggregate = ifelse(indicator %in% c("TB_ART", "TX_TB") & standardizeddisaggregate == "Age Aggregated/Sex", "Age Aggregated/Sex/HIVStatus", standardizeddisaggregate),
           standardizeddisaggregate = ifelse(indicator == "TB_ART" & standardizeddisaggregate == "Age/Sex", "Age/Sex/HIVStatus", standardizeddisaggregate))

  
#########################################################################################
# For non-q4 data, add a YTD column
#########################################################################################

  data <- add_cumulative(data) %>% 
    rename(fy2018apr = fy2018cum)

#generate net new
  data <- combine_netnew(data)

###################################
# Add DREAMS Districts to file
###################################

# List of DREAMS Districts
  dreams<-c(
    # Kenya
    "Homa Bay", "Kisumu", "Nairobi County", "Siaya",
    # Lesotho
    "Berea", "Maseru", 
    # Malawi
    "Machinga District", "Zomba District",
    # Mozambique
    "Chokwe", "Cidade Da Beira", "Cidade De Quelimane", "Cidade De Xai-Xai","Xai-Xai",
    # South Africa
    "gp City of Johannesburg Metropolitan Municipality", "gp Ekurhuleni Metropolitan Municipality",
    "kz eThekwini Metropolitan Municipality", "kz uMgungundlovu District Municipality",
    "kz Umkhanyakude District Municipality",
    # Swaziland
    "Hhohho", "Lubombo", "Manzini" , "Shiselweni", 
    # Tanzania
    "Kahama DC", "Kahama TC", "Kyela DC","Mbeya CC","Msalala DC","Shinyanga MC","Temeke MC","Ushetu DC",
    # Uganda
    "Bukomansimbi District", "Gomba District", "Gulu District", "Lira District", "Mityana District",
    "Mubende District", "Mukono District", "Oyam District", "Rakai District", "Sembabule District",
    # Zambia
    "Chingola District", "Lusaka Urban District", "Ndola District", 
    # Zimbabwe
    "Bulawayo", "Chipinge", "Gweru" , "Makoni", "Mazowe", "Mutare")

  
# Creates a TRUE/FALSE column if PSNU is listed above as a DREAMS district
  data$dreams <- data$psnu %in% dreams
  
  rm(dreams)

# ___________________________________
#
#  RESHAPE DATA FOR USE IN TABLEAU
# ___________________________________

  TableauColumns<-c("operatingunit", "countryname", "snu1", "snu1uid", "psnu", "psnuuid", "snuprioritization", "dreams",
                    "primepartner", "fundingagency", "mechanismid","implementingmechanismname", 
                    "indicator","numeratordenom", "indicatortype","standardizeddisaggregate", 
                    "ageasentered", "agefine", "agesemifine", "agecoarse", "sex","resultstatus","otherdisaggregate",
                    "modality", "ismcad")

# reshape long separately due to file size
  source(file.path("R Files", "06_reshape_long.R"))
  results <- reshape_long(data, "results")
  apr <- reshape_long(data, "apr")
  targets <- reshape_long(data, "targets")
#bind together 
  data_long <- bind_rows(results, apr, targets)
    rm(results, apr, targets, data, TableauColumns)
  
  data_long <- data_long %>%
    mutate(resultsortargets = case_when(str_detect(period, "q\\d$") ~ "Quarterly Results",
                                        str_detect(period, "apr$")    ~ "Annual Results",
                                        str_detect(period, "targets$") ~ "Targets"),
           period = str_remove(period, "fy20"),
           period = str_replace(period, "_targets|apr", "q1"),
           results = ifelse(resultsortargets == "Quarterly Results", values, NA),
           apr = ifelse(resultsortargets == "Annual Results", values, NA),
           targets = ifelse(resultsortargets == "Targets", values, NA))
  #replace all zeros with NA  
  data_long[data_long == 0] <- NA

# Changes quarters into dates
  finaldata <- data_long %>% 
    mutate(period = yq(period)  %m-% months(3))

  rm(data_long)
  
# vmmc age bands variable
  finaldata <- finaldata %>% 
    mutate(agevmmc = case_when(ageasentered %in% c("30-49", "30-34", "35-39", "40-49", "50+")               ~ "30+",
                               ageasentered %in% c("15-19","20-24" ,"25-29")                                ~ "15-29",
                               ageasentered %in% c("<01", "<02 Months", "02 - 12 Months", "01-09","10-14")  ~ "<15",
                               TRUE                                                                         ~ "Not vmmc age compatable")
    )


# ____________________ 
#
#  FIX VARIOUS LABELS 
# ____________________ 

  finaldata <- finaldata %>% 
    mutate(sex = ifelse(sex == "Unknown Sex", "Unknown", sex))

# adjust modality names
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
  

# RUN "Central Mechanisms" R CODE
  source(file.path("R Files","05_central_mechs.R"))

#convert numbers to integers
  finaldata <- mutate_if(finaldata, is.numeric, as.integer)
  
#rename to upper case for Tableau
  finaldata <- finaldata %>% 
    rename(`PSNU`  = psnu,
           `PSNU UID`  = psnuuid,
           `SNU UID`  = snu1uid,
           `SNU Prioritization`  = snuprioritization,
           `DREAMS`  = dreams,
           `Prime Partner`  = primepartner,
           `Indicator Type`  = indicatortype,
           `Funding Agency`  = fundingagency,
           `Implementing Mechanism Name`  = implementingmechanismname,
           `Numerator Denom`  = numeratordenom,
           `Standardized Disaggregate`  = standardizeddisaggregate,
           `Result Status`  = resultstatus,
           `Other Disaggregate`  = otherdisaggregate,
           `Age As Entered`  = ageasentered,
           `Age Fine`  = agefine,
           `Age Semifine`  = agesemifine,
           `Age Coarse`  = agecoarse,
           `Age VMMC`  = agevmmc)

#export
  write_tsv(finaldata, file.path(datapath,paste0("FY18Q2.PSNU.IM.", Sys.Date(),".txt")))

rm(TableauColumns, dreams, data, finaldata)
