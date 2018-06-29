#convert specified data type (results/targets/apr) to long

reshape_long <- function(df, type){
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

  df <- df %>%
    select(TableauColumns, cols) %>% 
    group_by_at(TableauColumns) %>%
    summarize_at(vars(starts_with("fy2")), funs(sum(., na.rm=TRUE))) %>%
    ungroup %>%
    gather(period, values, starts_with("fy2")) %>%
    filter(values !=0)
}

