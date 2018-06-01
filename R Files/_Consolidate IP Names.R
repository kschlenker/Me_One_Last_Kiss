# How to use "rename official" to consolidate IPs and change all their names to the most current version.
# NOTE: You must have the COP matrix report in the same folder. 

library(ICPIutilities)
library(tidyverse)
setwd("C:/Users/nbartlett/Documents/ICPI Data/MER/ICPI FactView 2018.05.15/")

x<- "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1.txt"
wd <- "C:/Users/nbartlett/Documents/ICPI Data/MER/ICPI FactView 2018.05.15/"
df<-read_msd(x,wd)

df <- dplyr::rename_all(df, ~ tolower(.))

df_final<- rename_official(df,wd)
write_tsv(df_final, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1_FV_Clean.txt")

