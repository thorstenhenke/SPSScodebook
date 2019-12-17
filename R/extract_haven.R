extract_haven_var <- function(df) {
    lapply(df, function(cl) {
        a <- attributes(cl)[["label"]]
        if (is.null(a)) "" else a
    })
}

extract_haven_val <- function(df) {
    lapply(df, function(cl) {
        a <- attributes(cl)[["labels"]]
        if (is.null(a)) "" else a
    })
}
