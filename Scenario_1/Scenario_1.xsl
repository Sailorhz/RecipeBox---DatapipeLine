<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>

    <!-- Define a key to group orders by customer email -->
    <xsl:key name="customer-key" match="Customer" use="Email"/>

    <!-- Template to match RecipeBox root element -->
    <xsl:template match="/RecipeBox">
        <html>
            <head>
                <title>Customer Orders Summary</title>
                <style>
                  table {
                    border-collapse: collapse;
                    width: 100%;
                  }
                  th, td {
                    background-color: #F8F8F8;
                    border: 1px solid floralwhite;
                    padding: 8px;
                    text-align: left;
                  }
                  th {
                    background-color: #C0C0C0;
                    color: #e6eaee;
                  }
        </style>
            </head>
            <body>
                <h2>Customer Orders Summary</h2>
                <!-- Start of the HTML table with 7 colounms -->
                <table border="1">
                    <tr>
                        <th>Total Orders</th>
                        <th>Customer</th>
                        <th>Gender</th>
                        <th>Birthday</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Address</th>                    
                    </tr>
                    <!-- Apply templates to select and process customers Then sort them in descending order -->
                    <xsl:apply-templates select="Customer">
                        <xsl:sort select="sum(Order/Content/Quantity)" data-type="number" order="descending"/>
                    </xsl:apply-templates>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template to process customers -->
    <xsl:template match="Customer">
        <!-- Group orders by customer email using the key  and count the orders-->
        <xsl:variable name="customerEmail" select="Email"/>
        <xsl:variable name="orderCount" select="count(key('customer-key', $customerEmail)/Order)"/>
        
        <tr>
            <td><xsl:value-of select="$orderCount"/></td>
            <td><xsl:value-of select="Name"/></td>
            <td><xsl:value-of select="Gender"/></td>
            <td><xsl:value-of select="Birthday"/></td>
            <td><xsl:value-of select="Email"/></td>
            <td><xsl:value-of select="PhoneNo"/></td>
            <td><xsl:value-of select="Address"/></td>
            
        </tr>
    </xsl:template>
</xsl:stylesheet>
