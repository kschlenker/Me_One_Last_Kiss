# THIS IS THE CODE FOR CREATING THE TABLEAU_READY STANDARD DATASET
# ALL CODE CAN BE FOUND ON github.com/noahbartlett/Me_One_Last_Kiss

# INSTALL LIBRARIES
devtools::install_github("ICPI/ICPIutilities")
pacman::p_load("tidyverse", "magrittr", "ICPIutilities")

# INCREASE MEMORY
memory.limit(size=56000)

# FILE PATHS
datapath<-"~/GitHub/Me_One_Last_Kiss/Data"
#scriptpath <- "~/GitHub/Me_One_Last_Kiss/R Files"
#setwd(scriptpath)

# LOAD STRUCTURED DATASET
datafile<- "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1.txt"

# YOU NEED TO RUN 01_Consolidate IP Names.R ONLY ONCE TO CREATE THE "CLEAN" DATASET.
# ONCE YOU HAVE RUN IT ONE TIME AND HAVE THE CLEAN FILE, YOU CAN START DIRECTLY WITH 02_FY18Q2Tableau.R

#source("01_Consolidate IP Names.R")
source("R Files/02_FY18Q2Tableau.R")
