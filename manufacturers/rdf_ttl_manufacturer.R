rdf_ttl_manufacturer <- function(csv_path = NULL, orcid_creator, creator, last_number = NA) {
  # read csv file ----
  csv_file <- vroom::vroom(csv_path, ",", escape_double = FALSE, trim_ws = TRUE)
  n_new_records <- nrow(csv_file)
  file_name <- tools::file_path_sans_ext(csv_path)
  fileTTL <- file(paste0(file_name, ".ttl"))
  org <- ""
  for (i in 1:n_new_records) {
    org <- c(
      org,
      paste0("<http://rdfdata.get-it.it/sensors/manufacturers/", as.numeric(last_number) + i, ">"),
      "        a              foaf:Organization ;",
      paste0("        vcard:email    <mailto:", csv_file$email[i], "> ;"),
      paste0("        addr:address   [ addr:deliveryPoint  [ addr:location  [ addr:building          '", csv_file$building[i], "' ;"),
      paste0("                                                                addr:country           '", csv_file$country[i], "' ;"),
      paste0("                                                                addr:postcode          '", csv_file$postcode[i], "' ;"),
      paste0("                                                                addr:region            '", csv_file$region[i], "' ;"),
      paste0("                                                                addr:streetNr          '", csv_file$streetNr[i], "' ;"),
      paste0("                                                                addr:thoroughfareName  '", csv_file$thoroughfareName[i], "' ;"),
      paste0("                                                                addr:town              '", csv_file$town[i], "'"),
      "                                                              ]",
      "                                             ]",
      "                       ] ;",
      paste0("        foaf:homepage  <", csv_file$homepage[i], "> ;"),
      paste0("        foaf:name      '", csv_file$name[i], "' ;"),
      paste0("        foaf:phone     <tel:", chartr(" ", "-", csv_file$phone[i]), "> .")
    )
  }
  writeLines(
    c(
      "@prefix org:   <http://www.w3.org/ns/org#> .",
      "@prefix dcterms: <http://purl.org/dc/terms/> .",
      "@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .",
      "@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .",
      "@prefix addr:  <http://wymiwyg.org/ontologies/foaf/postaddress#> .",
      "@prefix foaf:  <http://xmlns.com/foaf/0.1/> .",
      "",
      org
    ),
    fileTTL
  )
  close(fileTTL)
}



