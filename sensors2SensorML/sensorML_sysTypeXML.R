sensorML_sysTypeXML <- function(sensorList, uuidsList) {
  # sensor, name, and uuid ----
  sensor_system <- sensorList %>%
    dplyr::filter(sensor_level == 'system')
  system_uuid <- uuidsList[1]
  # folders creation ----
  # root folder
  root_dir <- paste0(
    "sensorML_files_system_",
    system_uuid
  )
  if (!dir.exists(root_dir)) {
    dir.create(root_dir)
    dir_name <- "system"
    dir.create(paste0(
      root_dir, "/", dir_name
    ))
  } else if (dir.exists(root_dir) && !dir.exists(
    paste0(
      root_dir, "/", dir_name
    )
  )) {
    dir.create(paste0(
      root_dir, "/", dir_name
    ))
  }
  # name of system file ----
  file_name <- paste0("ID_system_", system_uuid)
  # read xml ----
  physicalSystemType_XML_base <- xml2::read_xml("base.xml")
  # xml ----
  a <- physicalSystemType_XML_base %>%
    # swes:extension
    xml2::xml_add_child(., "swes:extension") %>%
      xml2::xml_add_child(., "swe:Boolean", "definition" = "isType") %>%
      xml2::xml_add_child(., "swe:value", "true")
  
  # swes:procedureDescriptionFormat
  b <- xml2::xml_add_child(physicalSystemType_XML_base, "swes:procedureDescriptionFormat", "http://www.opengis.net/sensorml/2.0")
  # swes:procedureDescription
  c <- xml2::xml_add_child(physicalSystemType_XML_base, "swes:procedureDescription") %>%
    xml2::xml_add_child(., "sml:PhysicalSystem", "xmlns:gco" = "http://www.isotc211.org/2005/gco",
                        "xmlns:gmd" = "http://www.isotc211.org/2005/gmd", "xmlns:gml" = "http://www.opengis.net/gml/3.2",
                        "xmlns:sml" = "http://www.opengis.net/sensorml/2.0", "xmlns:swe" = "http://www.opengis.net/swe/2.0",
                        "xmlns:xsi" = "http://www.w3.org/2001/XMLSchema-instance", "xmlns:xlink" = "http://www.w3.org/1999/xlink",
                        "gml:id"= paste0("ID_system_", system_uuid),
                        "xsi:schemaLocation" = "http://www.opengis.net/sensorml/2.0 http://schemas.opengis.net/sensorML/2.0/sensorML.xsd http://www.opengis.net/swe/2.0 http://schemas.opengis.net/sweCommon/2.0/swe.xsd"
    )
  
  # gml:description
  if (!is.na(sensor_system$description)) {
    xml2::xml_add_child(c, "gml:description", sensor_system$description)
  }
  
  # gml:identifier
  if (!is.na(sensor_system$model_name)) {
    model_name = sub(" ", "_", sensor_system$model_name)
  } else {
    model_name = "model_name"
  }
  if (!is.na(sensor_system$manufacturer)) {
    manufacturer = sub(" ", "_", sensor_system$manufacturer)
  } else {
    manufacturer = "manufacturer"
  }
  xml2::xml_add_child(
    c,
    "gml:identifier",
    "codeSpace" = "uniqueID",
    paste0(
      "http://registry.get-it.it/sensors/systemsType/",
      model_name, "/",
      manufacturer, "/",
      system_uuid
    )
  )
  
  # gml:name
  if (!is.na(sensor_system$name)) {
    xml2::xml_add_child(c, "gml:name", sensor_system$name)    
  }
  
  # sml:keywords
  if (!is.na(sensor_system$keywords)) {
    c1 <- xml2::xml_add_child(c, "sml:keywords") %>%
      xml2::xml_add_child(., "sml:KeywordList")
    list_keywords <- stringr::str_split(sensor_system$keywords, pattern = ",")
    for (x in 1:length(list_keywords[[1]])) {
      xml2::xml_add_child(c1, "sml:keyword", list_keywords[[1]][x])
    }
  }
  
  # sml:identification
  d <- xml2::xml_add_child(c, "sml:identification") %>%
    xml2::xml_add_child(., "sml:IdentifierList")
  # sml:identification - uniqueID
  xml2::xml_add_child(d, "sml:identifier") %>%
    xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0008/") %>%
    xml2::xml_add_child(., "sml:label", "uniqueID") %>%
    xml2::xml_add_sibling(
      .,
      "sml:value",
      paste0(
        "http://registry.get-it.it/sensors/systemsType/",
        model_name, "/",
        manufacturer, "/",
        system_uuid
      )
    )
  # sml:identification - short_name
  if (!is.na(sensor_system$short_name)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0006/") %>%
      xml2::xml_add_child(., "sml:label", "shortName") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$short_name)
  }
  # sml:identification - Manufacturer
  if (!is.na(sensor_system$manufacturer)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0012/") %>%
      xml2::xml_add_child(., "sml:label", "Manufacturer") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$manufacturer)
  }
  # sml:identification - Model Name
  if (!is.na(sensor_system$model_name)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0003/") %>%
      xml2::xml_add_child(., "sml:label", "Model Name") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$model_name)
  }
  # sml:identification - Model Number
  if (!is.na(sensor_system$model_number)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0004/") %>%
      xml2::xml_add_child(., "sml:label", "Model Number") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$model_number)
  }
  # sml:identification - Long Name
  if (!is.na(sensor_system$long_name)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0002/") %>%
      xml2::xml_add_child(., "sml:label", "longName") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$long_name)
  }
  # sml:identification - Version
  if (!is.na(sensor_system$version)) {
    xml2::xml_add_child(d, "sml:identifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0013/") %>%
      xml2::xml_add_child(., "sml:label", "Version") %>%
      xml2::xml_add_sibling(., "sml:value", sensor_system$version)
  }
  
  # sml:classification
  if (!is.na(sensor_system$sensor_type)) {
    sensorType_query <- paste0("PREFIX owl: <http://www.w3.org/2002/07/owl#>
  PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  SELECT ?c ?l
  WHERE {
    SERVICE <http://vocab.nerc.ac.uk/sparql/sparql> {
      ?c rdf:type skos:Concept .
      <http://vocab.nerc.ac.uk/collection/P10/current/> skos:member ?c .
      OPTIONAL {
        ?c skos:prefLabel ?l .
      }
      FILTER( REGEX( STR(?l), '",
      sensor_system$sensor_type,
      "', 'i') )
       }
      }
      ORDER BY ASC(?l)
      LIMIT 1")
    sensorType_qr <- httr2::request("http://fuseki1.get-it.it/manufacturers") %>%
      httr2::req_url_query(query = sensorType_query) %>%
      httr2::req_method("POST") %>%
      httr2::req_headers(Accept = "application/sparql-results+json") %>%
      httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
      httr2::req_perform()
    httr2::resp_check_status(sensorType_qr)
    sensorType_JSON <- httr2::resp_body_json(sensorType_qr)
    sensorType_rdf <- sensorType_JSON$results$bindings[[1]]$c$value
    e <- xml2::xml_add_child(c, "sml:classification") %>%
      xml2::xml_add_child(., "sml:ClassifierList")
    xml2::xml_add_child(e, "sml:classifier") %>%
      xml2::xml_add_child(., "sml:Term", "definition" = "http://www.opengis.net/def/property/OGC/0/SensorType") %>%
      xml2::xml_add_child(., "sml:label", sensor_system$sensor_type) %>%
      xml2::xml_add_sibling(., "sml:value", sensorType_rdf)
  }
  
  # sml:characteristics
  # sml:characteristics - physicalProperties
  if (!is.na(sensor_system$material) |
      !is.na(sensor_system$weight) |
      !is.na(sensor_system$height) |
      !is.na(sensor_system$width) |
      !is.na(sensor_system$length)) {
    f <- xml2::xml_add_child(c, "sml:characteristics", "name" = "characteristics") %>%
      xml2::xml_add_child(., "sml:CharacteristicList")
    f1 <- xml2::xml_add_child(f, "sml:characteristic", "name" = "physicalProperties") %>%
      xml2::xml_add_child(., "swe:DataRecord") %>%
      xml2::xml_add_child(., "swe:field", "name" = "PhysicalProperties") %>%
      xml2::xml_add_child(., "swe:DataRecord")
    # sml:characteristics - physicalProperties - Material
    if (!is.na(sensor_system$material)) {
      xml2::xml_add_child(f1, "swe:field", "name" = "Material") %>%
        xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0005/") %>%
        xml2::xml_add_child(., "swe:description", sensor_system$material)
    }
    # sml:characteristics - physicalProperties - Weight
    if (!is.na(sensor_system$weight)) {
      xml2::xml_add_child(f1, "swe:field", "name" = "Weight") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0001/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "kg", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/KGXX/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$weight)
    }
    # sml:characteristics - physicalProperties - Length
    if (!is.na(sensor_system$length)) {
      xml2::xml_add_child(f1, "swe:field", "name" = "Length") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0002/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "mm", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UXMM/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$length)
    }
    # sml:characteristics - physicalProperties - Width
    if (!is.na(sensor_system$width)) {
      xml2::xml_add_child(f1, "swe:field", "name" = "Width") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0004/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "mm", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UXMM/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$width)
    }
    # sml:characteristics - physicalProperties - Height
    if (!is.na(sensor_system$height)) {
      xml2::xml_add_child(f1, "swe:field", "name" = "Height") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0003/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "mm", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UXMM/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$height)
    }
  }
  # sml:characteristics - electricalRequirements
  if (!is.na(sensor_system$electrical_current_type) |
      !is.na(sensor_system$input_power_range) |
      !is.na(sensor_system$battery_charging_current) |
      !is.na(sensor_system$battery_output)) {
    f2 <- xml2::xml_add_child(f, "sml:characteristic", "name" = "electricalRequirements") %>%
      xml2::xml_add_child(., "swe:DataRecord")
    # sml:characteristics - electricalRequirements - ElectricalCurrentType
    if (!is.na(sensor_system$electrical_current_type)) {
      xml2::xml_add_child(f2, "swe:field", "name" = "ElectricalCurrentType") %>%
        xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0009/") %>%
        xml2::xml_add_child(., "swe:description", sensor_system$electrical_current_type)
    }
    # sml:characteristics - electricalRequirements - InputPowerRange
    if (!is.na(sensor_system$input_power_range)) {
      xml2::xml_add_child(f2, "swe:field", "name" = "InputPowerRange") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0008/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "W", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/WATT/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$input_power_range)
    }
    # sml:characteristics - electricalRequirements - BatteryChargingCurrent
    if (!is.na(sensor_system$battery_charging_current)) {
      if (grepl("\\s+", sensor_system$battery_charging_current)) {
        xml2::xml_add_child(f2, "swe:field", "name" = "BatteryChargingCurrent") %>%
          xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/MVB/current/MVB000064/") %>%
          xml2::xml_add_child(., "swe:uom", "code" = "mA", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UMAM/") %>%
          xml2::xml_add_sibling(., "swe:value", sensor_system$battery_charging_current)
      } else {
        if (grepl("[0-9]", sensor_system$battery_charging_current)) {
          xml2::xml_add_child(f2, "swe:field", "name" = "BatteryChargingCurrent") %>%
            xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/MVB/current/MVB000064/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = "mA", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UMAM/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$battery_charging_current)
        } else {
          xml2::xml_add_child(f2, "swe:field", "name" = "BatteryChargingCurrent") %>%
            xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/MVB/current/MVB000064/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$battery_charging_current)
        }
      }
    }
    # sml:characteristics - electricalRequirements - BatteryOutput
    if (!is.na(sensor_system$battery_output)) {
      if (grepl("\\s+", sensor_system$battery_output)) {
        xml2::xml_add_child(f2, "swe:field", "name" = "BatteryOutput") %>%
          xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/S29/current/PE001260/") %>%
          xml2::xml_add_child(., "swe:uom", "code" = "V", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UVLT/") %>%
          xml2::xml_add_sibling(., "swe:value", sensor_system$battery_output)
      } else {
        if (grepl("[0-9]", sensor_system$battery_output)) {
          xml2::xml_add_child(f2, "swe:field", "name" = "BatteryOutput") %>%
            xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/S29/current/PE001260/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = "V", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UVLT/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$battery_output)
        } else {
          xml2::xml_add_child(f2, "swe:field", "name" = "BatteryOutput") %>%
            xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/S29/current/PE001260/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$battery_output)
        }
      }
    }
  }
  # sml:characteristics - dataSpecifications
  if (!is.na(sensor_system$data_storage_type) |
      !is.na(sensor_system$data_storage) |
      !is.na(sensor_system$data_format)) {
    f3 <- xml2::xml_add_child(f, "sml:characteristic", "name" = "dataSpecifications") %>%
      xml2::xml_add_child(., "swe:DataRecord")
    # sml:characteristics - dataSpecifications - DataStorageType
    if(!is.na(sensor_system$data_storage_type)) {
      xml2::xml_add_child(f3, "swe:field", "name" = "DataStorageType") %>%
        xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0010/") %>%
        xml2::xml_add_child(., "swe:description", sensor_system$data_storage_type)
    }
    # sml:characteristics - dataSpecifications - DataStorage
    if(!is.na(sensor_system$data_storage)) {
      xml2::xml_add_child(f3, "swe:field", "name" = "DataStorage") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/MVB/current/MVB000064/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "MB", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/MBYT/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$data_storage)
    }
    # sml:characteristics - dataSpecifications - Dataformat
    if (!is.na(sensor_system$data_format)) {
      xml2::xml_add_child(f3, "swe:field", "name" = "Dataformat") %>%
        xml2::xml_add_child(., "swe:Text") %>%
        xml2::xml_add_child(., "swe:description", sensor_system$data_format)
    }
  }
  # sml:characteristics - transmissionMode
  if (!is.na(sensor_system$transmission_mode)) {
    f4 <- xml2::xml_add_child(f, "sml:characteristic", "name" = "transmissionMode") %>%
      xml2::xml_add_child(., "swe:DataRecord")
    # sml:characteristics - TransmissionMode
    if(!is.na(sensor_system$transmission_mode)) {
      xml2::xml_add_child(f4, "swe:field", "name" = "TransmissionMode") %>%
        xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W05/current/CHAR0007/") %>%
        xml2::xml_add_child(., "swe:description", sensor_system$transmission_mode)
    }
  }
  
  # sml:capabilities
  if (!is.na(sensor_system$accuracy) |
      !is.na(sensor_system$measurement_range) |
      !is.na(sensor_system$operating_depth) |
      !is.na(sensor_system$precision) |
      !is.na(sensor_system$resolution) |
      !is.na(sensor_system$sensitivity) |
      !is.na(sensor_system$minimum_reporting_frequency) |
      !is.na(sensor_system$mobile) |
      !is.na(sensor_system$insitu)) {
    g <- xml2::xml_add_child(c, "sml:capabilities", "name" = "capabilities") %>%
      xml2::xml_add_child(., "sml:CapabilityList")
    # for SPARQL query
    ireaEndpoint <- "http://fuseki1.get-it.it/directory/query"
    uom_query_I_part <- "PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    SELECT ?c ?l ?s
    WHERE {
      SERVICE <http://vocab.nerc.ac.uk/sparql/sparql> {
        ?c rdf:type skos:Concept .
        <http://vocab.nerc.ac.uk/collection/P06/current/> skos:member ?c .
        OPTIONAL {
          ?c skos:altLabel ?l .
          ?c owl:sameAs ?s .
        }
        FILTER( REGEX( STR(?l), '"
    uom_query_II_part <- "', 'i'))
         }
        }
        ORDER BY ASC(?l)
        LIMIT 1"
    # sml:capabilities - Accuracy
    if (!is.na(sensor_system$accuracy)) {
      uom_nerc_query <- paste0(
        uom_query_I_part,
        sensor_system$accuracy_uom,
        uom_query_II_part
      )
      nercUOM <- httr2::request(ireaEndpoint) %>%
        httr2::req_url_query(query = uom_nerc_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(nercUOM)
      nercUOM_JSON <- httr2::resp_body_json(nercUOM)
      accuracy_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
      if (grepl("\\s+", sensor_system$accuracy)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
          xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
          xml2::xml_add_child(., "swe:uom", "code" = sensor_system$accuracy_uom, "xlink:href" = accuracy_uom_def) %>%
          xml2::xml_add_sibling(., "swe:value", sensor_system$accuracy)
      } else {
        if (grepl("[0-9]", sensor_system$accuracy)) {
          xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
            xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = sensor_system$accuracy_uom, "xlink:href" = accuracy_uom_def) %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$accuracy)
        } else {
          xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
            xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$accuracy)
        }
      }
    }
    # sml:capabilities - MeasurementRange
    if (!is.na(sensor_system$measurement_range)) {
      uom_nerc_query <- paste0(
        uom_query_I_part,
        sensor_system$measurement_range_uom,
        uom_query_II_part
      )
      nercUOM <- httr2::request(ireaEndpoint) %>%
        httr2::req_url_query(query = uom_nerc_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(nercUOM)
      nercUOM_JSON <- httr2::resp_body_json(nercUOM)
      measurement_range_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
      xml2::xml_add_child(g, "sml:capability", "name" = "MeasurementRange") %>%
        xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0006/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = sensor_system$measurement_range_uom, "xlink:href" = measurement_range_uom_def) %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$measurement_range)
    }
    # sml:capabilities - OperatingDepth
    if (!is.na(sensor_system$operating_depth)) {
      xml2::xml_add_child(g, "sml:capability", "name" = "OperatingDepth") %>%
        xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0012/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "m", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/ULAA/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$operating_depth)
    }
    # sml:capabilities - Precision
    if (!is.na(sensor_system$precision)) {
      uom_nerc_query <- paste0(
        uom_query_I_part,
        sensor_system$precision_uom,
        uom_query_II_part
      )
      nercUOM <- httr2::request(ireaEndpoint) %>%
        httr2::req_url_query(query = uom_nerc_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(nercUOM)
      nercUOM_JSON <- httr2::resp_body_json(nercUOM)
      precision_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
      xml2::xml_add_child(g, "sml:capability", "name" = "Precision") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0005/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = sensor_system$precision_uom, "xlink:href" = precision_uom_def) %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$precision)
    }
    # sml:capabilities - Resolution
    if (!is.na(sensor_system$resolution)) {
      uom_nerc_query <- paste0(
        uom_query_I_part,
        sensor_system$accuracy_uom,
        uom_query_II_part
      )
      nercUOM <- httr2::request(ireaEndpoint) %>%
        httr2::req_url_query(query = uom_nerc_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(nercUOM)
      nercUOM_JSON <- httr2::resp_body_json(nercUOM)
      accuracy_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
      if (grepl("\\s+", sensor_system$resolution)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
          xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
          xml2::xml_add_child(., "swe:uom", "code" = sensor_system$resolution_uom, "xlink:href" = sensor_system$resolution_uom_def) %>%
          xml2::xml_add_sibling(., "swe:value", sensor_system$resolution)
      } else {
        if (grepl("[0-9]", sensor_system$resolution)) {
          xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
            xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = sensor_system$resolution_uom, "xlink:href" = sensor_system$resolution_uom_def) %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$resolution)
        } else {
          xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
            xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
            xml2::xml_add_sibling(., "swe:value", sensor_system$resolution)
        }
      }
    }
    # sml:capabilities - Sensitivity
    if (!is.na(sensor_system$sensitivity)) {
      uom_nerc_query <- paste0(
        uom_query_I_part,
        sensor_system$sensitivity_uom,
        uom_query_II_part
      )
      nercUOM <- httr2::request(ireaEndpoint) %>%
        httr2::req_url_query(query = uom_nerc_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(nercUOM)
      nercUOM_JSON <- httr2::resp_body_json(nercUOM)
      sensitivity_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
      xml2::xml_add_child(g, "sml:capability", "name" = "Sensitivity") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0009/") %>%
        xml2::xml_add_child(., "swe:uom", "code" = sensor_system$sensitivity_uom, "xlink:href" = sensitivity_uom_def) %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$sensitivity)
    }
    # sml:capabilities - MinimumReportingFrequency
    if (!is.na(sensor_system$minimum_reporting_frequency)) {
      xml2::xml_add_child(g, "sml:capability", "name" = "MinimumReportingFrequency") %>%
        xml2::xml_add_child(., "swe:Quantity", "definition" = "https://www.w3.org/TR/vocab-ssn/#SSNSYSTEMFrequency") %>%
        xml2::xml_add_child(., "swe:uom", "code" = "s", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UTBB/") %>%
        xml2::xml_add_sibling(., "swe:value", sensor_system$minimum_reporting_frequency)
    }
    # sml:capabilities - Mobile
    if (!is.na(sensor_system$mobile)) {
      xml2::xml_add_child(g, "sml:capability", "name" = "Mobile") %>%
        xml2::xml_add_child(., "swe:Boolean") %>%
        xml2::xml_add_child(., "swe:value", tolower(sensor_system$mobile))
    }
    # sml:capabilities - Insitu
    if (!is.na(sensor_system$insitu)) {
      xml2::xml_add_child(g, "sml:capability", "name" = "Insitu") %>%
        xml2::xml_add_child(., "swe:Boolean") %>%
        xml2::xml_add_child(., "swe:value", tolower(sensor_system$insitu))
    }
  }
  
  # sml:contacts
  if (!is.na(sensor_system$manufacturer)) {
    contacts_query <- paste0("PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    SELECT ?c ?l
    WHERE {
      ?c rdf:type foaf:Organization.
      ?c foaf:name ?l.
      FILTER( REGEX( STR(?l), '",
        sensor_system$manufacturer,
      "', 'i') )
    }
    ORDER BY ASC(?l)
    LIMIT 1")
    manufacturer_qr <- httr2::request("http://fuseki1.get-it.it/manufacturers") %>%
      httr2::req_url_query(query = contacts_query) %>%
      httr2::req_method("POST") %>%
      httr2::req_headers(Accept = "application/sparql-results+json") %>%
      httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
      httr2::req_perform()
    httr2::resp_check_status(manufacturer_qr)
    manufacturer_JSON <- httr2::resp_body_json(manufacturer_qr)
    manufacturer_rdf <- manufacturer_JSON$results$bindings[[1]]$c$value
    h <- xml2::xml_add_child(c, "sml:contacts") %>%
      xml2::xml_add_child(., "sml:ContactList")
    xml2::xml_add_child(h, "sml:contact", "xlink:title" = "manufacturer", "xlink:href" = manufacturer_rdf) %>%
      xml2::xml_add_child(., "gmd:CI_ResponsibleParty") %>%
      xml2::xml_add_child(., "gmd:role") %>%
      xml2::xml_add_child(., "gmd:CI_RoleCode",
                          "codeList" = "http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode/",
                          "codeListValue" = "originator", "manufacturer"
      )
  }
  
  # sml:documentation
  if (!is.na(sensor_system$datasheet)) {
    i <- xml2::xml_add_child(c, "sml:documentation", "xlink:arcrole" = "datasheet") %>%
      xml2::xml_add_child(., "sml:DocumentList")
  # sml:documentation - document
    xml2::xml_add_child(i, "sml:document") %>%
      xml2::xml_add_child(., "gmd:CI_OnlineResource") %>%
      xml2::xml_add_child(., "gmd:linkage") %>%
      xml2::xml_add_child(., "gmd:URL", sensor_system$datasheet)
  }
  if (!is.na(sensor_system$image)) {
    l <- xml2::xml_add_child(c, "sml:documentation", "xlink:arcrole" = "image") %>%
      xml2::xml_add_child(., "sml:DocumentList")
    l1 <- xml2::xml_add_child(l, "sml:document") %>%
      xml2::xml_add_child(., "gmd:CI_OnlineResource") %>%
      xml2::xml_add_child(., "gmd:linkage")
    # sml:documentation - image
    xml2::xml_add_child(l1, "gmd:URL", sensor_system$image)
    xml2::xml_add_sibling(l1, "gmd:name") %>%
      xml2::xml_add_child(., "gco:CharacterString", "Image")
  }
  
  if (nrow(sensorList) > 1) {
    # sml:components
    components_number <- nrow(sensorList) - 1
    uuids_components <- uuidsList[2:nrow(sensorList)]
    m <- xml2::xml_add_child(c, "sml:components") %>%
      xml2::xml_add_child(., "sml:ComponentList")
    if (!is.na(sensor_system$model_name)) {
      model_name = sub(" ", "_", sensor_system$model_name)
    } else {
      model_name = "model_name"
    }
    if (!is.na(sensor_system$manufacturer)) {
      manufacturer = sub(" ", "_", sensor_system$manufacturer)
    } else {
      manufacturer = "manufacturer"
    }
    components_name <- paste(
      "ID_component_",
      uuids_components,
      sep = ""
    )
    components_xlink_href <- paste(
      paste0(
        "http://registry.get-it.it/sensors/componentsType/",
        model_name, "/",
        manufacturer, "/"
      ),
      uuids_components,
      sep = ""
    )
    for (j in 1:length(components_xlink_href)) {
      xml2::xml_add_child(
        m,
        "sml:component",
        "name" = components_name[j],
        "xlink:href" = components_xlink_href[j]
      )
    }
    
    # swes:observableProperty
    xml2::xml_add_child(physicalSystemType_XML_base, "swes:observableProperty", "not_defined")
    # In case of obsProps in sensor component(s) is fill remove the comment above
  #   components_info <- sensorList %>%
  #     dplyr::filter(sensor_level == 'component')
  #   list_obsProp <- components_info$observed_property
  #   list_obsProp_uris <- NA
  #   for (n in 1:length(list_obsProp)) {
  #     obsProp_query <- paste0("PREFIX owl: <http://www.w3.org/2002/07/owl#>
  # PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  # PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  # SELECT ?c ?l ?s
  # WHERE {
  #   SERVICE <http://vocab.nerc.ac.uk/sparql/sparql> {
  #     ?c rdf:type skos:Concept .
  #     <http://vocab.nerc.ac.uk/collection/P02/current/> skos:member ?c .
  #     OPTIONAL {
  #       ?c skos:prefLabel ?l .
  #       ?c owl:sameAs ?s .
  #     }
  #     FILTER( REGEX( STR(?l), '",
  #                             list_obsProp[1],
  #                             "', 'i'))
  #      }
  #     }
  #     ORDER BY ASC(?l)
  #     LIMIT 1")
  #     obsProp_qr <- httr2::request("http://fuseki1.get-it.it/manufacturers") %>%
  #       httr2::req_url_query(query = obsProp_query) %>%
  #       httr2::req_method("POST") %>%
  #       httr2::req_headers(Accept = "application/sparql-results+json") %>%
  #       httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
  #       httr2::req_perform()
  #     httr2::resp_check_status(obsProp_qr)
  #     obsProp_JSON <- httr2::resp_body_json(obsProp_qr)
  #     obsProp_rdf <- obsProp_JSON$results$bindings[[1]]$c$value
  #     list_obsProp_uris <- paste(obsProp_rdf, list_obsProp_uris, sep = ",")
  #   }
  #   list_obsProp_uris <- stringr::str_sub(list_obsProp_uris, end = -5)
  #   if (!is.na(list_obsProp_uris)) {
  #     xml2::xml_add_child(physicalSystemType_XML_base, "swes:observableProperty", list_obsProp_uris)
  #   } else {
  #     xml2::xml_add_child(physicalSystemType_XML_base, "swes:observableProperty", "not_defined")
  #   }
  }
  
  # write file ----
  xml2::write_xml(
    physicalSystemType_XML_base,
    paste0(
      root_dir,
      "/",
      dir_name,
      "/",
      file_name,
      ".xml"
    )
  )
}
