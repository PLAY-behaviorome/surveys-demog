# rename_app_files
#
# Renames the app export files with the assigned participant ID

data_dir <- "~/Box Sync/play-demog-data-from-app-pilots/data/xml/"

xml_files <- list.files(path = data_dir, pattern = "\\.xml$", full.names = TRUE)

extract_sub_id <- function(fn) {
  require("XML")
  # Easier to deal with data frame
  df <- xmlToDataFrame(xmlRoot(xmlParse(fn))[[4]])
  site <- df[2,]
  id <- df[3,]
  site_id <- paste0(site, "-", id, ".xml")
}

make_new_fname <- function(fn) {
  file.path(dirname(fn), extract_sub_id(fn))
}

mapply(file.copy, xml_files, lapply(xml_files, make_new_fname))
