# How to use "rename official" to consolidate IPs and change all their names to the most current version.
# NOTE: You must have the COP matrix report in the same folder. 


df<-read_msd(datafile,datapath)

df <- dplyr::rename_all(df, ~ tolower(.))

df_final<- rename_official(df,datapath)
write_tsv(df_final, file.path(datapath, "ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1_FV_Clean.txt"))

rm(df, df_final)