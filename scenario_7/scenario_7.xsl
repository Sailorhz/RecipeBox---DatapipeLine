<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  
  <!-- Key to calculate the number of orders placed by each customer -->
  <xsl:key name="customerOrders" match="Customer" use="Email"/>
  
  <!-- Main template -->
  <xsl:template match="/">
    <!-- Inside the <head> element, a <style> block defines CSS styles for the HTML output to resemble JSON. the style is mainly about the intent of content and the colors.-->
    <html>
    <head>
      <style>
        p {
        padding-left: 25px;
        }
        <!-- CSS classes (json-key, json-string, json-number) are used to style different parts of the JSON representation. -->
        .json-key { 
        color: blue; 
        padding-left: 50px;
        }
        .json-string { color: green; }
        .json-number { color: red; }
      </style>
    </head>
    <body>
      {
      <br/>
      <div class="json-object">
        <span class="json-key">"Customer"</span>: [
        <div class="json-array">
          <div class="json-array">
            <xsl:variable name="sortedCustomers">
              <!-- This XPath expression selects all <Customer> elements that are children of the <RecipeBox> element to loop over each <Customer> element  -->
              <xsl:for-each select="RecipeBox/Customer">
                <!-- <Customer> elements are sorted in descending order based on the number of orders each customer has placed, with those having more orders appearing first in the sorted list. -->
                <xsl:sort select="count(key('customerOrders', Email)/Order)" data-type="number" order="descending"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:for-each select="$sortedCustomers/*[position() &lt;= 5]">
              <div class="json-object">
                <p>{</p>
                <br/>
                <span class="json-key">"Name"</span>: <span class="json-string">"<xsl:value-of select="Name"/>"</span>,
                <br/>
                <span class="json-key">"Gender"</span>: <span class="json-string">"<xsl:value-of select="Gender"/>"</span>,
                <br/>
                <span class="json-key">"Birthday"</span>: <span class="json-string">"<xsl:value-of select="Birthday"/>"</span>,
                <br/>
                <span class="json-key">"Email"</span>: <span class="json-string">"<xsl:value-of select="Email"/>"</span>,
                <br/>
                <span class="json-key">"PhoneNo"</span>: <span class="json-string">"<xsl:value-of select="PhoneNo"/>"</span>,
                <br/>
                <span class="json-key">"Address"</span>: <span class="json-string">"<xsl:value-of select="Address"/>"</span>
                <br/>

                <p>}<xsl:if test="position() != last()">,</xsl:if></p>
              </div>
            </xsl:for-each>
          </div>
       </div>
      </div>      
    </body>
    </html>
    <p>]</p>
    <br/>
  }
  <br/>
  </xsl:template>
  
</xsl:stylesheet>
