library(dplyr)
library(readr)
library(readxl)
library(stringr)

source("./R/bkg_geocode_single_address.R")
source("./R/bkg_geocode.R")

KVRLP_Impfpraxen_fuer_FremdpatientInnen <-
  readxl::read_excel("./data/KVRLP_Impfpraxen_fuer_FremdpatientInnen.xlsx")

KVRLP_Impfpraxen_fuer_FremdpatientInnen_geocoded <-
  KVRLP_Impfpraxen_fuer_FremdpatientInnen %>%
  dplyr::mutate(
    street = stringr::str_extract(Straße, "([A-zäüöß])+"),
    house_number = stringr::str_extract(Straße, "[0-9]+[a-z]*")
  ) %>%
  bkg_geocode(
    street = "street",
    house_number = "house_number",
    zip_code = "PLZ",
    place = "Ort"
  )

readr::write_rds(
  KVRLP_Impfpraxen_fuer_FremdpatientInnen_geocoded,
  "./data/KVRLP_Impfpraxen_fuer_FremdpatientInnen_geocoded.rds"
  )

