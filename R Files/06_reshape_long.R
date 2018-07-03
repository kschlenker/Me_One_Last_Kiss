#convert specified data type (results/targets/apr) to long

reshape_long <- function(df, type){
  #identify value columsn to pull
    if(type == "apr" || type == "targets") {
      cols <- df %>% 
        select(ends_with(type)) %>% 
        names()
    } else if (type == "results") {
      cols <- df %>% 
        select(contains("q")) %>% 
        names()
    } else
      stop("type is not correctly specified")
  
  #keep string columns already filtered
    lst_meta <- df %>%
      dplyr::select_if(is.character) %>%
      names()
    
  #aggregate and convert to long
    df <- df %>%
      group_by_at(lst_meta) %>%
      summarize_at(vars(starts_with("fy2")), funs(sum(., na.rm=TRUE))) %>%
      ungroup %>%
      gather(period, values, starts_with("fy2")) %>%
      filter(values !=0)
}

