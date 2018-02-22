# execute before devtools::load_all(".")
first_info <- sessionInfo()

devtools::use_data(first_info, internal = FALSE, overwrite = TRUE)

library(devtools)
library(rlang)
load_all(".")
last_info <- sessionInfo()

devtools::use_data(last_info, internal = FALSE, overwrite = TRUE)
