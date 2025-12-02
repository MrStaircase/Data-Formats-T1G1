<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:s="http://example.com/schema-2">

    <xsl:output method="text" encoding="UTF-8" />
<!-- The disable-output-escaping has been used since it's valid on the site that was mentioned on the tutorial slides-->
    <xsl:template match="/">
@prefix ex: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/vocabulary/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix emp: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/employee/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix cus: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/customer/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix logo: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/logo/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix image: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/image/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix shop: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/shop/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix prod: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://example.org/resource/product/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .

@prefix schema: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://schema.org/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix rdf: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://www.w3.org/1999/02/22-rdf-syntax-ns#<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix rdfs: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>https://www.w3.org/2000/01/rdf-schema#<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix xsd: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>http://www.w3.org/2001/XMLSchema#<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .
@prefix foaf: <xsl:text disable-output-escaping="yes">&lt;</xsl:text>http://xmlns.com/foaf/0.1/<xsl:text disable-output-escaping="yes">&gt;</xsl:text> .

# Actual Data

# Data - Logos
<xsl:apply-templates select="//s:Logo[not(@iri = preceding::s:Logo/@iri)]"/>
# Data - Shops
<xsl:apply-templates select="//s:Shop"/>
# Data - Customers
<xsl:apply-templates select="//s:Visitor[not(@iri = preceding::s:Visitor/@iri)]" mode="customer"/>
# Data - Employees
<xsl:apply-templates select="//s:Employee" mode="employee"/>
# Data - Products
<xsl:apply-templates select="//s:Product" mode="product"/>

# Relations

    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> customer
<xsl:apply-templates select="//s:Shop" mode="rel-customer"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> employee
<xsl:apply-templates select="//s:Shop" mode="rel-employee"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> product
<xsl:apply-templates select="//s:Shop" mode="rel-product"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> logo
<xsl:apply-templates select="//s:Shop" mode="rel-logo"/>
    # Relation - product -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> employee
<xsl:apply-templates select="//s:Product" mode="prod-manuf"/>

    </xsl:template>

    <xsl:template match="s:Shop">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> a schema:LocalBusiness;
    schema:legalName "<xsl:value-of select="lower-case(s:Name)"/>"@en;
    ex:capacity "<xsl:value-of select="s:Capacity"/>"^^xsd:integer.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Logo">
logo:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/logo/')"/> a schema:ImageObject;
    schema:image image:<xsl:value-of select="replace(normalize-space(s:Image), '^.*([0-9]+)$', '$1')"/>;
    schema:uploadDate "<xsl:value-of select="s:Creation_date"/>"^^xsd:date.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Product" mode="product">
prod:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/product/')"/> a schema:Product;
    schema:name "<xsl:value-of select="s:Name"/>"@en;
    ex:preparationTime "<xsl:value-of select="s:Preparation_time"/>"^^xsd:integer;
    ex:price "<xsl:value-of select="s:Price"/>"^^xsd:integer.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Visitor" mode="customer">
cus:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/customer/')"/> a ex:Customer;
    foaf:nick "<xsl:value-of select="s:Nickname"/>"@en;
    ex:numberOfVisits "<xsl:value-of select="s:Number_of_visits"/>"^^xsd:integer;
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Employee" mode="employee">
emp:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/employee/')"/> a ex:Employee;
    schema:identifier "<xsl:value-of select="s:Id"/>"^^xsd:string;
    ex:salary "<xsl:value-of select="s:Salary"/>"^^xsd:integer;
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en<xsl:if test="s:Phone_number">;
    foaf:phone <xsl:apply-templates select="s:Phone_number"/></xsl:if>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Phone_number">
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="."/><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
        <xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="s:Shop" mode="rel-customer">
        <xsl:if test="s:Visitors/s:Visitor">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> ex:serves <xsl:apply-templates select="s:Visitors/s:Visitor"/>.
<xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Visitor">
        cus:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/customer/')"/><xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="s:Shop" mode="rel-employee">
        <xsl:if test="s:Employees/s:Employee">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:employee emp:<xsl:value-of select="substring-after(s:Employees/s:Employee/@iri, 'https://example.org/resource/employee/')"/>.
<xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Shop" mode="rel-product">
        <xsl:if test="s:Products/s:Product">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:owns <xsl:apply-templates select="s:Products/s:Product" mode="rel"/>.
<xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Product" mode="rel">
        prod:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/product/')"/><xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="s:Shop" mode="rel-logo">
        <xsl:if test="s:Logo">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:logo logo:<xsl:value-of select="substring-after(s:Logo/@iri, 'https://example.org/resource/logo/')"/>.
<xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Product" mode="prod-manuf">
        <xsl:variable name="prodIRI" select="@iri"/>
        <xsl:variable name="manufacturers" select="//s:Employee[s:ProductRef/@iri = $prodIRI]"/>
        <xsl:if test="$manufacturers">
prod:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/product/')"/> ex:hasManufactor <xsl:apply-templates select="$manufacturers" mode="manuf"/>.
<xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="s:Employee" mode="manuf">
        emp:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/employee/')"/><xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>
