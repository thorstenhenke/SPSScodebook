#' @export
generate <- function(x, mode = c("both", "variables", "values"), type = guess_type(x), compact = TRUE) {
    stopifnot(is.data.frame(x))
    m <- match.arg(mode)

    if (m == "variables" || m == "both")
        var_lbl <- variable_lbl(x, type)
    if (m == "values" || m == "both")
        val_lbl <- value_lbl(x, type, compact)

    if (m == "both") {
        r <- merge(var_lbl, val_lbl, by = "item_name")
    }
    else {
        if (!is.null(val_lbl))
            r <- val_lbl
        else
            r <- var_lbl
    }

    rownames(r) <- NULL
    r
}

#' @export
variable_lbl <- function(x, type = guess_type(x)) {
    stopifnot(is.data.frame(x))
    lbl_list <- select_extractor(type, "var")(x)
    data.frame(item_name = names(lbl_list), variable_lbl = unlist(lbl_list))
}


#' @export
value_lbl <- function(x, type = guess_type(x), compact = TRUE) {
    stopifnot(is.data.frame(x))
    lbl_list <- select_extractor(type, "val")(x)
    lbl_list <- lapply(lbl_list, function(x) {
        s <- if (has_names(x)) to_string(x, compact = compact) else ""
    })

    if (compact) {
        lbl <- enframe_list(lbl_list, c("item_name", "value_lbl"))
    } else {
        val_mat <- matrify_list(lbl_list)
        lbl <- data.frame(item_name = names(lbl_list), value_lbl = val_mat)
    }

    lbl
}

