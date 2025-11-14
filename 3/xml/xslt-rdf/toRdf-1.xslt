<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:output method="text" encoding="UTF-8" />
    <xsl:variable name="prefix">https://ex.org/resource/</xsl:variable>
    
    <xsl:template match="/">
    @prefix ex: &lt;https://example.org/vocabulary/&gt; .
    @prefix emp: &lt;https://example.org/resource/employee/&gt; .
    @prefix cus: &lt;https://example.org/resource/customer/&gt; .
    @prefix logo: &lt;https://example.org/resource/logo/&gt; .
    @prefix image: &lt;https://example.org/resource/image/&gt; .
    @prefix shop: &lt;https://example.org/resource/shop/&gt; .
    @prefix prod: &lt;https://example.org/resource/product/&gt; .

    @prefix schema: &lt;https://schema.org/&gt; .
    @prefix rdf: &lt;https://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
    @prefix rdfs: &lt;https://www.w3.org/2000/01/rdf-schema#&gt; .
    @prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
    @prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; 
    
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

    # Data - Logos
    <xsl:apply-templates select="//Logo"/>
    # Data - Shops
    <xsl:apply-templates mode="M1"/>
    # Data - Customers
    <xsl:apply-templates select="//Visitor"/>
    # Data - Employees
    <xsl:apply-templates select="//Employee"/>

    # Data - Products
    <xsl:apply-templates select="//Product"/>


    # TEST
    <xsl:apply-template match="Shop" mode="M2"/>
    </xsl:template>

    <xsl:template match="Shop" mode="M1">
    <xsl:variable name="ShopIRI" select="concat('shop/', fn:position())"/>
    <xsl:value-of select="$ShopIRI"/> a schema:LocalBusiness ;
    schema:legalName <xsl:value-of select="Name"/> ;
    ex:capacity <xsl:value-of select="Capacity"/> .
    </xsl:template>
    
    <xsl:template match="//Logo">
    <xsl:variable name="LogoIRI" select="concat('logo/', fn:position())"/>
    <xsl:value-of select="$LogoIRI"/> a schema:ImageObject ;
    schema:image <xsl:value-of select="Image"/>;
    schema:uploadDate <xsl:value-of select="Creation_date"/> .
    </xsl:template>
        
    <xsl:template match="Shop" mode="M2">
    <xsl:variable name="ShopIRI" select="concat('shop/', fn:position())"/>
    <xsl:value-of select="$ShopIRI"/> a schema:LocalBusiness ;
    schema:legalName <xsl:value-of select="Name"/> ;
    ex:capacity <xsl:value-of select="Capacity"/> .
    </xsl:template>

    <xsl:template match="Visitor">
    <xsl:variable name="CustomerIRI" select="concat('cus/', fn:position())"/>
    <xsl:value-of select="$CustomerIRI"/> a ex:Customer ;
    foaf:nick <xsl:value-of select="Nickname"/> ;
    ex:numberOfVisits <xsl:value-of select="Number_of_visits"/> ;
    ex:fullName <xsl:value-of select="Fullname"/> .
    </xsl:template>

    <xsl:template match="Employee">
    <xsl:variable name="EmployeeIRI" select="concat('emp/', fn:position())"/>
    <xsl:value-of select="$EmployeeIRI"/> a ex:Employee ;
    schema:identifier <xsl:value-of select="Id"/>
    ex:salary <xsl:value-of select="Salary"/> ;
    ex:fullName <xsl:value-of select="Fullname"/> .
    </xsl:template>

    <xsl:template match="Product">
    <xsl:variable name="ProductIRI" select="concat('prod/', fn:position())"/>
    <xsl:value-of select="$ProductIRI"/> a schema:Product ;
    schema:name <xsl:value-of select="Name"/>
    ex:preparationTime <xsl:value-of select="Preparation_time"/> ;
    ex:price <xsl:value-of select="Price"/> .
    </xsl:template>
    <xsl:template match="text()" mode="#all"/>
</xsl:stylesheet>


