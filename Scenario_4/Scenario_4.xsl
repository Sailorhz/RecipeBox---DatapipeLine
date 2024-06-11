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
            background-color: #cbddbd;
            border: 1px solid floralwhite;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #4B6F44;
            color: #e6eaee;
          }
        </style>
      </head>
      <body>
        <h2>Healthy Food Win?</h2>
        
         <!-- the HTML table -->
        <table>
          <tr>
            <th>Health Category</th>
            <th>Recipe Title</th>
            <th>Price (EUR)</th>
            <th>Total Quantity Sold</th>
            <th>Revenue (EUR)</th>
            <th>Average Rating</th>
          </tr>
          <!-- Group recipes by health category -->
          <xsl:for-each-group select="/RecipeBox/Recipe" group-by="HealthCategory">
            <!-- Iterate over recipes within each health category -->
            <xsl:for-each select="current-group()">

<!-- sum(...): This calculates the sum of the values returned by the expression inside the parentheses.
/RecipeBox/Customer/Order/Content[RecipeId = current()/Id]/Quantity: The XPath selects the quantity (Quantity) from the Content elements where the RecipeId matches the current Id.
/Content[RecipeId = current()/Id]/Quantity: This selects the Quantity elements under Content elements where the RecipeId matches the current node's Id. current() is used to refer to the current node being sorted. -->
              <xsl:sort select="sum(/RecipeBox/Customer/Order/Content[RecipeId = current()/Id]/Quantity)" data-type="number" order="descending"/>
              <xsl:variable name="recipeId" select="Id"/>
              <xsl:variable name="totalQuantitySold" select="sum(/RecipeBox/Customer/Order/Content[RecipeId = $recipeId]/Quantity)"/>
              <xsl:variable name="revenue" select="$totalQuantitySold * Price"/>
              <xsl:variable name="averageRating" select="avg(Review/Rating)"/>
      
              <!-- Output recipe performance -->
              <tr>
                <td><xsl:value-of select="current-grouping-key()"/></td>
                <td><xsl:value-of select="Title"/></td>
                <td><xsl:value-of select="Price"/></td>
                <td><xsl:value-of select="$totalQuantitySold"/></td>
                <td><xsl:value-of select="format-number($revenue, '#.##')"/></td>
                <td><xsl:value-of select="format-number($averageRating, '#.##')"/></td>
              </tr>
            </xsl:for-each>
          </xsl:for-each-group>
        </table>
        <!-- End of the HTML table -->
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
