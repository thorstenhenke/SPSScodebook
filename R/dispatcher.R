select_extractor <- function(df_type, v_type) {
    stopifnot(v_type %in% c('var', 'val'))
    match.fun(paste0('extract_', df_type, '_', v_type))
}

guess_type <- function(x) {
    if ('tbl_df' %in% class(x)) return("haven")
    if (has_attribute(x, 'value.labels')) return("foreign")
    return("generic")
}
