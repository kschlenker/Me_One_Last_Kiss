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
  data <- read_rds(file.path(datapath, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1_FV_Clean.rds"))

#########################################################################################
# Select a subset of indicators to be included in the Tableau tool
#########################################################################################

  data <- data %>% 
    filter(indicator %in% c("GEND_GBV", "HRH_PRE", "HTS_SELF", "HTS_TST",
                            "HTS_TST_NEG", "HTS_TST_POS", "KP_MAT", "KP_PREV",
                            "OVC_SERV", "OVC_SERV_OVER_18", "OVC_SERV_UNDER_18", 
                            "PMTCT_ART", "PMTCT_EID", "PMTCT_EID_Less_Equal_Two_Months",
                            "PMTCT_EID_Two_Twelve_Months","PMTCT_EID_POS", "PMTCT_STAT", 
                            "PMTCT_STAT_KnownatEntry_POSITIVE" , "PMTCT_STAT_NewlyIdentified_Negative", 
                            "PMTCT_STAT_NewlyIdentified_POSITIVE", "PMTCT_STAT_POS", "PP_PREV",
                            "PrEP_NEW", "TB_ART", "TB_STAT", "TX_CURR", "TX_NEW", "TX_PVLS",
                            "TX_RET", "TX_TB", "VMMC_CIRC")) 

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
  
# RUN "AGE DISAGGREGATION" R CODE
  source(file.path("R Files", "03_age_disags.R"))


# ____________________ 
#
#  FIX VARIOUS LABELS 
# ____________________ 

  finaldata$sex[finaldata$sex == "Unknown Sex"] <- "Unknown"


# RUN "HIV Testing MOdality" R CODE
  source(file.path("R Files","04_HIV_Testing_Modalities.R"))

# RUN "Central Mechanisms" R CODE
  source(file.path("R Files","05_central_mechs.R"))

#convert numbers to integers
  finaldata <- mutate_if(finaldata, is.numeric, as.integer)
  
#rename to upper case for Tableau
  finaldata <- rename(`PSNU`  = psnu,
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
                      `Age OVC`  = ageovc,
                      `Age VMMC`  = agevmmc)

#export
  write_tsv(finaldata, file.path(datapath,"FY18Q2.PSNU.IM.2018.06.14.txt"))

rm(TableauColumns, dreams, data, finaldata)
