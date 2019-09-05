# Der codebook uatsch kann auhc mal in ein eigenes paket
# Am besten auch noch als shiny app

# was gibbet denn noch so alles in den tibbel dingern???

#' @export
generate <- function(x, mode = c("both", "variables", "values"), compact = TRUE) {
    m <- match.arg(mode)
    if (m == "variables") {
        r <- variable_lbl(x)
    } else if (m == "values") {
        r <- value_lbl(x)
    } else {
        vr <- variable_lbl(x)
        vl <- value_lbl(x)
        r  <- merge(vr, vl, by = "item_name")
    }
    r
}

#' @export
variable_lbl <- function(x) {
    lbl_list <- .extract_attr(x, "label")
    data.frame(item_name = names(lbl_list), variable_lbl = unlist(lbl_list))
}

# Wobei die Werte da auch noch hin müssen
#' @export
value_lbl <- function(x, compact = TRUE) {
    lbl_list <- .extract_attr(x, "labels")
    lbl_list <- lapply(lbl_list, names)
    if (compact) {
        lbl_list <-  lapply(lbl_list, function(x) paste(x, collapse = ", "))
        v <- unlist(lbl_list)
        names(v) <- names(lbl_list)
        df <- data.frame(item_name = names(lbl_list), value_lbl = unlist(lbl_list))
    }  # Spater kann man im else zweig auch noch versuchen da in eine matrix zu bringen.
    df
}

.extract_attr <- function(x, a) {
    stopifnot((a == "label") || (a == "labels"))
    lapply(x, function(cl) {
        lbl <- attributes(cl)[[a]]
        if (is.null(lbl)) {
            return("")
        }
        lbl
    })
}