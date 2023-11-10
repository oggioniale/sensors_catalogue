sensorMLInstance2rdf <- function(file_path = NULL) {
  # load the file ----
  file_name <- tools::file_path_sans_ext(file_path)
  xml <- xml2::read_xml(file_path)
  sensorInstTTL <- file(paste0(file_name, ".ttl"))
  
  
  # contents ----
  sensorInst <- ""
  sensorInst <- c(
    sensorInst,
    paste0("")
  )
  writeLines(
    c(
      "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .",
      "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .",
      "@prefix sosa: <http://www.w3.org/ns/sosa/> .",
      "@prefix ssn: <http://www.w3.org/ns/ssn/> .",
      "@prefix ssn-system: <http://www.w3.org/ns/ssn/systems/> .",
      "@prefix foaf: <http://xmlns.com/foaf/0.1/> .",
      "@prefix owl: <http://www.w3.org/2002/07/owl#> .",
      "@prefix dcat: <http://www.w3.org/ns/dcat#> .",
      "@prefix prov: <http://www.w3.org/ns/prov#> .",
      "@prefix schema: <http://schema.org/> .",
      "@prefix getit: <http://rdfdata.get-it.it/> .",
      "@prefix sml: <http://www.opengis.net/sensorml/2.0> .",
      "",
      "# custom properties. We define here properties not found in other ontologies yet.",
      "getit:typeOf a rdf:Property ;",
      "rdfs:domain sml:sensorML ;",
      "rdfs:range rdfs:Resource ;",
      "rdfs:comment 'A reference to a base process from which this process inherits properties and constraints (e.g. original equipment manufacturer's model description, generic equation, etc.). The uniqueID of the referenced process must be provided using the xlink:title attribute while the URL to the process description must be provided by the xlink:href attribute.'@en .",
      "",
      sensorInst
    ),
    sensorInstTTL
  )
  close(sensorInstTTL)
}