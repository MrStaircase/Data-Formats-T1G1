<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:s="http://example.com/schema-2">

    <xsl:output method="text" encoding="UTF-8" />

    <xsl:template match="/">
@prefix ex: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/vocabulary/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix cus: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/customer/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix xsd: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>http://www.w3.org/2001/XMLSchema#<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix foaf: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>http://xmlns.com/foaf/0.1/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .

<xsl:apply-templates select="//s:Shop"/>
# Data - Customers
<xsl:for-each-group select="//s:Visitor" group-by="@iri">
  <xsl:apply-templates select="current-group()[1]" mode="customer"/>
</xsl:for-each-group>
</xsl:template>

    <xsl:template match="s:Visitor" mode="customer">
cus:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/customer/')"/> a ex:Customer;
    foaf:nick "<xsl:value-of select="s:Nickname"/>"@en;
    ex:numberOfVisits "<xsl:value-of select="s:Number_of_visits"/>"^^xsd:integer;
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Visitor" mode="add-visitor-comma">,<xsl:text>
                 </xsl:text></xsl:template>

    <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>
