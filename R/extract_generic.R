extract_generic_var <- function(df) {
    attributes(df)[["variable.labels"]]
}

# Man kan aber auch noch eine funktion die die richitgen coderiungen
# errät.

extract_generic_val <- function(df) {
    warning("The codes presented here might not be equivivalent with the codes used in
            SPSS. Please condider reading in the data via the haven package. This will
            most likely provide you an acurate representaion of the original datset.
            Alternetively please consider using the <> function.")
    function(v) {
        if (!is.factor(v)) return("")
        if (is.factor(v)) {
            l <- levels(v)
            i <- seq_along(l)
            names(i) <- l

        }
    }
}
