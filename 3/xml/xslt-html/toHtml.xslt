<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:s="http://example.com/schema-2"
                version="1.0">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
        </xsl:text>
        <html lang="en">
            <head>
                <title>Employee contact by Product</title>
            </head>
            <body>
                <h1>Employee contact by Product</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
   
    <xsl:template match="s:Shop">
        <xsl:if test="s:Employees/s:Employee/s:ProductRef/@iri = s:Products/s:Product/@iri">
            <h2><xsl:value-of select="s:Name"/></h2>
            <h3> Products</h3>
            <ul>
                <xsl:apply-templates select="s:Products/s:Product"/>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Product">
        <xsl:variable name="p_iri" select="@iri"></xsl:variable>
        <xsl:if test="../../s:Employees/s:Employee[s:ProductRef/@iri = $p_iri]">
            <li><xsl:value-of select="s:Name"/>
            </li>
            <h4>Employees</h4>
            <ul>
                <xsl:apply-templates select="../../s:Employees/s:Employee[s:ProductRef/@iri = $p_iri]"/>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Employee">
        <li><xsl:value-of select="s:Fullname"/>: <xsl:value-of select="s:Phone_number"/></li>
    </xsl:template>
   
    <xsl:template match="text()"/>
   
</xsl:stylesheet>

<!-- For each shop list the products of the shop and 
the employee's name that can make that product and phone if they have it -->
