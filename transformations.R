library(magrittr)
#  Manufacturers TTL ----
rdf_ttl_manufacturer(
  csv_path = "new_manufacturers.csv",
  last_number = 169
)
rdf_XML_manufacturer(
  csv_path = "new_manufacturers.csv",
  orcid_creator = "http://orcid.org/0000-0002-7997-219X",
  creator = "Alessandro Oggioni",
  last_number = 169
)
# Sensors XML ----
sensorML_sysTypeXML(
  csv_path = "../instruments/listOfInstruments.csv"
)
sensorML_compTypeXML(
  csv_path = "../instruments/listOfInstruments.csv"
)
# Sensors TTL
sensorMLType2rdf(
  file_path = "ID_system_BE62542EAE3779425CA76390777943A5.xml"
)
sensorMLType2rdf(
  file_path = "ID_component_4916747B0A11F3E17CF1A5A10E22ADA5.xml"
)
