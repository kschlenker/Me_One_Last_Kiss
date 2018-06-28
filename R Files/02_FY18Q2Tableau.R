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

#replace any NAs with 0
data[is.na(data)] <- 0

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


# ___________________________________
#
#  RESHAPE DATA FOR USE IN TABLEAU
# ___________________________________


# Create three dataframes - Results, Targets and APR - to be combined.

# These are the columns which will be included in Tableau
# This list can be modified as needed.
TableauColumns<-c("operatingunit", "countryname", "snu1", "snu1uid", "psnu", "psnuuid", "snuprioritization", "dreams",
                  "primepartner", "fundingagency", "mechanismid","implementingmechanismname", 
                  "indicator","numeratordenom", "indicatortype","standardizeddisaggregate", 
                  "ageasentered", "agefine", "agesemifine", "agecoarse", "sex","resultstatus","otherdisaggregate","modality", "ismcad")

# Create results dataframe. Only collects quarterly data starting in FY2015Q3
results<- data %>%
  select(TableauColumns, starts_with("fy2")) %>% 
  
  # Columns that will be used in Tableau.
  group_by_at(TableauColumns) %>%
  
  # Creates one values column and one period column (e.g. FY2017Q3)
  summarize_at(vars(starts_with("fy2")), funs(sum(., na.rm=TRUE))) %>%
  ungroup %>%
  gather(period, values, starts_with("fy2")) %>% 
  filter(values !=0)


# Create targets dataframe for FY16 and FY17 targets
targets<- data %>%
  select(TableauColumns, ends_with("targets")) %>% 
  
  # Columns that will be used in Tableau.
  group_by_at(TableauColumns) %>%
  
  # Creates one values column and one period column (e.g. FY2016_Targets)
  summarize_at(vars(starts_with("fy2")), funs(sum(., na.rm=TRUE))) %>%
  ungroup %>%
  gather(period, values, starts_with("fy2")) %>%
  filter(values !=0)

# Create APR dataframe for FY15, FY16, FY17 APR results
apr<- data %>%
  select(TableauColumns, ends_with("apr")) %>% 
  
  # Columns that will be used in Tableau.
  group_by_at(TableauColumns) %>%
  
  # Creates one values column and one period column (e.g. FY2016APR)
  summarize_at(vars(starts_with("fy2")), funs(sum(., na.rm=TRUE))) %>%
  ungroup %>%
  gather(period, values, starts_with("fy2")) %>%
  filter(values !=0)

# Creates a column in each dataframe to label values either Results or Targets
results$ResultsOrTargets<-"Quarterly Results"
targets$ResultsOrTargets<-"Targets"
apr$ResultsOrTargets<-"Annual Results"


# Changes quarters into dates - PART 1 
#     Will change back to quarters in Tableau
#     Why do we have to do this? Because Tableau assumes that Q1 starts in January. 
#     Although you can set Tableau to have fiscal years have an October start, by that 
#     time, Tableau has already assigned the quarterly data to have a January start
#     and your dates will all be off by one quarter. 

results$period<- gsub("fy20", "",results$period)
targets$period<- gsub("fy20", "",targets$period)
apr$period<- gsub("fy20", "",apr$period)
targets$period<- gsub("_targets", "q1",targets$period)
apr$period<- gsub("apr", "q1",apr$period)


# Combines all three dataframes into one
finaldata=bind_rows(results, targets, apr)

# Changes quarters into dates - PART 2
#     YES - I know there are better ways to do this. But this works. And frankly, finding
#     another solution was harder than it should have been. 

finaldata$period[finaldata$period=="17q1"] <- "10/1/2016"
finaldata$period[finaldata$period=="17q2"] <- "1/1/2017"
finaldata$period[finaldata$period=="17q3"] <- "4/1/2017"
finaldata$period[finaldata$period=="17q4"] <- "7/1/2017"
finaldata$period[finaldata$period=="18q1"] <- "10/1/2017"
finaldata$period[finaldata$period=="18q2"] <- "1/1/2018"
#finaldata$period[finaldata$period=="18q3"] <- "4/1/2018"



# RUN "AGE DISAGGREGATION" R CODE
source("03_age_disags.R")


# ____________________ 
#
#  FIX VARIOUS LABELS 
# ____________________ 

finaldata$sex[finaldata$sex == "Unknown Sex"] <- "Unknown"


# RUN "HIV Testing MOdality" R CODE
source("04_HIV_Testing_Modalities.R")

# RUN "Central Mechanisms" R CODE
source("05_central_mechs.R")

# ________________________________________________
#
#  RENAME THE COLUMN HEADINGS FROM ALL LOWERCASE 
# ________________________________________________

names(finaldata)[names(finaldata) == 'operatingunit'] <- 'Operating Unit'
names(finaldata)[names(finaldata) == 'countryname'] <- 'Country'
names(finaldata)[names(finaldata) == 'snu1'] <- 'SNU'
names(finaldata)[names(finaldata) == 'psnu'] <- 'PSNU'
names(finaldata)[names(finaldata) == 'psnuuid'] <- 'PSNU UID'
names(finaldata)[names(finaldata) == 'snu1uid'] <- 'SNU UID'
names(finaldata)[names(finaldata) == 'snuprioritization'] <- 'SNU Prioritization'
names(finaldata)[names(finaldata) == 'dreams'] <- 'DREAMS'
names(finaldata)[names(finaldata) == 'primepartner'] <- 'Prime Partner'
names(finaldata)[names(finaldata) == 'indicatortype'] <- 'Indicator Type'
names(finaldata)[names(finaldata) == 'fundingagency'] <- 'Funding Agency'
names(finaldata)[names(finaldata) == 'implementingmechanismname'] <- 'Implementing Mechanism Name'
names(finaldata)[names(finaldata) == 'numeratordenom'] <- 'Numerator Denom'
names(finaldata)[names(finaldata) == 'standardizeddisaggregate'] <- 'Standardized Disaggregate'
names(finaldata)[names(finaldata) == 'resultstatus'] <- 'Result Status'
names(finaldata)[names(finaldata) == 'otherdisaggregate'] <- 'Other Disaggregate'
names(finaldata)[names(finaldata) == 'ageasentered'] <- 'Age As Entered'
names(finaldata)[names(finaldata) == 'agefine'] <- 'Age Fine'
names(finaldata)[names(finaldata) == 'agesemifine'] <- 'Age Semifine'
names(finaldata)[names(finaldata) == 'agecoarse'] <- 'Age Coarse'
names(finaldata)[names(finaldata) == 'ageovc'] <- 'Age OVC'
names(finaldata)[names(finaldata) == 'agevmmc'] <- 'Age VMMC'




#finaldata$values<-format(finaldata$values, digits=1)
finaldata = mutate_if(finaldata, is.numeric, as.integer)

write_tsv(finaldata, file.path(datapath,"FY18Q2.PSNU.IM.2018.06.14.txt"))

rm(TableauColumns, dreams, apr, results, targets, data, net_new)
