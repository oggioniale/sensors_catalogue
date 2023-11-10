sensorMLType2rdf <- function(file_folder = NULL) {
  # load the file ----
  file_name <- tools::file_path_sans_ext(
    list.files(
      file_folder
    )
  )
  for (a in 1:length(file_name)) {
    setwd(file_folder)
    xml <- xml2::read_xml(
      paste0(
        "./",
        file_name[a],
        ".xml"
      )
    )
    setwd("..")
    dir_name <- paste0(
      getwd(),
      "/systems_components_files_ttl"
    )
    if (!dir.exists(dir_name)) {
      dir.create(dir_name)
    }
    sensorTypeTTL <- file(paste0(dir_name, "/", file_name[a], ".ttl"))
    # check if is type ----
    is_type <- xml2::xml_text(
      xml2::xml_find_all(
        xml,
        ".//swes:extension/swe:Boolean/swe:value/text()"
      )
    )
    if (is_type == "true") {
      # list of the variables for TTL ----
      n_components <- length(xml2::xml_find_all(xml, ".//sml:component"))
      is_system <- xml2::xml_find_first(xml, ".//sml:PhysicalSystem")
      is_component <- xml2::xml_find_first(xml, ".//sml:PhysicalComponent")
      # identifier
      identifier <- xml2::xml_find_all(xml, ".//gml:identifier/text()")
      # capabilities
      has_capability <- xml2::xml_find_first(xml, ".//sml:capabilities/@name='capabilities'")
      has_accuracy <- xml2::xml_find_first(xml, ".//sml:capability/@name='Accuracy'")
      has_measurement_range <- xml2::xml_find_first(xml, ".//sml:capability/@name='MeasurementRange'")
      has_precision <- xml2::xml_find_first(xml, ".//sml:capability/@name='Precision'")
      has_resolution <- xml2::xml_find_first(xml, ".//sml:capability/@name='Resolution'")
      has_sensitivity <- xml2::xml_find_first(xml, ".//sml:capability/@name='Sensitivity'")
      has_frequency <- xml2::xml_find_first(xml, ".//sml:capability/@name='MinimumReportingFrequency'")
      if (has_capability&(has_accuracy|has_measurement_range|has_precision|has_resolution|has_sensitivity|has_frequency)) {
        sensor_capability <- paste0("<", identifier, "#SensorCapability>")
        if (has_accuracy) {
          accuracy_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='Accuracy']")
          has_quantity_or_text <- xml2::xml_find_first(accuracy_xml, ".//swe:Quantity")
          has_quantity_range <- xml2::xml_find_first(accuracy_xml, ".//swe:QuantityRange")
          accuracy_uri <- paste0("<", identifier, "#SensorAccuracy>")
          if (length(has_quantity_or_text) > 0) {
            accuracy_uom_uri <- xml2::xml_attr(xml2::xml_find_first(accuracy_xml, ".//swe:uom"), "href")
            accuracy_value <- xml2::xml_text(accuracy_xml, ".//swe:value")
            accuracy_value_min <- ""
            accuracy_value_max <- ""
            accuracy_schema <- c(
              paste0("schema:value ", accuracy_value, " ;"),
              paste0("schema:unitCode <", accuracy_uom_uri, "> .")
            )
          } else if (length(has_quantity_range) > 0) {
            accuracy_uom_uri <- xml2::xml_attr(xml2::xml_find_first(accuracy_xml, ".//swe:uom"), "href")
            accuracy_value <- ""
            accuracy_value_min <- stringr::word(xml2::xml_text(accuracy_xml, ".//swe:value"), 1)
            accuracy_value_max <- stringr::word(xml2::xml_text(accuracy_xml, ".//swe:value"), 2)
            accuracy_schema <- c(
              paste0("schema:minValue ", accuracy_value_min, " ;"),
              paste0("schema:maxValue ", accuracy_value_max, " ;"),
              paste0("schema:unitCode <", accuracy_uom_uri, "> .")
            )
          }
          accuracy_description <- c(
            paste0(accuracy_uri, " a ssn:Property , ssn-system:Accuracy , schema:PropertyValue ;"),
            accuracy_schema,
            ""
          )
        } else {
          accuracy_uri <- ""
          accuracy_description <- ""
        }
        if (has_measurement_range) {
          measurement_range_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='MeasurementRange']")
          measurement_range_uom_uri <- xml2::xml_attr(xml2::xml_find_first(measurement_range_xml, ".//swe:uom"), "href")
          measurement_range_value_min <- stringr::word(xml2::xml_text(measurement_range_xml, ".//swe:value"), 1)
          measurement_range_value_max <- stringr::word(xml2::xml_text(measurement_range_xml, ".//swe:value"), 2)
          measurement_range_uri <- paste0("<", identifier, "#SensorMeasurementRange>")
          measurement_range_schema <- c(
            paste0("schema:minValue ", measurement_range_value_min, " ;"),
            paste0("schema:maxValue ", measurement_range_value_max, " ;"),
            paste0("schema:unitCode <", measurement_range_uom_uri, "> .")
          )
          measurement_range_description <- c(
            paste0(measurement_range_uri, " a ssn:Property , ssn-system:MeasurementRange , schema:PropertyValue ;"),
            measurement_range_schema,
            ""
          )
        } else {
          measurement_range_uom_uri <- ""
          measurement_range_value_min <- ""
          measurement_range_value_max <- ""
          measurement_range_uri <- ""
          measurement_range_description <- ""
        }
        if (has_precision) {
          precision_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='Precision']")
          precision_uom_uri <- xml2::xml_attr(xml2::xml_find_first(precision_xml, ".//swe:uom"), "href")
          precision_value <- xml2::xml_text(precision_xml, ".//swe:value")
          precision_uri <- paste0("<", identifier, "#SensorPrecision>")
          precision_schema <- c(
            paste0("schema:value ", precision_value, " ;"),
            paste0("schema:unitCode <", precision_uom_uri, "> .")
          )
          precision_description <- c(
            paste0(precision_uri, " a ssn:Property , ssn-system:Precision , schema:PropertyValue ;"),
            precision_schema,
            ""
          )
        } else {
          precision_uom_uri <- ""
          precision_value <- ""
          precision_uri <- ""
          precision_description <- ""
        }
        if (has_resolution) {
          resolution_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='Resolution']")
          has_quantity_or_text <- xml2::xml_find_first(resolution_xml, ".//swe:Quantity")
          has_quantity_range <- xml2::xml_find_first(resolution_xml, ".//swe:QuantityRange")
          resolution_uri <- paste0("<", identifier, "#SensorResolution>")
          if (length(has_quantity_or_text) > 0) {
            resolution_uom_uri <- xml2::xml_attr(xml2::xml_find_first(resolution_xml, ".//swe:uom"), "href")
            resolution_value <- xml2::xml_text(resolution_xml, ".//swe:value")
            resolution_value_min <- ""
            resolution_value_max <- ""
            resolution_schema <- c(
              paste0("schema:value ", resolution_value, " ;"),
              paste0("schema:unitCode <", resolution_uom_uri, "> .")
            )
          } else if (length(has_quantity_range) > 0) {
            resolution_uom_uri <- xml2::xml_attr(xml2::xml_find_first(resolution_xml, ".//swe:uom"), "href")
            resolution_value <- ""
            resolution_value_min <- stringr::word(xml2::xml_text(resolution_xml, ".//swe:value"), 1)
            resolution_value_max <- stringr::word(xml2::xml_text(resolution_xml, ".//swe:value"), 2)
            resolution_schema <- c(
              paste0("schema:minValue ", resolution_value_min, " ;"),
              paste0("schema:maxValue ", resolution_value_max, " ;"),
              paste0("schema:unitCode <", resolution_uom_uri, "> .")
            )
          }
          resolution_description <- c(
            paste0(resolution_uri, " a ssn:Property , ssn-system:Resolution , schema:PropertyValue ;"),
            resolution_schema,
            ""
          )
        } else {
          resolution_uri <- ""
          resolution_description <- ""
        }
        if (has_sensitivity) {
          sensitivity_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='Sensitivity']")
          sensitivity_uom_uri <- xml2::xml_attr(xml2::xml_find_first(sensitivity_xml, ".//swe:uom"), "href")
          sensitivity_value <- xml2::xml_text(sensitivity_xml, ".//swe:value")
          sensitivity_uri <- paste0("<", identifier, "#SensorSensitivity>")
          sensitivity_schema <- c(
            paste0("schema:value ", sensitivity_value, " ;"),
            paste0("schema:unitCode <", sensitivity_uom_uri, "> .")
          )
          sensitivity_description <- c(
            paste0(sensitivity_uri, " a ssn:Property , ssn-system:Sensitivity , schema:PropertyValue ;"),
            sensitivity_schema,
            ""
          )
        } else {
          sensitivity_uom_uri <- ""
          sensitivity_value <- ""
          sensitivity_uri <- ""
          sensitivity_description <- ""
        }
        if (has_frequency) {
          frequency_xml <- xml2::xml_find_first(xml, ".//sml:capability[@name='MinimumReportingFrequency']")
          has_quantity_or_text <- xml2::xml_find_first(frequency_xml, ".//swe:Quantity")
          has_quantity_range <- xml2::xml_find_first(frequency_xml, ".//swe:QuantityRange")
          frequency_uri <- paste0("<", identifier, "#SensorFrequency>")
          if (length(has_quantity_or_text) > 0) {
            frequency_uom_uri <- xml2::xml_attr(xml2::xml_find_first(frequency_xml, ".//swe:uom"), "href")
            frequency_value <- xml2::xml_text(frequency_xml, ".//swe:value")
            frequency_value_min <- ""
            frequency_value_max <- ""
            frequency_schema <- c(
              paste0("schema:value ", frequency_value, " ;"),
              paste0("schema:unitCode <", frequency_uom_uri, "> .")
            )
          } else if (length(has_quantity_range) > 0) {
            frequency_uom_uri <- xml2::xml_attr(xml2::xml_find_first(frequency_xml, ".//swe:uom"), "href")
            frequency_value <- ""
            frequency_value_min <- stringr::word(xml2::xml_text(frequency_xml, ".//swe:value"), 1)
            frequency_value_max <- stringr::word(xml2::xml_text(frequency_xml, ".//swe:value"), 2)
            frequency_schema <- c(
              paste0("schema:minValue ", frequency_value_min, " ;"),
              paste0("schema:maxValue ", frequency_value_max, " ;"),
              paste0("schema:unitCode <", frequency_uom_uri, "> .")
            )
          }
          frequency_description <- c(
            paste0(frequency_uri, " a ssn:Property , ssn-system:Frequency , schema:PropertyValue ;"),
            frequency_schema,
            ""
          )
        } else {
          frequency_uri <- ""
          frequency_description <- ""
        }
        sensor_capability_01 <- paste0("ssn-system:hasSystemCapability ", sensor_capability, " ;")
        sensor_capability_02 <- c(
          paste0(sensor_capability, " a ssn:Property , ssn-system:SystemCapability , schema:PropertyValue ;"),
          gsub("([,&\\s])\\1+", "\\1",
               paste0(
                 "ssn-system:hasSystemProperty ",
                 paste(
                   accuracy_uri, measurement_range_uri,
                   precision_uri, resolution_uri,
                   sensitivity_uri, frequency_uri,
                   sep = ",", recycle0 = TRUE
                 ), " ."
               ),
               perl = TRUE
          ),
          "",
          accuracy_description,
          measurement_range_description,
          precision_description,
          resolution_description,
          sensitivity_description,
          frequency_description
        )
      } else {
        sensor_capability_01 <- ""
        sensor_capability_02 <- ""
      }
      # other elements
      description <- xml2::xml_find_all(xml, ".//gml:description/text()")
      name <- xml2::xml_find_all(xml, ".//gml:name/text()")
      documentLink <- xml2::xml_find_all(
        xml,
        ".//sml:documentation[1]/sml:DocumentList/sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL/text()"
      )
      manufacturerLink <- xml2::xml_attr(
        xml2::xml_find_all(
          xml, ".//sml:contacts/sml:ContactList/sml:contact"
        ),
        "href"
      )
      manufacturerName <- xml2::xml_attr(
        xml2::xml_find_all(
          xml, ".//sml:contacts/sml:ContactList/sml:contact"
        ),
        "title"
      )
      if (length(manufacturerName) != 0) {
        manufacturer <- paste0("       dcat:contactPoint      [ rdf:type       prov:Organization , foaf:Organization ;",
        "                                rdfs:seeAlso   <", manufacturerLink, "> ;",
        "                                foaf:name      '", manufacturerName, "'] ;")
      } else {
        manufacturer <- ""
      }
      # following this example: https://www.w3.org/TR/vocab-ssn/#dht22-deployment
      if (!is.na(is_system) & n_components >= 1 & is.na(is_component)) {
        sensor_type <- "       a               sosa:Platform , ssn:System , prov:Entity ;"
        components <- paste0(
          "       sosa:hosts             ",
          paste(
            "<",
            paste0(
              "http://rdfdata.get-it.it/sensors/componentsType/", #TODO add model name and manufacturer name (e.g. http://rdfdata.get-it.it/sensors/systemsType/Vantage/Davis_Instruments/uuid)
              sub('.*\\/', '', xml2::xml_attr(
                xml2::xml_find_all(xml, ".//sml:component"),
                "href"
              ))
            ),
          ">",
          sep = "",
          collapse = ", "
          ),
          " ;"
        )
        attached <- ""
      } else if (!is.na(is_component) & is.na(is_system)) {
        sensor_type <- "       a               sosa:Sensor , ssn:System , prov:Entity ;"
        components <- ""
        attached <- paste0(
          "       sosa:isHostedBy             <",
          xml2::xml_attr(
            xml2::xml_find_all(xml, ".//sml:attachedTo"),
            "title"
          ),
          "> ;")
      } else if (!is.na(is_system) & n_components == 0) {
        sensor_type <- "       rdf:type               sosa:Sensor , ssn:System , prov:Entity ;"
        components <- ""
        attached <- ""
      }
      # observable properties
      obsPropURI <- as.character(xml2::xml_find_all(
        xml, ".//swes:observableProperty/text()"
      ))
      obsPropList <- paste("<", obsPropURI, ">", collapse = ", ", sep = "")
      observedProperties <- paste0("       sosa:observes             ", obsPropList,  " .")  # observed property
      # derived from
      uuid <- stringr::str_replace(as.character(identifier), "^.+/", "")
      if (length(documentLink) != 0) {
        derivedFrom <- paste0("       prov:wasDerivedFrom    <", documentLink,"> ;") # sml:documentation xlink:arcrole="datasheet"
      } else {
        derivedFrom <- ""
      }
      # sameAs
      sameAs <- paste0("       owl:sameAs             <", identifier, "> ;")
      # RDF_identifier
      if (length(is_system) != 0) {
        RDF_identifier <- paste0("<http://rdfdata.get-it.it/sensors/systemsType/", uuid, ">") #TODO add model name and manufacturer name (e.g. http://rdfdata.get-it.it/sensors/systemsType/Vantage/Davis_Instruments/uuid)
      } else if (length(is_component) != 0) {
        RDF_identifier <- paste0("<http://rdfdata.get-it.it/sensors/componentsType/", uuid, ">") #TODO add model name and manufacturer name (e.g. http://rdfdata.get-it.it/sensors/systemsType/Vantage/Davis_Instruments/uuid)
      }
      # contents ----
      sensor <- ""
      sensor <- c(
        sensor,
        RDF_identifier,
        sensor_type,
        sameAs, # gml:identifier
        paste0("       rdfs:comment           '", description, "'@en ;"), # gml:description
        paste0("       rdfs:label             '", name, "'@en ;"), # gml:name
        manufacturer,
        components,
        attached,
        sensor_capability_01,
        derivedFrom,
        observedProperties,
        "",
        sensor_capability_02,
        ""
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
          "",
          sensor
        ),
        sensorTypeTTL
      )
      close(sensorTypeTTL)
    } else {
      stop("\n----\nThe XML provided is not a sensor type.\nPlease change the file.\n----\n")
    }
  }
  setwd("..")
}