<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:swes="http://www.opengis.net/swes/2.0"
    xmlns:sos="http://www.opengis.net/sos/2.0"
    xmlns:swe="http://www.opengis.net/swe/2.0"
    xmlns:sml="http://www.opengis.net/sensorml/2.0"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:sams="http://www.opengis.net/samplingSpatial/2.0"
    xmlns:sf="http://www.opengis.net/sampling/2.0"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:getit="http://rdfdata.get-it.it/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:j.0="http://xxx.com"
    exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
    
    <xsl:strip-space elements="*" />
    
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <meta name="description"
                    content="Human readable version of a sensor description from SensorML and describeSensor request"/>
                <meta name="author" content="Alessandro Oggioni"/>
                <link rel="icon" href="./images/icons/favicon.ico"/>
                <title>Sensor system description</title>
                
                <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/cheatsheet/"></link>
                    
                    
                    
                    <!-- Bootstrap core CSS -->
                    <link href="./bootstrap-5.1.3-dist/css/bootstrap.min.css" rel="stylesheet"></link>
                        
                        <style>
                            .bd-placeholder-img {
                            font-size: 1.125rem;
                            text-anchor: middle;
                            -webkit-user-select: none;
                            -moz-user-select: none;
                            user-select: none;
                            }
                            
                            @media (min-width: 768px) {
                            .bd-placeholder-img-lg {
                            font-size: 3.5rem;
                            }
                            }
                        </style>
                        
                        
                        <!-- Custom styles for this template -->
                        <link href="./bootstrap-5.1.3-examples/cheatsheet/cheatsheet.css" rel="stylesheet" />
            </head>
            <body class="bg-light">
                <header class="bd-header bg-dark py-3 d-flex align-items-stretch border-bottom border-dark">
                    <div class="container-fluid d-flex align-items-center">
                        <h1 class="d-flex align-items-center fs-4 text-white mb-0">
                            <img src="./images/logo1.svg" class="me-3" alt="Bootstrap" width="38" height="30"></img>
                                Sensor system
                        </h1>
                        <!--a href="../examples/cheatsheet-rtl/" class="ms-auto link-light" hreflang="ar">RTL cheatsheet</a-->
                    </div>
                </header>
                <aside class="bd-aside sticky-xl-top text-muted align-self-start mb-3 mb-xl-5 px-2">
                    <h2 class="h6 pt-4 pb-3 mb-4 border-bottom">Sensor description</h2>
                    <nav class="small" id="toc">
                        <ul class="list-unstyled">
                            <li class="my-2">
                                <button class="btn d-inline-flex align-items-center" data-bs-toggle="collapse" aria-expanded="true" data-bs-target="#contents-collapse" aria-controls="contents-collapse">Contents</button>
                                <ul class="list-unstyled ps-3 collapse show" id="contents-collapse" style="">
                                    <li><a class="d-inline-flex align-items-center rounded" href="#decription">Description</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#classification">Classification</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#characteristics">Characteristics</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#capabilities">Capabilities</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#contacts">Contacts</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#documentation">Documentation</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#components">Components</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#obsProp">Observed properties</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </aside>
                <div class="bd-cheatsheet container-fluid bg-body">
                    <section id="content">
                        <h2 class="sticky-xl-top fw-bold pt-3 pt-xl-5 pb-2 pb-xl-3">Contents</h2>
                        <article class="my-3" id="decription">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Description</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <p class="h1">
                                    <xsl:value-of select="//sml:PhysicalSystem/gml:name"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:if
                                        test="//sml:identification/sml:IdentifierList/sml:identifier/sml:Term[@definition='http://vocab.nerc.ac.uk/collection/W07/current/IDEN0006/']/sml:value/text()">
                                        <small class="text-muted">(<xsl:value-of
                                            select="//sml:identification/sml:IdentifierList/sml:identifier/sml:Term[@definition='http://vocab.nerc.ac.uk/collection/W07/current/IDEN0002/']/sml:value/text()"
                                        />)</small>
                                    </xsl:if>
                                </p>
                                <p class="h4">
                                    <xsl:if test="//sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text()">
                                        <a href="{//sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text()}" target="_blank">
                                            <xsl:value-of select="//sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text()" />
                                        </a>
                                    </xsl:if>
                                    <!--xsl:when test="//sml:identification/sml:IdentifierList/sml:identifier[@name='uniqueID']/sml:Term/sml:value/text()">
                                        <xsl:value-of select="//sml:identification/sml:IdentifierList/sml:identifier[@name='uniqueID']/sml:Term/sml:value/text()" />
                                    </xsl:when-->
                                    <div class="fs-6 mb-3">
                                        <ul class="list-group list-group-horizontal">
                                            <li class="list-group-item">
                                                <a href="{concat('http://getit.lteritalia.it/observations/service?service=SOS&amp;version=2.0.0&amp;request=DescribeSensor&amp;procedure=', //sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text(), '&amp;procedureDescriptionFormat=http%3A%2F%2Fwww.opengis.net%2Fsensorml%2F2.0')}" target="_blank">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filetype-yml" viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5L14 4.5ZM3.527 11.85h-.893l-.823 1.439h-.036L.943 11.85H.012l1.227 1.983L0 15.85h.861l.853-1.415h.035l.85 1.415h.908l-1.254-1.992 1.274-2.007Zm.954 3.999v-2.66h.038l.952 2.159h.516l.946-2.16h.038v2.661h.715V11.85h-.8l-1.14 2.596h-.025L4.58 11.85h-.806v3.999h.706Zm4.71-.674h1.696v.674H8.4V11.85h.791v3.325Z"></path>
                                                    </svg>
                                                    SensorML XML version
                                                </a>
                                            </li>
                                            <li class="list-group-item">
                                                <xsl:variable name="UUID" select="getit:substring-after-last(//sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text(), '/')"/>
                                                <a href="{concat('http://rdfdata.get-it.it/sensors/systemsType/', $UUID)}" target="_blank">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
                                                        <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
                                                        <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
                                                    </svg>
                                                    Turtle RDF version
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </p>
                                <div class="row row-cols-1 row-cols-md-2 g-4">
                                    <div class="col">
                                        <xsl:if test="//gml:description">
                                            <p>
                                                <xsl:value-of select="//gml:description"/>
                                            </p>
                                        </xsl:if>
                                    </div>
                                    <div class="col">
                                        <xsl:if test="//sml:documentation[@xlink:arcrole='image']">
                                            <figure class="figure">
                                                <xsl:for-each
                                                    select="//sml:documentation[@xlink:arcrole='image']/sml:DocumentList">
                                                    <a href="{sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank"
                                                        data-title="{sml:document/gmd:CI_OnlineResource/gmd:name/gco:CharacterString}" aria-hidden="true">
                                                        <img src="{sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" class="img-responsive" width="200"/>
                                                    </a>
                                                </xsl:for-each>
                                                <!--figcaption class="figure-caption">A caption for the above image.</figcaption-->
                                            </figure>
                                        </xsl:if>
                                    </div>
                                </div>
                                <xsl:if test="//sml:keywords/sml:KeywordList/sml:keyword">
                                    <b>Keywords</b>
                                    <ul class="list-group list-group-horizontal">
                                        <xsl:for-each select="//sml:PhysicalSystem/sml:keywords/sml:KeywordList/sml:keyword">
                                            <xsl:if test="not(contains(., 'http://')) and not(contains(., 'offering:')) and not(contains(., 'https://'))">
                                                <li class="list-group-item">
                                                    <a>
                                                        <xsl:value-of select="."/>
                                                    </a>
                                                </li>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="classification">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Classification</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <xsl:if test="//sml:classification/sml:ClassifierList/sml:classifier/sml:Term[@definition='http://www.opengis.net/def/property/OGC/0/SensorType']">
                                    <ul class="list-group">
                                        <xsl:for-each select="//sml:classification/sml:ClassifierList/sml:classifier">
                                            <li class="list-group-item">
                                                <a href='{./sml:Term/sml:value/text()}' target='_blank'><xsl:value-of select="./sml:Term/sml:label/text()"/></a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="characteristics">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Characteristics</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <!-- characteristics -->
                                <xsl:if test="//sml:characteristics[@name='characteristics']/sml:CharacteristicList/sml:characteristic[@name='physicalProperties']/swe:DataRecord/swe:field[@name='PhysicalProperties']/swe:DataRecord">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Physical characteristic</th>
                                                <th scope="col">Value</th>
                                                <th scope="col">unit of measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Material -->
                                            <xsl:if test="//swe:field[@name='Material']">
                                                <xsl:variable name="materialURI" select="//swe:field[@name='Material']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$materialURI}" target="_blank">Material</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='Material']/swe:Text/swe:description"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Weight -->
                                            <xsl:if test="//swe:field[@name='Weight']">
                                                <xsl:variable name="weightURI" select="//swe:field[@name='Weight']/swe:Quantity/@definition"/>
                                                <xsl:variable name="weight_uomURI" select="//swe:field[@name='Weight']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$weightURI}" target="_blank">Weight</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='Weight']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$weight_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='Weight']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Length -->
                                            <xsl:if test="//swe:field[@name='Length']">
                                                <xsl:variable name="lengthURI" select="//swe:field[@name='Length']/swe:Quantity/@definition"/>
                                                <xsl:variable name="length_uomURI" select="//swe:field[@name='Length']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$lengthURI}" target="_blank">Length</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='Length']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$length_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='Length']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Width -->
                                            <xsl:if test="//swe:field[@name='Width']">
                                                <xsl:variable name="widthURI" select="//swe:field[@name='Width']/swe:Quantity/@definition"/>
                                                <xsl:variable name="width_uomURI" select="//swe:field[@name='Width']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$widthURI}" target="_blank">Width</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='Width']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$width_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='Width']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Height -->
                                            <xsl:if test="//swe:field[@name='Height']">
                                                <xsl:variable name="heightURI" select="//swe:field[@name='Height']/swe:Quantity/@definition"/>
                                                <xsl:variable name="height_uomURI" select="//swe:field[@name='Height']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$heightURI}" target="_blank">Height</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='Height']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$height_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='Height']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                                <!-- electricalRequirements -->
                                <xsl:if test="//sml:characteristics[@name='characteristics']/sml:CharacteristicList/sml:characteristic[@name='electricalRequirements']/swe:DataRecord">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Electrical requirements</th>
                                                <th scope="col">Value(s)</th>
                                                <th scope="col">unit of measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- ElectricalCurrentType -->
                                            <xsl:if test="//swe:field[@name='ElectricalCurrentType']">
                                                <xsl:variable name="electricalCurrentTypeURI" select="//swe:field[@name='ElectricalCurrentType']/swe:Category/@definition"/>
                                                <tr>
                                                    <td><a href="{$electricalCurrentTypeURI}" target="_blank">Electrical Current Type</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='ElectricalCurrentType']/swe:Category/swe:value"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- InputPowerRange -->
                                            <xsl:if test="//swe:field[@name='InputPowerRange']">
                                                <xsl:variable name="inputPowerRangeURI" select="//swe:field[@name='InputPowerRange']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="inputPowerRange_uomURI" select="//swe:field[@name='InputPowerRange']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$inputPowerRangeURI}" target="_blank">Input Power Range</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='InputPowerRange']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$inputPowerRange_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='InputPowerRange']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- BatteryChargingCurrent -->
                                            <xsl:if test="//swe:field[@name='BatteryChargingCurrent']/swe:Quantity">
                                                <xsl:variable name="batteryChargingCurrentURI" select="//swe:field[@name='BatteryChargingCurrent']/swe:Quantity/@definition"/>
                                                <xsl:variable name="batteryChargingCurrent_uomURI" select="//swe:field[@name='BatteryChargingCurrent']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$batteryChargingCurrentURI}" target="_blank">Battery Charging Current</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='BatteryChargingCurrent']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$batteryChargingCurrent_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='BatteryChargingCurrent']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//swe:field[@name='BatteryChargingCurrent']/swe:QuantityRange">
                                                <xsl:variable name="batteryChargingCurrentURI" select="//swe:field[@name='BatteryChargingCurrent']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="batteryChargingCurrent_uomURI" select="//swe:field[@name='BatteryChargingCurrent']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$batteryChargingCurrentURI}" target="_blank">Battery Charging Current</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='BatteryChargingCurrent']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$batteryChargingCurrent_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='BatteryChargingCurrent']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//swe:field[@name='BatteryChargingCurrent']/swe:Text">
                                                <xsl:variable name="batteryChargingCurrentURI" select="//swe:field[@name='BatteryChargingCurrent']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$batteryChargingCurrentURI}" target="_blank">Battery Charging Current</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='BatteryChargingCurrent']/swe:Text/swe:value"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- BatteryOutput -->
                                            <xsl:if test="//swe:field[@name='BatteryOutput']/swe:Quantity">
                                                <xsl:variable name="batteryOutputURI" select="//swe:field[@name='BatteryOutput']/swe:Quantity/@definition"/>
                                                <xsl:variable name="batteryOutput_uomURI" select="//swe:field[@name='BatteryOutput']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$batteryOutputURI}" target="_blank">Battery Output</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='BatteryOutput']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$batteryOutput_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='BatteryOutput']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//swe:field[@name='BatteryOutput']/swe:QuantityRange">
                                                <xsl:variable name="batteryOutputURI" select="//swe:field[@name='BatteryOutput']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="batteryOutput_uomURI" select="//swe:field[@name='BatteryOutput']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$batteryOutputURI}" target="_blank">Battery Output</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='BatteryOutput']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$batteryOutput_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='BatteryOutput']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                                <!-- dataSpecifications -->
                                <xsl:if test="//sml:PhysicalSystem/sml:characteristics[@name='characteristics']/sml:CharacteristicList/sml:characteristic[@name='dataSpecifications']/swe:DataRecord">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Data specifications</th>
                                                <th scope="col">Value</th>
                                                <th scope="col">unit of measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- DataStorageType -->
                                            <xsl:if test="//swe:field[@name='DataStorageType']">
                                                <xsl:variable name="dataStorageTypeURI" select="//swe:field[@name='DataStorageType']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$dataStorageTypeURI}" target="_blank">Data Storage Type</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='DataStorageType']/swe:Text/swe:description"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- DataStorage -->
                                            <xsl:if test="//swe:field[@name='DataStorage']">
                                                <xsl:variable name="dataStorageURI" select="//swe:field[@name='DataStorage']/swe:Quantity/@definition"/>
                                                <xsl:variable name="dataStorage_uomURI" select="//swe:field[@name='DataStorage']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$dataStorageURI}" target="_blank">Data Storage</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='DataStorage']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$dataStorage_uomURI}' target="_blank"><xsl:value-of select="//swe:field[@name='DataStorage']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Dataformat -->
                                            <xsl:if test="//swe:field[@name='Dataformat']">
                                                <tr>
                                                    <td>Data Format</td>
                                                    <td><xsl:value-of select="//swe:field[@name='Dataformat']/swe:Text/swe:description"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                                <!-- transmissionMode -->
                                <xsl:if test="//sml:PhysicalSystem/sml:characteristics[@name='characteristics']/sml:CharacteristicList/sml:characteristic[@name='transmissionMode']/swe:DataRecord">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Transmission Mode</th>
                                                <th scope="col">Value</th>
                                                <th scope="col">unit of measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- TransmissionMode -->
                                            <xsl:if test="//swe:field[@name='TransmissionMode']">
                                                <xsl:variable name="transmissionModeURI" select="//swe:field[@name='TransmissionMode']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$transmissionModeURI}" target="_blank">Transmission Mode</a></td>
                                                    <td><xsl:value-of select="//swe:field[@name='TransmissionMode']/swe:Text/swe:description"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="capabilities">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Capabilities</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <!-- electricalRequirements -->
                                <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Capabilities</th>
                                                <th scope="col">Value(s)</th>
                                                <th scope="col">unit of measure</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- offeringID -->
                                            <!--xsl:if test="//sml:capability[@name='offeringID']">
                                                xxx
                                            </xsl:if-->
                                            <!-- Accuracy -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity">
                                                <xsl:variable name="accuracyURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/@definition"/>
                                                <xsl:variable name="accuracy_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange">
                                                <xsl:variable name="accuracyURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="accuracy_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text">
                                                <xsl:variable name="accuracyURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text/swe:value"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- MeasurementRange -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange">
                                                <xsl:variable name="measurementRangeURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="measurementRange_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$measurementRangeURI}" target="_blank">Measurement Range</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$measurementRange_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- OperatingDepth -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity">
                                                <xsl:variable name="operatingDepthURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/@definition"/>
                                                <xsl:variable name="operatingDepth_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$operatingDepthURI}" target="_blank">Operating Depth</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$operatingDepth_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Precision -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity">
                                                <xsl:variable name="precisionURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/@definition"/>
                                                <xsl:variable name="precision_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$precisionURI}" target="_blank">Precision</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$precision_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Resolution -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity">
                                                <xsl:variable name="resolutionURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/@definition"/>
                                                <xsl:variable name="resolution_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange">
                                                <xsl:variable name="resolutionURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="resolution_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Sensitivity -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity">
                                                <xsl:variable name="sensitivityURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/@definition"/>
                                                <xsl:variable name="sensitivity_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$sensitivityURI}" target="_blank">Sensitivity</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$sensitivity_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- MinimumReportingFrequency -->
                                            <xsl:if test="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity">
                                                <xsl:variable name="minimumReportingFrequencyURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/@definition"/>
                                                <xsl:variable name="minimumReportingFrequency_uomURI" select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$minimumReportingFrequencyURI}" target="_blank">Minimum Reporting Frequency</a></td>
                                                    <td><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$minimumReportingFrequency_uomURI}' target="_blank"><xsl:value-of select="//sml:PhysicalSystem/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="contacts">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Contacts of manufacturer</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <xsl:variable name="contactURI" select="//sml:contacts/sml:ContactList/sml:contact/@xlink:href"/> <!-- e.g. http://rdfdata.get-it.it/sensors/manufacturers/83 -->
                                <xsl:variable name="contactName" select="//sml:contacts/sml:ContactList/sml:contact/@xlink:title"/> <!-- e.g. Nortek -->
                                <xsl:variable name="contactXMLLodViewPage" select="concat('http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/manufacturers/query&amp;IRI=', $contactURI, '&amp;output=application/rdf+xml')"/> <!-- http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/manufacturers/query&IRI=http://rdfdata.get-it.it/sensors/manufacturers/83&output=application/rdf+xml -->
                                <xsl:variable name="contactJSONLodViewPage" select="concat('http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/manufacturers/query&amp;IRI=', $contactURI, '&amp;output=application/ld+json')"/> <!-- http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/manufacturers/query&IRI=http://rdfdata.get-it.it/sensors/manufacturers/83&output=application/ld+json -->
                                <xsl:if test="$contactURI">
                                    <div class="fs-2 mb-3">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16">
                                            <path d="M4 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1ZM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1Z"></path>
                                            <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V1Zm11 0H3v14h3v-2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V15h3V1Z"></path>
                                        </svg>
                                        <xsl:text> </xsl:text><a href="{document($contactXMLLodViewPage)//rdf:RDF/rdf:Description/foaf:homepage/@rdf:resource}" target="_blank"><xsl:value-of select="$contactName"/></a>
                                    </div>
                                    <div class="fs-6 mb-3">
                                        <ul class="list-group list-group-horizontal">
                                            <li class="list-group-item">
                                                <a href="{$contactXMLLodViewPage}" target="_blank">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filetype-yml" viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5L14 4.5ZM3.527 11.85h-.893l-.823 1.439h-.036L.943 11.85H.012l1.227 1.983L0 15.85h.861l.853-1.415h.035l.85 1.415h.908l-1.254-1.992 1.274-2.007Zm.954 3.999v-2.66h.038l.952 2.159h.516l.946-2.16h.038v2.661h.715V11.85h-.8l-1.14 2.596h-.025L4.58 11.85h-.806v3.999h.706Zm4.71-.674h1.696v.674H8.4V11.85h.791v3.325Z"></path>
                                                    </svg>
                                                    Manufacturer RDF-XML version
                                                </a>
                                            </li>
                                            <li class="list-group-item">
                                                <a href="{$contactJSONLodViewPage}" target="_blank">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
                                                        <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
                                                        <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
                                                    </svg>
                                                    Manufacturer JSON-LD version
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="documentation">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Documentation</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <div class="row row-cols-1 row-cols-md-2 g-4">
                                    <div class="col">
                                        <xsl:if test="contains(//sml:documentation[@xlink:arcrole='datasheet'], '.pdf')">
                                            <object data="{//sml:documentation[@xlink:arcrole='datasheet']/sml:DocumentList/sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" width="100%" height="100%" />                                              
                                        </xsl:if>
                                        <xsl:if test="not(contains(//sml:documentation[@xlink:arcrole='datasheet'], '.pdf'))">
                                            <p>You can <a href="{//sml:documentation[@xlink:arcrole='datasheet']/sml:DocumentList/sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}"> Click here to download the PDF.</a></p>
                                        </xsl:if>
                                    </div>
                                    <div class="col">
                                        <xsl:if test="//sml:documentation[@xlink:arcrole='image']">
                                            <figure class="figure">
                                                <xsl:for-each
                                                    select="//sml:documentation[@xlink:arcrole='image']/sml:DocumentList">
                                                    <a href="{sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank"
                                                        data-title="{sml:document/gmd:CI_OnlineResource/gmd:name/gco:CharacterString}" aria-hidden="true">
                                                        <img src="{sml:document/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" class="img-responsive" width="200"/>
                                                    </a>
                                                </xsl:for-each>
                                                <figcaption class="figure-caption">Figure of sensor</figcaption>
                                            </figure>
                                        </xsl:if>
                                    </div>
                                </div>
                            </div>
                        </article>
                        <xsl:if test="//sml:PhysicalSystem/sml:components/sml:ComponentList/sml:component">
                            <article class="my-3" id="components">
                                <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                    <h5>Components</h5>
                                    <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                                </div>
                                <div>
                                    <xsl:call-template name="componentContent" />
                                </div>
                            </article>
                        </xsl:if>
                        <article class="my-3" id="obsProp">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Observed properties</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <!-- TODO -->
                                <!--<xsl:variable name="UUID" select="getit:substring-after-last(//sml:PhysicalSystem/gml:identifier[@codeSpace='uniqueID']/text(), '/')"/>
                                <xsl:variable name="RDF_URI" select="concat('http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/systemsType/query&amp;IRI=http://rdfdata.get-it.it/sensors/systemsType/', $UUID, '&amp;output=application/ld+json')"/> <!-\- http://lodview.get-it.it/lodview/?sparql=http://fuseki1.get-it.it/systemsType/query&IRI=http://rdfdata.get-it.it/sensors/systemsType/BE62542EAE3779425CA76390777943A5&output=application/ld+json -\->
                                <xsl:value-of select="parse-json(document($RDF_URI))"/>-->
                            </div>
                        </article>
                    </section>
                </div>
                <!-- Site footer -->
                <div>
                    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
                        <div class="col-md-4 d-flex align-items-center">
                            <!--a href="/" class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
                                <svg class="bi" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
                            </a>
                            <span class="mb-3 mb-md-0 text-body-secondary">2015 <a href="http://www.get-it.it" target="_blank">Geoinformation Enabling ToolkIT starterkit®</a></span-->
                        </div>
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:function name="getit:substring-after-last" as="xs:string" xmlns:getit="http://rdfdata.get-it.it/">
        <xsl:param name="value" as="xs:string?"/>
        <xsl:param name="separator" as="xs:string"/>        
        <xsl:choose>
            <xsl:when test="contains($value, $separator)">
                <xsl:value-of select="getit:substring-after-last(substring-after($value, $separator), $separator)" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$value" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template name="componentContent">
        <xsl:for-each select="//sml:PhysicalSystem/sml:components/sml:ComponentList/sml:component">
            <xsl:variable name="componentsPosition" select="position()" />
            <xsl:if test="not(//sml:PhysicalSystem/sml:components/sml:ComponentList/sml:component[$componentsPosition]/@xlink:href)">
                <div class="accordion-item">
                <h4 class="accordion-header" id="headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        <xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/gml:name"/>
                    </button>
                </h4>
                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                            <!--h5>Description</h5-->
                            <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                        </div>
                        <div>
                            <p class="h4">
                                <xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/gml:name"/>
                            </p>
                            <p class="h5">
                                <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()">
                                    <a href="{//sml:component[$componentsPosition]/sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()}" target="_blank">
                                        <xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()" />
                                    </a>
                                </xsl:if>
                                <!--xsl:when test="//sml:identification/sml:IdentifierList/sml:identifier[@name='uniqueID']/sml:Term/sml:value/text()">
                                        <xsl:value-of select="//sml:identification/sml:IdentifierList/sml:identifier[@name='uniqueID']/sml:Term/sml:value/text()" />
                                    </xsl:when-->
                                <div class="fs-6 mb-3">
                                    <ul class="list-group list-group-horizontal">
                                        <li class="list-group-item">
                                            <a href="{concat('http://getit.lteritalia.it/observations/service?service=SOS&amp;version=2.0.0&amp;request=DescribeSensor&amp;procedure=', //sml:component[$componentsPosition]/sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text(), '&amp;procedureDescriptionFormat=http%3A%2F%2Fwww.opengis.net%2Fsensorml%2F2.0')}" target="_blank">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filetype-yml" viewBox="0 0 16 16">
                                                    <path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5L14 4.5ZM3.527 11.85h-.893l-.823 1.439h-.036L.943 11.85H.012l1.227 1.983L0 15.85h.861l.853-1.415h.035l.85 1.415h.908l-1.254-1.992 1.274-2.007Zm.954 3.999v-2.66h.038l.952 2.159h.516l.946-2.16h.038v2.661h.715V11.85h-.8l-1.14 2.596h-.025L4.58 11.85h-.806v3.999h.706Zm4.71-.674h1.696v.674H8.4V11.85h.791v3.325Z"></path>
                                                </svg>
                                                SensorML XML version
                                            </a>
                                        </li>
                                        <li class="list-group-item">
                                            <xsl:variable name="attachedTO_SML" select="./@xlink:href"/>
                                            <a href="{document($attachedTO_SML)//sml:PhysicalSystem/gml:name}" target="_blank">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
                                                    <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
                                                    <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
                                                </svg>
                                                Turtle RDF version
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </p>
                        </div>
                        <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                            <h5>Classification</h5>
                            <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                        </div>
                        <div>
                            <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:classification/sml:ClassifierList/sml:classifier/sml:Term[@definition='http://www.opengis.net/def/property/OGC/0/SensorType']">
                                <ul class="list-group">
                                    <xsl:for-each select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:classification/sml:ClassifierList/sml:classifier">
                                        <li class="list-group-item">
                                            <a href='{./sml:Term/sml:value/text()}' target='_blank'><xsl:value-of select="./sml:Term/sml:label/text()"/></a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:if>
                        </div>
                        <br/>
                        <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                            <h5>Capabilities</h5>
                            <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                        </div>
                        <div>
                            <!-- electricalRequirements -->
                            <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th scope="col">Capabilities</th>
                                            <th scope="col">Value(s)</th>
                                            <th scope="col">unit of measure</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- offeringID -->
                                        <!--xsl:if test="//sml:capability[@name='offeringID']">
                                        xxx
                                    </xsl:if-->
                                        <!-- Accuracy -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity">
                                            <xsl:variable name="accuracyURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/@definition"/>
                                            <xsl:variable name="accuracy_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange">
                                            <xsl:variable name="accuracyURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/@definition"/>
                                            <xsl:variable name="accuracy_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:value"/></td>
                                                <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text">
                                            <xsl:variable name="accuracyURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text/@definition"/>
                                            <tr>
                                                <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Accuracy']/swe:Text/swe:value"/></td>
                                                <td>-</td>
                                            </tr>
                                        </xsl:if>
                                        <!-- MeasurementRange -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange">
                                            <xsl:variable name="measurementRangeURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/@definition"/>
                                            <xsl:variable name="measurementRange_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$measurementRangeURI}" target="_blank">Measurement Range</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:value"/></td>
                                                <td><a href='{$measurementRange_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <!-- OperatingDepth -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity">
                                            <xsl:variable name="operatingDepthURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/@definition"/>
                                            <xsl:variable name="operatingDepth_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$operatingDepthURI}" target="_blank">Operating Depth</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$operatingDepth_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <!-- Precision -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity">
                                            <xsl:variable name="precisionURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/@definition"/>
                                            <xsl:variable name="precision_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$precisionURI}" target="_blank">Precision</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$precision_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Precision']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <!-- Resolution -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity">
                                            <xsl:variable name="resolutionURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/@definition"/>
                                            <xsl:variable name="resolution_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange">
                                            <xsl:variable name="resolutionURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/@definition"/>
                                            <xsl:variable name="resolution_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:value"/></td>
                                                <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <!-- Sensitivity -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity">
                                            <xsl:variable name="sensitivityURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/@definition"/>
                                            <xsl:variable name="sensitivity_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$sensitivityURI}" target="_blank">Sensitivity</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$sensitivity_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                        <!-- MinimumReportingFrequency -->
                                        <xsl:if test="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity">
                                            <xsl:variable name="minimumReportingFrequencyURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/@definition"/>
                                            <xsl:variable name="minimumReportingFrequency_uomURI" select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@xlink:href"/>
                                            <tr>
                                                <td><a href="{$minimumReportingFrequencyURI}" target="_blank">Minimum Reporting Frequency</a></td>
                                                <td><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:value"/></td>
                                                <td><a href='{$minimumReportingFrequency_uomURI}' target="_blank"><xsl:value-of select="//sml:component[$componentsPosition]/sml:PhysicalComponent/sml:capabilities[@name='capabilities']/sml:CapabilityList/sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@code"/></a></td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                            </xsl:if>
                        </div>
                    </div>
                </div>
            </div>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>