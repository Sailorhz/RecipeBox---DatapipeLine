<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" expand-text="yes">
  <xsl:output method="html"/>
  
  <!-- Define CSS styles for the table -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Customer Spending Summary</title>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            background-color: #B0C4DE;
            border: 1px solid floralwhite;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #318CE7;
            color: #e6eaee;
          }
        </style>
      </head>
      <body>
        <h2>Customer Spending Summary</h2>
        <!-- Start of the HTML table with 4 colounms -->
        <table>
          <tr>
            <th>Name</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Total Spending (EUR) </th>           
          </tr>
          <!-- Iterate over each customer -->
          <xsl:for-each select="/RecipeBox/Customer">
            <xsl:sort select="sum(for $i in Order/Content return $i/Quantity * //Recipe[Id = $i/RecipeId]/Price)" data-type="number" order="descending"/>
            <xsl:variable name="customerName" select="Name"/>
            <xsl:variable name="customerGender" select="Gender"/>
            <xsl:variable name="totalSpending">
              <!-- This initiates a loop where $i iterates over each Content element within the Order. return $i/Quantity * //Recipe[Id = $i/RecipeId]/Price: This part of the expression calculates the total price for each Content element within the loop. -->
              <xsl:value-of select="sum(for $i in Order/Content return $i/Quantity * //Recipe[Id = $i/RecipeId]/Price)"/>
            </xsl:variable>
            <!-- Calculate age based on birthdate -->
            <xsl:variable name="birthDate" select="xs:date(Birthday)"/>
            <!-- This variable named "currentDate" stores the current date obtained using the current-date() function. This function returns the current date according to the system clock. -->
            <xsl:variable name="currentDate" select="current-date()"/>
            <!-- This variable named "age" calculates the age of a person based on their birthdate. It subtracts the birth year (year-from-date($birthDate)) from the current year (year-from-date($currentDate)) to get the age. -->
            <xsl:variable name="age" select="year-from-date($currentDate) - year-from-date($birthDate)"/>
            
            <!-- Output customer information within a table row -->
            <tr>
              <td><xsl:value-of select="$customerName" /></td>
              <td><xsl:value-of select="$customerGender" /></td>
              <td><xsl:value-of select="$age" /></td>
              <td><xsl:value-of select="$totalSpending" /></td>
              
            </tr>
          </xsl:for-each>
        </table>
        <!-- End of the HTML table -->
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
