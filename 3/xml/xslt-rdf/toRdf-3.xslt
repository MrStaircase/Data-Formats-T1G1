<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:s="http://example.com/schema-2">

    <xsl:output method="text" encoding="UTF-8" />

    <xsl:template match="/">
@prefix logo: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/logo/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix image: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/image/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix schema: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://schema.org/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix xsd: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>http://www.w3.org/2001/XMLSchema#<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .

# Data - Logos
<xsl:for-each select="//s:Logo">
  <xsl:variable name="logoIRI" select="@iri"/>
  <xsl:variable name="firstWithIRI" select="//s:Logo[@iri = $logoIRI][1]"/>
  <xsl:variable name="thisNode" select="."/>
  <xsl:apply-templates select=".[count($thisNode | $firstWithIRI) = count($firstWithIRI)]"/>
</xsl:for-each>
</xsl:template>
    <xsl:template match="s:Logo">
logo:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/logo/')"/> a schema:ImageObject;
    schema:image image:<xsl:value-of select="replace(normalize-space(s:Image), '^.*([0-9]+)$', '$1')"/>;
    schema:uploadDate "<xsl:value-of select="s:Creation_date"/>"^^xsd:date.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>
