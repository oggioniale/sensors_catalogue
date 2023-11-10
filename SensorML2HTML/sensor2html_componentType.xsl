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
    exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
    
    <xsl:strip-space elements="*" />
    
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
                <title>Sensor component description</title>
                
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
                                Sensor component
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
                                    <li><a class="d-inline-flex align-items-center rounded" href="#capabilities">Capabilities</a></li>
                                    <li><a class="d-inline-flex align-items-center rounded" href="#attactedTo">Attached to</a></li>
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
                                    <xsl:value-of select="//gml:name"/>
                                </p>
                                <p class="h4">
                                    <xsl:if test="//sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()">
                                        <a href="{//sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()}" target="_blank">
                                            <xsl:value-of select="//sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text()" />
                                        </a>
                                    </xsl:if>
                                    <div class="fs-6 mb-3">
                                        <ul class="list-group list-group-horizontal">
                                            <li class="list-group-item">
                                                <a href="{concat('http://getit.lteritalia.it/observations/service?service=SOS&amp;version=2.0.0&amp;request=DescribeSensor&amp;procedure=', //sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text(), '&amp;procedureDescriptionFormat=http%3A%2F%2Fwww.opengis.net%2Fsensorml%2F2.0')}" target="_blank">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filetype-yml" viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5L14 4.5ZM3.527 11.85h-.893l-.823 1.439h-.036L.943 11.85H.012l1.227 1.983L0 15.85h.861l.853-1.415h.035l.85 1.415h.908l-1.254-1.992 1.274-2.007Zm.954 3.999v-2.66h.038l.952 2.159h.516l.946-2.16h.038v2.661h.715V11.85h-.8l-1.14 2.596h-.025L4.58 11.85h-.806v3.999h.706Zm4.71-.674h1.696v.674H8.4V11.85h.791v3.325Z"></path>
                                                    </svg>
                                                    SensorML XML version
                                                </a>
                                            </li>
                                            <li class="list-group-item">
                                                <xsl:variable name="UUID" select="getit:substring-after-last(//sml:PhysicalComponent/gml:identifier[@codeSpace='uniqueID']/text(), '/')"/>
                                                <a href="{concat('http://rdfdata.get-it.it/sensors/componentsType/', $UUID)}" target="_blank">
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
                        <article class="my-3" id="capabilities">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Capabilities</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <!-- electricalRequirements -->
                                <xsl:if test="//sml:capabilities[@name='capabilities']/sml:CapabilityList">
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
                                            <xsl:if test="//sml:capability[@name='Accuracy']/swe:Quantity">
                                                <xsl:variable name="accuracyURI" select="//sml:capability[@name='Accuracy']/swe:Quantity/@definition"/>
                                                <xsl:variable name="accuracy_uomURI" select="//sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Accuracy']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Accuracy']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:capability[@name='Accuracy']/swe:QuantityRange">
                                                <xsl:variable name="accuracyURI" select="//sml:capability[@name='Accuracy']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="accuracy_uomURI" select="//sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Accuracy']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$accuracy_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Accuracy']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:capability[@name='Accuracy']/swe:Text">
                                                <xsl:variable name="accuracyURI" select="//sml:capability[@name='Accuracy']/swe:Text/@definition"/>
                                                <tr>
                                                    <td><a href="{$accuracyURI}" target="_blank">Accuracy</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Accuracy']/swe:Text/swe:value"/></td>
                                                    <td>-</td>
                                                </tr>
                                            </xsl:if>
                                            <!-- MeasurementRange -->
                                            <xsl:if test="//sml:capability[@name='MeasurementRange']/swe:QuantityRange">
                                                <xsl:variable name="measurementRangeURI" select="//sml:capability[@name='MeasurementRange']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="measurementRange_uomURI" select="//sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$measurementRangeURI}" target="_blank">Measurement Range</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$measurementRange_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='MeasurementRange']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- OperatingDepth -->
                                            <xsl:if test="//sml:capability[@name='OperatingDepth']/swe:Quantity">
                                                <xsl:variable name="operatingDepthURI" select="//sml:capability[@name='OperatingDepth']/swe:Quantity/@definition"/>
                                                <xsl:variable name="operatingDepth_uomURI" select="//sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$operatingDepthURI}" target="_blank">Operating Depth</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='OperatingDepth']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$operatingDepth_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='OperatingDepth']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Precision -->
                                            <xsl:if test="//sml:capability[@name='Precision']/swe:Quantity">
                                                <xsl:variable name="precisionURI" select="//sml:capability[@name='Precision']/swe:Quantity/@definition"/>
                                                <xsl:variable name="precision_uomURI" select="//sml:capability[@name='Precision']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$precisionURI}" target="_blank">Precision</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Precision']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$precision_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Precision']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Resolution -->
                                            <xsl:if test="//sml:capability[@name='Resolution']/swe:Quantity">
                                                <xsl:variable name="resolutionURI" select="//sml:capability[@name='Resolution']/swe:Quantity/@definition"/>
                                                <xsl:variable name="resolution_uomURI" select="//sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Resolution']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Resolution']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//sml:capability[@name='Resolution']/swe:QuantityRange">
                                                <xsl:variable name="resolutionURI" select="//sml:capability[@name='Resolution']/swe:QuantityRange/@definition"/>
                                                <xsl:variable name="resolution_uomURI" select="//sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$resolutionURI}" target="_blank">Resolution</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Resolution']/swe:QuantityRange/swe:value"/></td>
                                                    <td><a href='{$resolution_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Resolution']/swe:QuantityRange/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- Sensitivity -->
                                            <xsl:if test="//sml:capability[@name='Sensitivity']/swe:Quantity">
                                                <xsl:variable name="sensitivityURI" select="//sml:capability[@name='Sensitivity']/swe:Quantity/@definition"/>
                                                <xsl:variable name="sensitivity_uomURI" select="//sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$sensitivityURI}" target="_blank">Sensitivity</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='Sensitivity']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$sensitivity_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='Sensitivity']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                            <!-- MinimumReportingFrequency -->
                                            <xsl:if test="//sml:capability[@name='MinimumReportingFrequency']/swe:Quantity">
                                                <xsl:variable name="minimumReportingFrequencyURI" select="//sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/@definition"/>
                                                <xsl:variable name="minimumReportingFrequency_uomURI" select="//sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@xlink:href"/>
                                                <tr>
                                                    <td><a href="{$minimumReportingFrequencyURI}" target="_blank">Minimum Reporting Frequency</a></td>
                                                    <td><xsl:value-of select="//sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:value"/></td>
                                                    <td><a href='{$minimumReportingFrequency_uomURI}' target="_blank"><xsl:value-of select="//sml:capability[@name='MinimumReportingFrequency']/swe:Quantity/swe:uom/@code"/></a></td>
                                                </tr>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </xsl:if>
                            </div>
                        </article>
                        <article class="my-3" id="attactedTo">
                            <div class="bd-heading sticky-xl-top align-self-start mt-5 mb-3 mt-xl-0 mb-xl-2">
                                <h5>Attached to</h5>
                                <!--a class="d-flex align-items-center" href="../content/typography/">Documentation</a-->
                            </div>
                            <div>
                                <xsl:if test="//sml:attachedTo">
                                    <ul class="list-group">
                                        <xsl:for-each select="//sml:attachedTo">
                                            <li class="list-group-item">
                                                <xsl:variable name="attachedTO_SML" select="./@xlink:href"/>
                                                <a href='{./@xlink:title}' target='_blank'><xsl:value-of select="document($attachedTO_SML)//sml:PhysicalSystem/gml:name"/></a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:if>
                            </div>
                        </article>
                    </section>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>