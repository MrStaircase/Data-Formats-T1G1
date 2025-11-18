<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:s="http://example.com/schema-2">
    <xsl:output method="text" encoding="UTF-8" />
    <xsl:variable name="prefix">https://ex.org/resource/</xsl:variable>
    
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
    <xsl:apply-templates select="//s:Logo"/>
    # Data - Shops
    <xsl:apply-templates select="//s:Shop"/>
    # Data - Customers
    <xsl:apply-templates select="//s:Visitor" mode="customer"/>
    # Data - Employees
    <xsl:apply-templates select="//s:Employee" mode="employee"/>

    # Data - Products
    <xsl:apply-templates select="//s:Product" mode="product"/>
    </xsl:template>

<xsl:template match="s:Shop">
    <xsl:value-of select="@iri"/> a schema:LocalBusiness;
    schema:legalName "<xsl:value-of select="s:Name"/>"@en;
    ex:capacity "<xsl:value-of select="s:Capacity"/>"^^xsd:integer;
    <xsl:apply-templates select="s:Products/s:Product" mode="shop-product"/>
    <xsl:apply-templates select="s:Logo" mode="shop-logo"/>
    <xsl:apply-templates select="s:Visitors/s:Visitor" mode="shop-visitor"/>
    <xsl:apply-templates select="s:Employees/s:Employee" mode="shop-employee"/>
    <xsl:apply-templates select="." mode="shop-end"/>.

</xsl:template>

<xsl:template match="s:Product" mode="shop-product">
    schema:owns <xsl:value-of select="@iri"/>;
</xsl:template>

<xsl:template match="s:Logo" mode="shop-logo">
    schema:logo <xsl:value-of select="@iri"/>;
</xsl:template>

<xsl:template match="s:Visitor" mode="shop-visitor">
    ex:serves <xsl:value-of select="@iri"/>;
</xsl:template>

<xsl:template match="s:Employee" mode="shop-employee">
    schema:employee <xsl:value-of select="@iri"/>;
</xsl:template>

<xsl:template match="s:Shop" mode="shop-end"/>

<xsl:template match="s:Logo">
    <xsl:value-of select="@iri"/> a schema:ImageObject;
    schema:image <xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="s:Image"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text>;
    schema:uploadDate "<xsl:value-of select="s:Creation_date"/>"^^xsd:date.

</xsl:template>

<xsl:template match="s:Product" mode="product">
    <xsl:variable name="productIRI" select="@iri"/>
    
    <xsl:value-of select="@iri"/> a schema:Product;
    schema:name "<xsl:value-of select="s:Name"/>"@en;
    ex:preparationTime "<xsl:value-of select="s:Preparation_time"/>"^^xsd:integer;
    ex:price "<xsl:value-of select="s:Price"/>"^^xsd:integer;
    <xsl:apply-templates select="../../../s:Employees/s:Employee[s:ProductRef[@iri = $productIRI]]" mode="product-manufacturer"/>
    <xsl:apply-templates select="." mode="product-end"/>.

</xsl:template>

<xsl:template match="s:Employee" mode="product-manufacturer">
    ex:hasManufactor <xsl:value-of select="@iri"/>;
</xsl:template>

<xsl:template match="s:Product" mode="product-end"/>

<xsl:template match="s:Visitor" mode="customer">
    <xsl:value-of select="@iri"/> a ex:Customer;
    foaf:nick "<xsl:value-of select="s:Nickname"/>"@en;
    ex:numberOfVisits "<xsl:value-of select="s:Number_of_visits"/>"^^xsd:integer;
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en.

</xsl:template>

<xsl:template match="s:Employee" mode="employee">
    <xsl:value-of select="@iri"/> a ex:Employee;
    schema:identifier "<xsl:value-of select="s:Id"/>"^^xsd:string;
    ex:salary "<xsl:value-of select="s:Salary"/>"^^xsd:integer;
    ex:fullName "<xsl:value-of select="s:Fullname"/>"@en;
    <xsl:apply-templates select="s:Phone_number" mode="phone"/>
    <xsl:apply-templates select="." mode="employee-end"/>.

</xsl:template>

<xsl:template match="s:Phone_number" mode="phone">
    foaf:phone <xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="."/><xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:apply-templates select="." mode="phone-separator"/>;
</xsl:template>

<xsl:template match="s:Phone_number[../s:Phone_number[2]]" mode="phone-separator">,</xsl:template>

<xsl:template match="s:Phone_number" mode="phone-separator"/>

<xsl:template match="s:Employee" mode="employee-end"/>

    <xsl:template match="text()" mode="#all"/>
</xsl:stylesheet>
