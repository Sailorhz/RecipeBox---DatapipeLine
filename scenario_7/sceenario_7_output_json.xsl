<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="json" indent="yes"/>
  
  <!-- Key to calculate the number of orders placed by each customer -->
  <xsl:key name="customerOrders" match="Customer" use="Email"/>
  
  <!-- Main template -->
  <xsl:template match="/">
  <xsl:text>{&#10;</xsl:text>
    "Customer": [
      <!-- Sort customers based on the number of orders placed -->
      <xsl:variable name="sortedCustomers">
        <xsl:for-each select="RecipeBox/Customer">
          <xsl:sort select="count(key('customerOrders', Email)/Order)" data-type="number" order="descending"/>
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      
      <!-- Output the top 5 customers:"for-each" loop that iterates over the first 5 elements in the $sortedCustomers, position() refers to the current position of the context node in the current node list; &lt;= 5 : less than and equal to 5-->
      <xsl:for-each select="$sortedCustomers/*[position() &lt;= 5]">
        <!-- &#10; insert line breaks; &#9;indenting content -->
        <xsl:text>&#10;&#9;&#9;{ </xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"Name": "</xsl:text><xsl:value-of select="Name"/><xsl:text>",</xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"Gender": "</xsl:text><xsl:value-of select="Gender"/><xsl:text>",</xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"Birthday": "</xsl:text><xsl:value-of select="Birthday"/><xsl:text>",</xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"Email": "</xsl:text><xsl:value-of select="Email"/><xsl:text>",</xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"PhoneNo": "</xsl:text><xsl:value-of select="PhoneNo"/><xsl:text>",</xsl:text>
        <xsl:text>&#10;&#9;&#9;&#9;"Address": "</xsl:text><xsl:value-of select="Address"/><xsl:text>"</xsl:text>
        <!-- position() refers to the current position of the context node in the current node list. The condition checks if the current position is not equal to 5. -->
        <xsl:if test="position() != 5"><xsl:text>,</xsl:text></xsl:if>
        <xsl:text>&#10;&#9;&#9;}</xsl:text>
        <!-- The condition checks if the current position is not equal to last one -->
        <xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
        <xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#10;&#9;]&#10;</xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
