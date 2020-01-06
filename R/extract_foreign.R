extract_foreign_var <- function(df) {
    attributes(df)[["variable.labels"]]
}

extract_foreign_val <- function(df) {
    lapply(df, function(cl) {
        a <- attributes(cl)[["value.labels"]]
        if (is.null(a)) "" else a
    })
}