# Conversion functions
## String related
# Better name stringify_vec
to_string <- function(x, compact = TRUE) {
    s <- paste(names(x), x, sep = " = ")
    if (compact) {
        s <- paste(s, collapse = ', ')
    }
    s
}

str_trim <- function(s, mode = c('both', 'left', 'right')) {
    mode <- match.arg(mode)
    if (mode == 'left' || mode == 'both')
        s <- gsub('^ +', '', s)
    if (mode == 'right' || mode == 'both')
        s <- gsub(' +$', '', s)
    s
}

## Other datatypes
enframe_list <- function(l, col_names = c("item_name", "item")) {
    stopifnot(length(col_names) == 2)
    df <- data.frame(item_name = names(l), item = unlist(l), stringsAsFactors = FALSE)
    names(df) <- col_names
    df
}

matrify_list <- function(listoflist) {
    max_n <- max(sapply(listoflist, length))
    v_templ <- character(max_n)
    listofvec <- lapply(listoflist, function(v) {
        v_templ[1:length(v)] <- v
        v_templ
    })
    do.call("rbind", listofvec)
}

# Better name return_named
make_named <- function(v, n) {
    names(v) <- n
    return(v)
}

# -------------------
# Proposition testers
has_names <- function(v) {
    !is.null(names(v))
}

has_attribute <- function(x, a) {
    UseMethod("has_attribute")
}

has_attribute.data.frame <- function(x, a) {
    has_attribute.default(x, a) || any(sapply(x, has_attribute.default, a = a))
}

has_attribute.default <- function(x, a) {
    !is.null(attr(x, a, exact = TRUE))
}
