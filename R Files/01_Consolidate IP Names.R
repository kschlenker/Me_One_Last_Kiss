##   DEVELOP A STARTING DATAFILE TO WORK FROM
##   Aaron Chafetz, Noah Bartlett
##   Date: Decmeber 20, 2017
##   Updated: June 28, 2018

#import MSD and convert to RDS format to consolidate space
  df<-read_msd(file.path(datapath,datafile))

#import Archived MSD for TX_NET_NEW Calculation (need FY16Q4 to calc NET NEW in FY17Q1)
  df_tx_old <- read_msd(file.path(datapath,datafile_archive), save_rds = FALSE) %>% 
    filter(indicator == "TX_CURR")
  
#limit just to just meta data (string vars), excluding partner/mech and other UIDs that may lead to misalignment in merge
  lst_meta <- df_tx_old %>% 
    select(-c(dataelementuid, categoryoptioncombouid)) %>% 
    select_if(is.character) %>% 
    names()
  df_tx_old <- select(df_tx_old, lst_meta, fy2016q4)
  
  df_tx_old <- df_tx_old %>% 
    group_by_if(is.character) %>% 
    summarise(fy2016q4 = sum(fy2016q4, na.rm = TRUE)) %>% 
    ungroup() %>% 
    filter(fy2016q4 != 0)
  
#join archive data onto current dataset
  df_merge <- full_join(df, df_tx_old)
  
#reorder so FY16Q4 comes before FY17
  lst_meta <- df_merge %>% 
    select_if(is.character) %>% 
    names()
  df_merge <- select(df_merge, lst_meta, fy2016q4, everything())

#apply "offical" names to partners/implementing mechs
  df_final<- rename_official(df)

#export as RDS
  write_rds(df_final, file.path(datapath, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v2_1_FV_Clean.rds"), compress = "gz")

rm(df, df_final, df_tx_old, df_merge, lst_meta)
