<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" expand-text="yes">
  <xsl:output method="html"/>
  
  <!-- Define CSS styles for the table -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Recipe Performance</title>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            background-color: #aabd66;
            border: 1px solid floralwhite;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #fdbb2d;
            color: #e6eaee;
          }
        </style>
      </head>
      <body>
        <h2>Recipe Performance</h2>
        
        <!-- the HTML table -->
        <table>
          <tr>
            <th>Recipe Title</th>
            <th>Price (EUR)</th>
            <th>Total Quantity Sold</th>
            <th>Revenue (EUR)</th>
            <th>Average Rating</th>
          </tr>
          <!-- Iterate over each recipe sorted by quantity sold -->
          <xsl:for-each select="/RecipeBox/Recipe">
            <xsl:sort select="sum(/RecipeBox/Customer/Order/Content[RecipeId = current()/Id]/Quantity)" data-type="number" order="descending"/>
            <xsl:variable name="recipeId" select="Id"/>
            <xsl:variable name="totalQuantitySold" select="sum(/RecipeBox/Customer/Order/Content[RecipeId = $recipeId]/Quantity)"/>
            <xsl:variable name="revenue" select="$totalQuantitySold * Price"/>
            <xsl:variable name="averageRating" select="avg(Review/Rating)"/>
    
            <!-- Output recipe Performance -->
            <tr>
              <td><xsl:value-of select="Title"/></td>
              <td><xsl:value-of select="Price"/></td>
              <td><xsl:value-of select="$totalQuantitySold"/></td>
              <td><xsl:value-of select="format-number($revenue, '#.##')"/></td>
              <td><xsl:value-of select="format-number($averageRating, '#.##')"/></td>
            </tr>
          </xsl:for-each>
        </table>
        <!-- End of the HTML table -->
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
