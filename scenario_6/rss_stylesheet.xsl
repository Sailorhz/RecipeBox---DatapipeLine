<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <!-- Set the title of the HTML page -->
        <title>Most Ordered Recipe</title>
        <!-- Define the CSS styles for the HTML elements, color, font, size etc-->
        <style>
          body {
            font-family: Times New Roman, serif;
            margin: 20px;
            padding: 0;
            background-color: #f7f7f7;
          }
          h1 {
            font-size: 24px;
            color: #330300;
          }
          .item {
            margin-bottom: 30px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
          }
          .content {
            flex: 1;
          }
          .title {
            font-size: 20px;
            margin-bottom: 5px;
            color: #000810;
          }
          .description {
            font-size: 16px;
            color: #666;
          }
          .rating {
            font-size: 14px;
            color: #efb810;
            margin-top: 5px;
           }
          .link {
            font-size: 14px;
            color: #0066cc;
          }
          .pubDate {
            font-size: 12px;
            color: #999;
          }
          .image {
            flex-shrink: 0;
            width: 100px; 
            margin-left: 20px;
          }
        </style>
      </head>
      <body>
        <!-- Set the heading of the HTML page -->
        <h1>Most Ordered Recipe</h1>

        <!-- Apply templates to process each 'item' element -->
        <xsl:apply-templates select="rss/channel/item"/>
      </body>
    </html>
  </xsl:template>
   <!-- Template to process each 'item'-->
  <xsl:template match="item">
    <div class="item">
      <div class="content">
        <!-- Display the title of the recipe -->
        <div class="title">
          <xsl:value-of select="title"/>
        </div>
        <!-- Display the description of the recipe -->
        <div class="description">
          <xsl:value-of select="description"/>
        </div>
        <!-- Display the rating of the recipe -->
        <div class="rating">
        Rating: <xsl:value-of select="rating"/>
        </div>
        <!-- Display a link to read more about the recipe -->
        <div class="link">
          <a href="{link}" target="_blank">Read more</a>
        </div>
        <!-- Display the publication date of the recipe -->
        <div class="pubDate">
          <xsl:value-of select="pubDate"/>
        </div>
      </div>
      <!-- Start of the HTML div for the image -->
      <div class="image">
        <!-- Determine which image to display based on the position -->
        <img src="{if (position() = 1) then 'https://bluebowlrecipes.com/wp-content/uploads/2023/08/chocolate-truffle-cake-8844-683x1024.jpg' else if (position() = 2) then 'https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/easy_spaghetti_bolognese_93639_16x9.jpg' else 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-1001491_11-2e0fa5c.jpg'}" alt="{title}" width="100"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
