# surveys-demog
Demographic and survey data from the PLAY project pilot participants.

## Contents

- `*.R` files
    - `rename_app_files.R`: renames the file names exported by the app into names that use the `<site>-<sub-id>.xml` format.
    - `convert_xml_to_csv.R`: imports and converts the renamed XML files into very wide CSVs with a `<site>-<sub-id>.csv` format. This also generates a merged data frame from all of the exported CSVs that can be used to check and visualize the data. As a practical matter, the individual CSVs and XML files will be manually copied to their appropriate session folder on Databrary so that no sensitive data is shared accidentally via GitHub.
- `tablet_app_metadata.{.md, .Rmd}`: summarizes Rick Gilmore's initial explorations of the `XML` package and what variables are stored where in the app's file hierarchy.
