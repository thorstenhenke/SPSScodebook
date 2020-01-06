
# SPSScodebook

One of the compelling features of SPSS sav data format is the ability to store  additional information on the variables and their respective values directly in the SPSS data file. To have access to these information you usually need an SPSS installation, which on the  one hand requires a licence and on the other is an additional program the user has to open. The  To access these information from within  the R environment a collection of lean procedures  is provided that simplyfies the process of variable and value label extraction from a SPSS  data set. Addtionaly the procedures are written in such a way that functionality for new  packages can be added dynamically. 

## Installation

You can install the developement version of SPSScodebook directly from github [GitHub](https://github.com/thorstenhenke/SPSScodebook/) with:

``` r
devtools::install_github("https://github.com/thorstenhenke/SPSScodebook")
```

## Example

To generate the Codebook you first have to read in the data. Currently you can either use the foreign package or the haven package for this job. If you go with the first option please enable the use of vaue labels as shown below. Without this option set to true there is no way to link 

``` r
library(foreign)
library(haven)

p <- "Path to your dataset"

foreign_lbl_df <- foreign::read.spss(p, use.value.labels = T, to.data.frame = T, stringsAsFactors = F)
foreign_raw_df <- foreign::read.spss(p, use.value.labels = F, to.data.frame = T, stringsAsFactors = F)
haven_df <- haven::read_spss(p)
```

Now you can generate a table with the dataset's value variable and value descriptions displayed as a table; like in good old SPSS. Of course this table can later be exportet to excel, csv, etc. 

``` r
library(SPSScodebook)

haven_tbl <- SPSScodebook::generate(haven_df)
foreign_raw_tbl <- SPSScodebook::generate(foreign_raw_df)  # Will prompt a warning message
foreign_lbl_tbl <- SPSScodebook::generate(foreign_lbl_df)

```

# Developement

This package currently suppports datasets that were read in by the foreign package or the haven package. However, other packages can easily be integrated by the following steps: 

1. Edit the guess_type() function in R/dispatcher.R The if clause should contain some kind of fingerprint to uniquely identify your dataset among the other options. The return statment can be freely chosen, although idealy it should be the name of you readin package/routine. 

2. Add a file called extract_<name-from-return-statment>.R

3. Within this file add two functions: (1) extract\_<name-from-return-statment>\_var and (2) extract\_<name-from-return-statment>\_val.

    - extract_<name-from-return-statment>_var should return a named vector, where the vector's names correspond to the variable names and the vector's actual content is the variables' description. 

    - extract_<name-from-return-statment>_val should return a named list of named vectors, where the lists's names correspond to the variable names. The named vectors contain the individual value codings and their corresponding labels. The labels should be stored in the names, where the values should be stored in the actual values. 

