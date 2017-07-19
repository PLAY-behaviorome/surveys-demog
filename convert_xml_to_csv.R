# convert_xml_to_csv.R
#
# Converts the XML outputs from the PLAY app to individual
# CSV files. It then reimports the CSV files and creates a 
# merged data frame that may be used for QA and visualization
#
#--------------------------------------------------------------

xml_path <- "~/Box Sync/play-demog-data-from-app-pilots/data/xml/"
csv_path = "data/csv/"
extract_sub_id <- function(fn) {
  require("XML")
  # Easier to deal with data frame
  df <- xmlToDataFrame(xmlRoot(xmlParse(fn))[[4]])
  site <- df[2,]
  id <- df[3,]
  site_id <- paste0(site, "-", id)
}

convert_xml_to_csv <- function(xml_fn, csv_path = "data/csv/") {
  require("XML")
  xml_file <- xmlParse(file = xml_fn)
  
  # Extract as list, flatten, then transpose
  # to make cols variable names
  # This results in long variable names, but preserves data
  # and is also easier to understand.
  # Parsing XML trees is hard (for me; now)
  d <- t(unlist(xmlToList(xml_file)))
  
  write.csv(x = d, paste0(csv_path, extract_sub_id(xml_fn), ".csv"), row.names = FALSE)
}

# Generate list of XML files from Box (temporary fix)
xml_list <- list.files(xml_path, pattern = "\\.xml$", full.names = TRUE)
lapply(xml_list, convert_xml_to_csv)

# Merge CSVs to check errors; need full.names = TRUE to avoid 
# keeping track of working directory
csv_list <- lapply(list.files(path = csv_path, pattern = "\\.csv$", full.names = TRUE), read.csv)
play_survey <- Reduce(function(x,y) merge(x, y, all=TRUE), csv_list)
