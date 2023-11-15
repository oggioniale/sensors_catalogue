# execute this only after sensorML_sysTypeXML() function!
sensorML_compTypeXML <- function(sensorList, uuidsList) {
  components_info <- sensorList %>%
    dplyr::filter(sensor_level == 'component')
  components_uuid <- uuidsList[c(2:length(uuidsList))]
  # folder creation ----
  root_dir <- paste0(
    "sensorML_files_system_",
    uuidsList[1]
  )
  dir_name <- "components"
  if (!dir.exists(
    paste0(
      root_dir, "/", dir_name
    )
  )) {
    dir.create(paste0(
      root_dir, "/", dir_name
    ))
  }
  for (z in 1:nrow(components_info)) {
    component_info <- components_info[z,]
    component_uuid <- components_uuid[z]
    # name of component file ----
    file_name <- paste0("ID_component_", component_uuid)
    # read xml ----
    physicalComponentType_XML_base <- xml2::read_xml("base.xml")
    # xml ----
    physicalComponentType_XML_base %>%
    # swes:extension
      xml2::xml_add_child(., "swes:extension") %>%
      xml2::xml_add_child(., "swe:Boolean", "definition" = "isType") %>%
      xml2::xml_add_child(., "swe:value", "true")
    
    # swes:procedureDescriptionFormat
    b <- xml2::xml_add_child(physicalComponentType_XML_base, "swes:procedureDescriptionFormat", "http://www.opengis.net/sensorml/2.0")
    # swes:procedureDescription
    c <- xml2::xml_add_child(physicalComponentType_XML_base, "swes:procedureDescription") %>%
      xml2::xml_add_child(., "sml:PhysicalComponent", "xmlns:gco" = "http://www.isotc211.org/2005/gco",
                          "xmlns:gmd" = "http://www.isotc211.org/2005/gmd", "xmlns:gml" = "http://www.opengis.net/gml/3.2",
                          "xmlns:sml" = "http://www.opengis.net/sensorml/2.0", "xmlns:swe" = "http://www.opengis.net/swe/2.0",
                          "xmlns:xsi" = "http://www.w3.org/2001/XMLSchema-instance", "xmlns:xlink" = "http://www.w3.org/1999/xlink",
                          "gml:id"= paste0("ID_component_", component_uuid),
                          "xsi:schemaLocation" = "http://www.opengis.net/sensorml/2.0 http://schemas.opengis.net/sensorML/2.0/sensorML.xsd http://www.opengis.net/swe/2.0 http://schemas.opengis.net/sweCommon/2.0/swe.xsd"
      )
    
    # gml:description
    if (!is.na(component_info$description)) {
      xml2::xml_add_child(c, "gml:description", component_info$description)
    }
    
    # gml:identifier
    if (!is.na(sensorList$model_name[1])) {
      model_name = sub(" ", "_", sensorList$model_name[1])
    } else {
      model_name = "model_name"
    }
    if (!is.na(sensorList$manufacturer[1])) {
      manufacturer = sub(" ", "_", sensorList$manufacturer[1])
    } else {
      manufacturer = "manufacturer"
    }
    xml2::xml_add_child(
      c,
      "gml:identifier",
      "codeSpace" = "uniqueID",
      paste0(
        "http://registry.get-it.it/sensors/componentsType/",
        model_name, "/",
        manufacturer, "/",
        component_uuid
      )
    )
    
    # gml:name
    if (!is.na(component_info$name)) {
      xml2::xml_add_child(c, "gml:name", component_info$name)
    }
    
    # sml:keywords
    if (!is.na(component_info$keywords)) {
      c1 <- xml2::xml_add_child(c, "sml:keywords") %>%
        xml2::xml_add_child(., "sml:KeywordList")
      list_keywords <- stringr::str_split(component_info$keywords, pattern = ",")
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
          "http://registry.get-it.it/sensors/componentsType/",
          model_name, "/",
          manufacturer, "/",
          component_uuid
        )
      )
    # sml:identification - short_name
    if (!is.na(component_info$short_name)) {
      xml2::xml_add_child(d, "sml:identifier") %>%
        xml2::xml_add_child(., "sml:Term", "definition" = "http://vocab.nerc.ac.uk/collection/W07/current/IDEN0006/") %>%
        xml2::xml_add_child(., "sml:label", "shortName") %>%
        xml2::xml_add_sibling(., "sml:value", component_info$short_name)
    }
    
    # sml:classification
    if (!is.na(component_info$sensor_type)) {
      componentType_query <- paste0("PREFIX owl: <http://www.w3.org/2002/07/owl#>
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
      component_info$sensor_type,
      "', 'i') )
       }
      }
      ORDER BY ASC(?l)
      LIMIT 1")
      componentType_qr <- httr2::request("http://fuseki1.get-it.it/manufacturers") %>%
        httr2::req_url_query(query = componentType_query) %>%
        httr2::req_method("POST") %>%
        httr2::req_headers(Accept = "application/sparql-results+json") %>%
        httr2::req_retry(max_tries = 3, max_seconds = 120) %>%
        httr2::req_perform()
      httr2::resp_check_status(componentType_qr)
      componentType_JSON <- httr2::resp_body_json(componentType_qr)
      component_type_def <- componentType_JSON$results$bindings[[1]]$c$value
      e <- xml2::xml_add_child(c, "sml:classification") %>%
        xml2::xml_add_child(., "sml:ClassifierList")
      xml2::xml_add_child(e, "sml:classifier") %>%
        xml2::xml_add_child(., "sml:Term", "definition" = "http://www.opengis.net/def/property/OGC/0/SensorType") %>%
        xml2::xml_add_child(., "sml:label", component_info$sensor_type) %>%
        xml2::xml_add_sibling(., "sml:value", component_type_def)
    }
    
    # sml:capabilities
    if (!is.na(component_info$accuracy) |
        !is.na(component_info$measurement_range) |
        !is.na(component_info$operating_depth) |
        !is.na(component_info$precision) |
        !is.na(component_info$resolution) |
        !is.na(component_info$sensitivity) |
        !is.na(component_info$minimum_reporting_frequency) |
        !is.na(component_info$mobile) |
        !is.na(component_info$insitu)) {
      g <- xml2::xml_add_child(c, "sml:capabilities", "name" = "capabilities") %>%
        xml2::xml_add_child(., "sml:CapabilityList")
      # for SPARQL query ----
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
      if (!is.na(component_info$accuracy)) {
        uom_nerc_query <- paste0(
          uom_query_I_part,
          component_info$accuracy_uom,
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
        if (grepl("\\s+", component_info$accuracy)) {
          xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
            xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = component_info$accuracy_uom, "xlink:href" = accuracy_uom_def) %>%
            xml2::xml_add_sibling(., "swe:value", component_info$accuracy)
        } else {
          if (grepl("[0-9]", component_info$accuracy)) {
            xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
              xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
              xml2::xml_add_child(., "swe:uom", "code" = component_info$accuracy_uom, "xlink:href" = accuracy_uom_def) %>%
              xml2::xml_add_sibling(., "swe:value", component_info$accuracy)
          } else {
            xml2::xml_add_child(g, "sml:capability", "name" = "Accuracy") %>%
              xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0001/") %>%
              xml2::xml_add_child(., "swe:value", component_info$accuracy)
          }
        }
      }
      # sml:capabilities - MeasurementRange
      if (!is.na(component_info$measurement_range)) {
        uom_nerc_query <- paste0(
          uom_query_I_part,
          component_info$accuracy_uom,
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
          xml2::xml_add_child(., "swe:uom", "code" = component_info$measurement_range_uom, "xlink:href" = measurement_range_uom_def) %>%
          xml2::xml_add_sibling(., "swe:value", component_info$measurement_range)
      }
      # sml:capabilities - OperatingDepth
      if (!is.na(component_info$operating_depth)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "OperatingDepth") %>%
          xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0012/") %>%
          xml2::xml_add_child(., "swe:uom", "code" = "m", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/ULAA/") %>%
          xml2::xml_add_sibling(., "swe:value", component_info$operating_depth)
      }
      # sml:capabilities - Precision
      if (!is.na(component_info$precision)) {
        uom_nerc_query <- paste0(
          uom_query_I_part,
          component_info$accuracy_uom,
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
          xml2::xml_add_child(., "swe:uom", "code" = component_info$precision_uom, "xlink:href" = precision_uom_def) %>%
          xml2::xml_add_sibling(., "swe:value", component_info$precision)
      }
      # sml:capabilities - Resolution
      if (!is.na(component_info$resolution)) {
        uom_nerc_query <- paste0(
          uom_query_I_part,
          component_info$accuracy_uom,
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
        resolution_uom_def <- nercUOM_JSON$results$bindings[[1]]$c$value
        if (grepl("\\s+", component_info$resolution)) {
          xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
            xml2::xml_add_child(., "swe:QuantityRange", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
            xml2::xml_add_child(., "swe:uom", "code" = component_info$resolution_uom, "xlink:href" = resolution_uom_def) %>%
            xml2::xml_add_sibling(., "swe:value", component_info$resolution)
        } else {
          if (grepl("[0-9] [0-9]", component_info$resolution)) {
            xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
              xml2::xml_add_child(., "swe:Quantity", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
              xml2::xml_add_child(., "swe:uom", "code" = component_info$resolution_uom, "xlink:href" = resolution_uom_def) %>%
              xml2::xml_add_sibling(., "swe:value", component_info$resolution)
          } else {
            xml2::xml_add_child(g, "sml:capability", "name" = "Resolution") %>%
              xml2::xml_add_child(., "swe:Text", "definition" = "http://vocab.nerc.ac.uk/collection/W04/current/CAPB0007/") %>%
              xml2::xml_add_sibling(., "swe:value", component_info$resolution)
          }
        }
      }  
      # sml:capabilities - Sensitivity
      if (!is.na(component_info$sensitivity)) {
        uom_nerc_query <- paste0(
          uom_query_I_part,
          component_info$accuracy_uom,
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
          xml2::xml_add_child(., "swe:uom", "code" = component_info$sensitivity_uom, "xlink:href" = sensitivity_uom_def) %>%
          xml2::xml_add_sibling(., "swe:value", component_info$sensitivity)
      }
      # sml:capabilities - MinimumReportingFrequency
      if (!is.na(component_info$minimum_reporting_frequency)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "MinimumReportingFrequency") %>%
          xml2::xml_add_child(., "swe:Quantity", "definition" = "https://www.w3.org/TR/vocab-ssn/#SSNSYSTEMFrequency") %>%
          xml2::xml_add_child(., "swe:uom", "code" = "s", "xlink:href" = "http://vocab.nerc.ac.uk/collection/P06/current/UTBB/") %>%
          xml2::xml_add_sibling(., "swe:value", component_info$minimum_reporting_frequency)
      }
      # sml:capabilities - Mobile
      if (!is.na(component_info$mobile)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "Mobile") %>%
          xml2::xml_add_child(., "swe:Boolean") %>%
          xml2::xml_add_child(., "swe:value", tolower(component_info$mobile))
      }
      # sml:capabilities - Insitu
      if (!is.na(component_info$insitu)) {
        xml2::xml_add_child(g, "sml:capability", "name" = "Insitu") %>%
          xml2::xml_add_child(., "swe:Boolean") %>%
          xml2::xml_add_child(., "swe:value", tolower(component_info$insitu))
      }
    }
    
    # sml:contacts
    if (!is.na(sensorList$manufacturer[1])) {
      contacts_query <- paste0("PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    SELECT ?c ?l
    WHERE {
      ?c rdf:type foaf:Organization.
      ?c foaf:name ?l.
      FILTER( REGEX( STR(?l), '",
      sensorList$manufacturer[1],
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
                            "codeListValue" = "originator", "manufacturer")
    }
    
    # sml:attachedTo
    if (!is.na(sensorList$model_name[1])) {
      model_name = sub(" ", "_", sensorList$model_name[1])
    } else {
      model_name = "model_name"
    }
    if (!is.na(sensorList$manufacturer[1])) {
      manufacturer = sub(" ", "_", sensorList$manufacturer[1])
    } else {
      manufacturer = "manufacturer"
    }
    xml2::xml_add_child(
      c,
      "sml:attachedTo",
      "xlink:title" = paste0(
        "http://registry.get-it.it/sensors/systemsType/",
        model_name, "/",
        manufacturer, "/",
        uuidsList[1]
      )
    )
    
    # swes:observableProperty
    xml2::xml_add_child(physicalComponentType_XML_base, "swes:observableProperty", "not_defined")
    # In case of obsProps in sensor component(s) is fill remove the comment above
  #   if (!is.na(component_info$observed_property)) {
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
  #     component_info$observed_property,
  #     "', 'i'))
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
  #     xml2::xml_add_child(physicalComponentType_XML_base, "swes:observableProperty", obsProp_rdf)
  #   } else {
  #     xml2::xml_add_child(physicalComponentType_XML_base, "swes:observableProperty", "not_defined")
  #   }
    
    # write file ----
    xml2::write_xml(
      physicalComponentType_XML_base,
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
}