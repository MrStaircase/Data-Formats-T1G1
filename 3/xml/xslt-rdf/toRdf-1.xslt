<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:s="http://example.com/schema-2">

    <xsl:output method="text" encoding="UTF-8" />

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

# Property Definitions

ex:capacity a rdf:Property;
    rdfs:label "capacity"@en;
    rdfs:description "The amount of customers that the business can handle."@en;
    rdfs:domain schema:LocalBusiness;
    rdfs:range xsd:integer.

ex:salary a rdf:Property;
    rdfs:label "salary"@en;
    rdfs:description "The amount of CZK that the employee gets every month."@en;
    rdfs:domain ex:Employee;
    rdfs:range xsd:integer.

ex:numberOfVisits a rdf:Property;
    rdfs:label "number of visits"@en;
    rdfs:description "The number of times that a customer has visited any of the shops"@en;
    rdfs:domain ex:Customer;
    rdfs:range xsd:integer.

ex:fullName a rdf:Property;
    rdfs:label "full name"@en;
    rdfs:description "The full name of the person"@en;
    rdfs:domain foaf:Person;
    rdfs:range rdf:langString.

ex:preparationTime a rdf:Property;
    rdfs:label "preparation time"@en;
    rdfs:description "The amount of time, in minutes, it takes to make this product"@en;
    rdfs:domain schema:Product;
    rdfs:range xsd:integer.

ex:price a rdf:Property;
    rdfs:label "price"@en;
    rdfs:description "The price, in CZK, of the product"@en;
    rdfs:domain schema:Product;
    rdfs:range xsd:integer.

ex:hasManufactor a rdf:Property;
    rdfs:label "has manufactor"@en;
    rdfs:description "This product can be made by an employee"@en;
    rdfs:domain schema:Product;
    rdfs:range ex:Employee.

ex:serves a rdf:Property;
    rdfs:label "serves"@en;
    rdfs:description "This business serves a customer"@en;
    rdfs:domain schema:LocalBusiness;
    rdfs:range ex:Customer.

# Class Definitions

ex:Employee a rdfs:Class;
    rdfs:label "Employee"@en;
    rdfs:description "An employee"@en;
    rdfs:subClassOf foaf:Person.

ex:Customer a rdfs:Class;
    rdfs:label "Customer"@en;
    rdfs:description "A customer"@en;
    rdfs:subClassOf foaf:Person.

# Actual Data

# Data - Logos
<xsl:for-each-group select="//s:Logo" group-by="@iri">
  <xsl:apply-templates select="current-group()[1]"/>
</xsl:for-each-group>
# Data - Shops
<xsl:apply-templates select="//s:Shop"/>
# Data - Customers
<xsl:for-each-group select="//s:Visitor" group-by="@iri">
  <xsl:apply-templates select="current-group()[1]" mode="customer"/>
</xsl:for-each-group>
# Data - Employees
<xsl:for-each select="//s:Employee">
  <xsl:variable name="empIRI" select="@iri"/>
  <xsl:variable name="firstWithIRI" select="//s:Employee[@iri = $empIRI][1]"/>
  <xsl:variable name="thisNode" select="."/>
  <xsl:apply-templates select=".[count($thisNode | $firstWithIRI) = count($firstWithIRI)]" mode="employee"/>
</xsl:for-each>
# Data - Products
<xsl:for-each select="//s:Product">
  <xsl:variable name="prodIRI" select="@iri"/>
  <xsl:variable name="firstWithIRI" select="//s:Product[@iri = $prodIRI][1]"/>
  <xsl:variable name="thisNode" select="."/>
  <xsl:apply-templates select=".[count($thisNode | $firstWithIRI) = count($firstWithIRI)]" mode="product"/>
</xsl:for-each>

# Relations

    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> customer
<xsl:apply-templates select="//s:Shop[s:Visitors/s:Visitor]" mode="rel-customer"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> employee
<xsl:apply-templates select="//s:Shop[s:Employees/s:Employee]" mode="rel-employee"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> product
<xsl:apply-templates select="//s:Shop[s:Products/s:Product]" mode="rel-product"/>
    # Relation - shop -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> logo
<xsl:apply-templates select="//s:Shop[s:Logo]" mode="rel-logo"/>
    # Relation - product -<xsl:text disable-output-escaping="yes">&gt;</xsl:text> employee
<xsl:for-each-group select="//s:ProductRef" group-by="@iri">
  <xsl:variable name="prodIRI" select="@iri"/>
  <xsl:variable name="prodNode" select="//s:Product[@iri = $prodIRI][1]"/>
  <xsl:if test="$prodNode">
    <xsl:apply-templates select="$prodNode" mode="prod-manuf">
      <xsl:with-param name="prodIRI" select="$prodIRI"/>
    </xsl:apply-templates>
  </xsl:if>
</xsl:for-each-group>


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
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en<xsl:apply-templates select="s:Phone_number[1]" mode="phone-start"/>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Phone_number" mode="phone-start">;<xsl:text>
    </xsl:text>foaf:phone <xsl:for-each select="../s:Phone_number"><xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="."/><xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:variable name="thisPhone" select="."/><xsl:apply-templates select="../s:Phone_number[. &gt;&gt; $thisPhone][1]" mode="add-phone-comma"/></xsl:for-each></xsl:template>

    <xsl:template match="s:Phone_number" mode="add-phone-comma">,<xsl:text>
        </xsl:text></xsl:template>

    <xsl:template match="s:Shop" mode="rel-customer">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> ex:serves <xsl:for-each select="s:Visitors/s:Visitor">cus:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/customer/')"/><xsl:variable name="thisVisitor" select="."/><xsl:apply-templates select="../s:Visitor[. &gt;&gt; $thisVisitor][1]" mode="add-visitor-comma"/></xsl:for-each>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Visitor" mode="add-visitor-comma">,<xsl:text>
                 </xsl:text></xsl:template>

    <xsl:template match="s:Shop" mode="rel-employee">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:employee emp:<xsl:value-of select="substring-after(s:Employees/s:Employee/@iri, 'https://example.org/resource/employee/')"/>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Shop" mode="rel-product">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:owns <xsl:for-each select="s:Products/s:Product">prod:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/product/')"/><xsl:variable name="thisProduct" select="."/><xsl:apply-templates select="../s:Product[. &gt;&gt; $thisProduct][1]" mode="add-product-comma"/></xsl:for-each>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Product" mode="add-product-comma">,<xsl:text>
                   </xsl:text></xsl:template>

    <xsl:template match="s:Shop" mode="rel-logo">
shop:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/shop/')"/> schema:logo logo:<xsl:value-of select="substring-after(s:Logo/@iri, 'https://example.org/resource/logo/')"/>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Product" mode="prod-manuf">
        <xsl:param name="prodIRI"/>
        <xsl:variable name="manufacturers" select="//s:Employee[s:ProductRef/@iri = $prodIRI]"/>
prod:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/product/')"/> ex:hasManufactor <xsl:for-each select="$manufacturers">emp:<xsl:value-of select="substring-after(@iri, 'https://example.org/resource/employee/')"/><xsl:apply-templates select="." mode="check-more-manuf"><xsl:with-param name="allManuf" select="$manufacturers"/></xsl:apply-templates></xsl:for-each>.
<xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="s:Employee" mode="check-more-manuf">
        <xsl:param name="allManuf"/>
        <xsl:variable name="currentEmp" select="."/>
        <xsl:apply-templates select="$allManuf[. &gt;&gt; $currentEmp][1]" mode="add-comma"/>
    </xsl:template>

    <xsl:template match="s:Employee" mode="add-comma">,<xsl:text>
                        </xsl:text></xsl:template>

    <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>

