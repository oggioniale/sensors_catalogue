library(magrittr)
sensors_Catalogue <- function(csv_path = NULL) {
  # read csv file ----
  csv_file <- vroom::vroom(csv_path, ",", escape_double = FALSE, trim_ws = TRUE)
  # lines concerning examples, units of measurement and data types are removed ----
  # csv_file <- csv_file[c(-1:10),]
  # if only example sensor ----
  csv_file <- csv_file[c(-1, -2),]
  # delete row without sensor or components info ----
  csv_file <- dplyr::filter(csv_file, rowSums(is.na(csv_file)) != ncol(csv_file))
  # group by sensor name ----
  csv_file <- csv_file %>%
    dplyr::group_by(sensor) %>%
    tidyr::nest()
  # cycle for each system + components (if any) ----
  for (i in 1:nrow(csv_file)) {
    sensor <- csv_file$data[[i]]
    # assign system and component IDs, so that references can be made ----
    uuids <- sapply(1:nrow(sensor), uuid::UUIDgenerate)
    # use the functions sensorML_sysTypeXML() and sensorML_compTypeXML() to create the different XML ----
    sensorML_sysTypeXML(sensorList = sensor, uuidsList = uuids)
    sensorML_compTypeXML(sensorList = sensor, uuidsList = uuids)
    # use the function sensorMLType2rdf to create ttl of SensorML ----
    root_dir <- paste0(
      "sensorML_files_system_",
      uuids[1]
    )
    # TODO modify the sensorMLType2rdf function. The function as it is built now starts from the XML files of type systems
    # and type components, both of which do not contain information regarding e.g. observed property, contacts, position, etc. 
    # In addition in SOSA or SSN it is not possible to have the hierarchy and discriminate between sensor type and sensor instance.
    # So, I think we need to produce the transformation for sensor instances only. How can this be done? How is it possible to take
    # all the XML type information (system, component and instance) and transform it into TTL?
    # if (dir.exists(root_dir)) {
    #   if (nrow(sensor) > 1 && 'component' %in% sensor$sensor_level) {
    #     sensorMLType2rdf(
    #       file_folder = paste0(getwd(), "/", root_dir, "/system/")
    #     )
    #     sensorMLType2rdf(
    #       file_folder = paste0(getwd(), "/", root_dir, "/components/")
    #     )
    #   } else { # nrow(sensor) = 1
    #     sensorMLType2rdf(
    #       file_folder = paste0(getwd(), "/", root_dir, "/system/")
    #     )
    #   }
    # }
  }
}
# TODO a direct CURL could also be made to the SOS and the fuseki triplestore

sensors_Catalogue(csv_path = "sensors.csv")
