rdf_XML_manufacturer <- function(csv_path = NULL, orcid_creator, creator, last_number = NA) {
  # read csv file ----
  csv_file <- vroom::vroom(csv_path, ",", escape_double = FALSE, trim_ws = TRUE)
  n_new_records <- nrow(csv_file)
  file_name <- tools::file_path_sans_ext(csv_path)
  baseRDF_XML <- xml2::xml_new_document()
  baseRDF_XML <- baseRDF_XML %>%
    xml2::xml_add_child(
      "rdf:RDF",
      "xmlns:rdf" = "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
      "xmlns" = "http://sp7.irea.cnr.it/rdfdata/sensors/",
      "xmlns:rdfs" = "http://www.w3.org/2000/01/rdf-schema#",
      "xmlns:vcard" = "http://www.w3.org/2006/vcard/ns#",
      "xmlns:foaf" = "http://xmlns.com/foaf/0.1/",
      "xmlns:xsd" = "http://www.w3.org/2001/XMLSchema#",
      "xmlns:org" = "http://www.w3.org/ns/org#",
      "xmlns:addr" = "http://wymiwyg.org/ontologies/foaf/postaddress#",
      "xmlns:dcterms" = "http://purl.org/dc/terms/",
      "xml:base" ="http://sp7.irea.cnr.it/rdfdata/sensors"
    )
  for (i in 1:n_new_records) {
    a <- baseRDF_XML %T>%
      {xml2::xml_add_child(
        .,
        "foaf:Organization",
        "rdf:about" = paste0("http://rdfdata.get-it.it/sensors/manufacturers/", as.numeric(last_number) + i)
      ) %>%
      xml2::xml_add_child(
        .,
        "dcterms:creator",
        .where = "after",
        "rdf:resource" = orcid_creator,
        creator
      ) %>%
      xml2::xml_add_sibling(
        .,
        "foaf:name",
        .where = "after",
        csv_file$name[i]
      ) %>%
      xml2::xml_add_sibling(
        .value = "foaf:homepage",
        .where = "after",
        "rdf:resource" = csv_file$homepage[i]
      ) %>%
      xml2::xml_add_sibling(
        .value = "vcard:email",
        .where = "after",
        "rdf:resource" = paste0("mailto:", csv_file$email[i])
      ) %>%
      xml2::xml_add_sibling(
        .value = "foaf:phone",
        .where = "after",
        "rdf:resource" = paste0("tel:", csv_file$phone[i])
      ) %>%
      xml2::xml_add_sibling(
        .value = "addr:address",
        .where = "after",
        "rdf:parseType" = "Resource"
      ) %>%
      xml2::xml_add_child(
        .value = "addr:deliveryPoint",
        "rdf:parseType" = "Resource"
      ) %>%
      xml2::xml_add_child(
        .value = "addr:location",
        "rdf:parseType" = "Resource"
      ) %>%
      xml2::xml_add_child(
        .value = "addr:thoroughfareName",
        csv_file$thoroughfareName[i]
      ) %>%
      xml2::xml_add_sibling(.value = "addr:streetNr", csv_file$streetNr[i]) %>%
      xml2::xml_add_sibling(.value = "addr:postcode", csv_file$postcode[i]) %>%
      xml2::xml_add_sibling(.value = "addr:building", csv_file$building[i]) %>%
      xml2::xml_add_sibling(.value = "addr:town", csv_file$town[i]) %>%
      xml2::xml_add_sibling(.value = "addr:region", csv_file$region[i]) %>%
      xml2::xml_add_sibling(.value = "addr:country", csv_file$country[i])}
  }
  xml2::write_xml(baseRDF_XML, paste0(file_name, ".rdf"))
}
  