# How to use "rename official" to consolidate IPs and change all their names to the most current version.


df<-read_msd(file.path(datapath,datafile))

#df <- dplyr::rename_all(df, ~ tolower(.)) #default with read_msd

df_final<- rename_official(df)
write_rds(df_final, file.path(datapath, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1_FV_Clean.rds"))

rm(df, df_final)