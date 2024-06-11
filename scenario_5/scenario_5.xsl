
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  
  <!-- defines a key named "deliveryServiceKey" that matches elements with the name "DeliveryService" in the XML document. The key is based on the value of the elements themselves. -->
  <xsl:key name="deliveryServiceKey" match="DeliveryService" use="."/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Delivery Service Summary</title>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            background-color: #E6E6FA;
            border: 1px solid floralwhite;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #D8BFD8;
            color: #e6eaee;
          }
        </style>
      </head>
      <body>
        <!-- There are two summary tables, here is the first one with two columns:"Delivery Service" and "Usage Count", which summarizes the usage count for each delivery service -->
        <h2>Delivery Service Usage Summary</h2>
        <table>
          <tr>
            <th>Delivery Service</th>
            <th>Usage Count</th>
          </tr>
          <!-- applying templates to unique instances of <DeliveryService> elements using the defined key. -->
          <xsl:apply-templates select="//DeliveryService[generate-id() = generate-id(key('deliveryServiceKey', .)[1])]"/>
        </table>
        <!-- This table summarizes the delivery service usage for each customer, which has columns for "Customer", "Delivery Co.", "Delivery Express", and "Collection Point". -->
        <h2>Customer Delivery Service Usage Summary</h2>
        <table>
          <tr>
            <th>Customer</th>
            <th>Delivery Co.</th>
            <th>Delivery Express</th>
            <th>Collection Point</th>
          </tr>
          <xsl:apply-templates select="//Customer"/>
        </table>
      </body>
    </html>
  </xsl:template>
<!-- This template matches <DeliveryService> elements. -->
  <xsl:template match="DeliveryService">
    <!-- It generates a table row (<tr>) with two cells: one for the delivery service name and one for the count of its occurrences. -->
    <tr>
      <td><xsl:value-of select="."/></td>
      <td><xsl:value-of select="count(key('deliveryServiceKey', .))"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="Customer">
    <tr>
      <td><xsl:value-of select="Name"/></td>
      <!-- This counts the orders with a delivery service of "Delivery Co." for the current customer, and similarly for the other delivery services. -->
      <td><xsl:value-of select="count(Order/Delivery[DeliveryService='Delivery Co.'])"/></td>
      <td><xsl:value-of select="count(Order/Delivery[DeliveryService='Delivery Express'])"/></td>
      <td><xsl:value-of select="count(Order/Delivery[DeliveryService='Collection Point'])"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
