# RecipeBox---DatapipeLine
Encapsulates a comprehensive approach to data modelling, schema creation, and practical application scenarios to analyse and optimise an food e-commerce platform.
Working Enviroment and Tools

•	Text Editor : Sublime Text 
•	XML Validators: FreeFormatter, Liquid-Technology
•	XSLT Transformer : XSL Transform
•	Json validator : Liquid-Technology
•	Browser : Google Chrome
•	Diagram : Xmind, Smart Draw
 
Principals of Data Model 

Data Modeling / Schema

 Conceptual Stage 1.1 - a data model depends on function of e-coomerce website
I commenced the process of data modeling by analyzing the operational framework of the website. Following a thorough examination of BBC Good Food, I formulated a conceptualization aimed at incorporating five essential components – recipes, customers, orders, deliveries, and reviews – into our data model. I perceive these elements as fundamental functionalities requisite for an e-commerce platform. Attached herewith are the corresponding diagrams for your reference.

 
 However, in consideration of individual workload management, I streamlined the tasks upon commencing solo work. 

  

Conceptual Stage  1.2- business questions that the database will be use to answer

This database was designed with the intention of examining recipe performance, describing customer profiles, and understanding delivery preferences. Consequently, it enables us to identify areas for expanding recipe offerings to attract potential customers, strategies for enhancing customer retention, insights into potential customer behaviors, and avenues for improving delivery services.

Also, for presenting what I understand in this course, the database and its schema will showcasing the ideas of linking the data (xsd schema, xpath, ID, xs:key, xs:keyref).

Logical Stage - How to relate entities 

The following diagram illustrates the interrelation among the six entities, employing all three types of entity relationships. Additionally, the XSD schema leverages its inherent capability to parent its child entities, thus circumventing redundancy, optimizing query performance, and facilitating subsequent calculations in XSLT and JSON. The schema is structured in XSD with a salami slice style, aligning with this strategic approach.    

 

physical stage - creat databset

The dataset has been generated based on the established model and schema. It comprises 10 customers with varying quantities of orders and order content, as well as 10 recipes with random numbers of reviews and ratings. The customer profiles, including names, addresses, phone numbers, and emails, have been fabricated by myself and ChatGPT, while the recipe content, such as ingredients and review texts, has been authored by ChatGPT.

Advantages

1. All three type of relationships are leveraged. This model and database with differenct types of relationships are expected to be such more efficient to organize data, to optimize query performance that comprehensive data nanlysis. 

2. XSD schema's advantage offered me the oppotunity to put the child entities like order content and dlivery into Customer as well as to put reviews and ratings into Recipe, which I feel is more effeicient for the later computation of XSLT. Furthermore, this method help to reduce the usage of redundunt ID so that make dataset more easier to understand. 

3. xs:key and xs:keyref.  Using xs:key in XML Schema provides advantages over other methods in this project: 
•	Ensures uniqueness,maintaining dataset integrity,
•	Facilitates fast data retrieval,
•	Simpler implementation.
•	Automatically validates data uniqueness during parsing

4. The Salami Slice style schema proved to be the preferred choice during the schema building process. While experimenting with alternative designs such as Russian Doll and Garden of Eden, I encountered confusion on multiple occasions. However, Salami Slice offered a clear solution by breaking down complex schemas into smaller, manageable components and organizing them hierarchically. This approach allowed schemas to grow organically and facilitated easy modification and extension of components as needed.  

Disavantages

1. In this data modle, there are more entiies can be developed to respond to a real e-commerce business. For example, ingrediens with their suppliers and inventory, customer address with regions etc. 

2. It is still a mini dataset, the data model' performance still need to be tested to a much larger databse. 

3. the usage of xs:key has its limitations. 
•	Managing this constraints can become com in complext data structures. 
•	It cant extent to other documents or external data sources. 
•	Updating or modifying xs:key may require careful consideration to ensure compatibility with existing data and applications.

Scenarios
 
1.	Customer Orders Summary 

This scenario aims to provide an overview of customer information alongside their total orders. As each customer has a random quantity of orders, the process involves counting and summing these orders, followed by arranging them in descending order to identify those who placed the most orders.

    Solution: 

•	<xsl:key name="customer-key" match="Customer" use="Email"/>
•	Email to be the key for group by the customer later. 

•	<xsl:apply-templates select="Customer">
•	<xsl:sort select="sum(Order/Content/Quantity)" data-type="number" order="descending"/>
•	Within the "Customer" elements, orders are sorted based on the sum of the quantity of items ordered.

•	<xsl:variable name="orderCount" select="count(key('customer-key', $customerEmail)/Order)"/>
•	calculates the number of orders associated with the current customer. the key function was used to retrieve all orders corresponding to the current customer's email address.

•	Use html and CSS style to make it a table with proper presentation. 


2.	Complex solutions: Customer Spending Summary 

 An analytical scenario involves assessing the overall expenditure of customers to determine potential correlations with demographic factors such as gender and age. The most diffcult part is to cauculate total spending. 
     
     Solution: 

•	Use "for-each" to interates over each Customer element. 

•	Use "for $i" to iterate over within the loop above.

•	Then use "sum(for $i in Order/Content return $i/Quantity * //Recipe[Id = $i/RecipeId]/Price)" to caculate total spending by the quantity of each item in an order ($i/Quantity) multiply its corresponding price (retrieved from the "Recipe" element using the recipe ID) for all orders of the current customer.

•	Use "year-from-date($currentDate) - year-from-date($birthDate)" to compute the age of customers as there is only birthdate element in dataset. 

3.	Recipe Performance

It aims to provide an visualization of each recipe's performance. Therefore, It conclude recipe title, price, total quantity, revenue each generated and average rating. From this report, we can find which recipes bring most higher revenue. 

     Solution:

•	The "for-each" to iterates over each "Recipe" element.

•	Within the loop, recipes are sorted in descending order based on the total quantity sold of each recipe. 
•	Then total quantity sold is calculated by summing the quantity of each item in an order (by Quantity) for all orders containing the "the" recipe.

•	"$totalQuantitySold * Price" is for caculating the revenues.

•	"avg(Review/Rating)" to find the average rating for each recipe. 

•	Use "format-number(......, '#.##')" to round the result with only two decimal places. 

4.	Complex solutions: Is healthy food popular in our customer circle? 

Its aims to find out if the customer like or intent to buy more healthy food on website. 

      Solution: 

•	The "for-each-group" to loop the recipe then group by health category. 

•	The "for-each" "current-group()" to iterate within each health category.

•	The "sum(/RecipeBox/Customer/Order/Content[RecipeId = current()/Id]/Quantity)", to find out the quantity by each health category bought in each order, the XPath selects the quantity (Quantity) from the Content elements where the RecipeId matches the current Id. Then it sorts the recipes base on the total quatity sold for each recipe.

•	The "totalQuantitySold" select="sum(/RecipeBox/Customer/Order/Content[RecipeId = $recipeId]/Quantity)" to sums the quantity of each item in an order for the current recipe.

•	The " select="$totalQuantitySold * Price", then use it to find the total revenue for each recipe. 

•	The "avg(Review/Rating)" to find the average rating for each recipe.

•	Use "format-number(......, '#.##')" to round the result with only two decimal places. 

5.	Complex solutions:Customer Delivery Service Usage Summary

This scenario is to explore which delivery service used most by customer. And which customer prefer which delivery service. 

     Solution: 

•	Use 'deliveryServiceKey' to matches elements with the name "DeliveryService"

•	"//DeliveryService[generate-id() = generate-id(key('deliveryServiceKey', .)[1]) to selects each unique delivery service using the generate-id() and key() functions to ensure that only the first occurrence of each unique delivery service is processed.

•	"count(key('deliveryServiceKey', .) to count each service.

•	Then counts the orders one service by another. 

6.	RSS feed 

A RSS feed to lure customer with the top 3 recipes that sold most. Except of output the xslt file, This one also conclude 3 files of html files for "read more" pages.

       Solution:

•	Find the most order recips from scenarios 3. Then make them into a mini dataset in RSS format. 

•	Use "link" to link extended resources

•	Use HTML div to link image from other URIs. 

7.	Top 5 Customers in Json file

This Scenario is to look through who are the top 5 customers who places more orders. I use css and html in xslt to creat an output in json form in html and one in text. 

![image](https://github.com/Sailorhz/RecipeBox---DatapipeLine/assets/129844601/a8c42a62-149f-45cb-af1e-a8b9eb217107)
