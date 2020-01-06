extract_generic_var <- function(df) {
    attributes(df)[["variable.labels"]]
}

extract_generic_val <- function(df) {
    warning("The codes presented here might not be equivivalent with the codes used in SPSS. Please consider reading in the data via the haven package. This will most likely provide you an acurate representaion of the original datset. Alternetively please consider using the <> function.")
    lapply(df, function(v) {
        if (!is.factor(v)) return("")
        l <- str_trim(levels(v))
        i <- seq_along(l)
        make_named(v = i, n = l)
    })
}
