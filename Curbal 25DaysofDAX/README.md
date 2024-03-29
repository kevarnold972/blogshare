This folder contains my answers to the Curbal #25DaysOfDAXFridays challenge. 
Find the questions at https://curbal.com/25-days-of-dax-fridays-challenge
# Day25
## Functions used:
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [YEAR](https://dax.guide/YEAR)
## DAX Code:
```
-------------------------------------
-- Measure: [Employees hired in 1994]
-------------------------------------
MEASURE 'Employees'[Employees hired in 1994] = 
    COUNTROWS(
        FILTER( 'Employees', YEAR( 'Employees'[HireDate] ) = 1994 )
    )
    Description = "Day 25 - How many employess got hired in 1994?"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day24
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [SELECTCOLUMNS](https://dax.guide/SELECTCOLUMNS)
## DAX Code:
```
-------------------------------------------------------------
-- Measure: [Number of Sales people over $100K sales in 2021]
-------------------------------------------------------------
MEASURE 'Employees'[Number of Sales people over $100K sales in 2021] = 
    VAR Employee2021Sales =
        ADDCOLUMNS(
            'Employees',
            "@2021Sales",
                CALCULATE( [Total sales], 'Calendar'[Year] = 2021 )
        )
    VAR SalesPeopleOver100K =
        SELECTCOLUMNS(
            FILTER( Employee2021Sales, [@2021Sales] > 100000 ),
            "@Name", 'Employees'[Full Name]
        )
    RETURN
        COUNTROWS( SalesPeopleOver100K )
    Description = "Day 24 - How many employees sold over $100K in 2021?"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day23
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [CALCULATE](https://dax.guide/CALCULATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [SELECTCOLUMNS](https://dax.guide/SELECTCOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
----------------------------------
-- Measure: [Top Salesperson 2021]
----------------------------------
MEASURE 'Employees'[Top Salesperson 2021] = 
    VAR Employee2021Sales =
        ADDCOLUMNS(
            'Employees',
            "@2021Sales",
                CALCULATE( [Total sales], 'Calendar'[Year] = 2021 )
        )
    VAR TopSalesPeople =
        SELECTCOLUMNS(
            TOPN( 1, Employee2021Sales,[@2021Sales],DESC ),
            "@Name", 'Employees'[Full Name]
        )
    RETURN
        CONCATENATEX( TopSalesPeople, [@Name], " & " )
    Description = "Day 23 - Which employee had the highest sales in 2021?"
    DisplayFolder = "My Answers"
```
# Day22
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [DATEDIFF](https://dax.guide/DATEDIFF)
- [FILTER](https://dax.guide/FILTER)
- [TODAY](https://dax.guide/TODAY)
## DAX Code:
```
-------------------------------------------------
-- Measure: [Number of Employees age 60 and over]
-------------------------------------------------
MEASURE 'Employees'[Number of Employees age 60 and over] = 
    VAR EmployeeAge =
        ADDCOLUMNS(
            'Employees',
            "@Age", DATEDIFF( 'Employees'[BirthDate], TODAY( ), YEAR )
        )
    RETURN
        COUNTROWS( FILTER( EmployeeAge, [@Age] >= 60 ) )
    Description = "Day 22 - How many employees are 60 years old or over?"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day21
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [DIVIDE](https://dax.guide/DIVIDE)
## DAX Code:
```
--------------------------------
-- Measure: [% Female Employees]
--------------------------------
MEASURE 'Employees'[% Female Employees] = 
    DIVIDE(
        CALCULATE(
            COUNTROWS( 'Employees' ),
            'Employees'[Gender] = "Female"
        ),
        COUNTROWS( 'Employees' )
    )
    Description = "Day 21 - How many employees (%) are female"
    DisplayFolder = "My Answers"
    FormatString = "#,##0.00 %"
```
# Day20
## Functions used:
- [SELECTCOLUMNS](https://dax.guide/SELECTCOLUMNS)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [SUMX](https://dax.guide/SUMX)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
------------------------------------------------
-- Measure: [Vendor with Highest Stock $ Amount]
------------------------------------------------
MEASURE 'Products'[Vendor with Highest Stock $ Amount] = 
    VAR VendorStockValue =
        SUMMARIZECOLUMNS(
            'Suppliers'[CompanyName],
            "@StockValue",
                SUMX(
                    'Products',
                    'Products'[UnitsInStock] * 'Products'[UnitPrice]
                )
        )
    VAR TopVendor =
        TOPN( 1, VendorStockValue, [@StockValue], DESC )
    VAR Result =
        SELECTCOLUMNS( TopVendor, 'Suppliers'[CompanyName] )
    RETURN
        Result
    Description = "Day 20 - Which vendor has the highest stock value?"
    DisplayFolder = "My Answers"
```
# Day19
## Functions used:
- [](https://dax.guide/)
- [CALCULATE](https://dax.guide/CALCULATE)
- [SUMX](https://dax.guide/SUMX)
## DAX Code:
```
-------------------------------------------------
-- Measure: [Discontinued Products Stocked Value]
-------------------------------------------------
MEASURE 'Products'[Discontinued Products Stocked Value] = 
    CALCULATE(
        SUMX(
            'Products',
            [Unit Price]
                * ( 'Products'[UnitsInStock] - 'Products'[UnitsOnOrder] )
        ),
        'Products'[Discontinued] = TRUE
    )
    Description = "Day 19 - What is the stocked value of the discontinued products?"
    DisplayFolder = "My Answers"
    FormatString = "$ #,##0.00"
```
# Day18
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
## DAX Code:
```
--------------------------------------------------------
-- Measure: [Number of Products on Order need restocked]
--------------------------------------------------------
MEASURE 'Products'[Number of Products on Order need restocked] = 
    CALCULATE(
        COUNTROWS( 'Products' ),
        FILTER(
            'Products',
            'Products'[UnitsOnOrder] > 'Products'[UnitsInStock]
        )
    )
    Description = "Day 18 - How many products on order we need to restock"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day17
## Functions used:
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
## DAX Code:
```
--------------------------------------------------------
-- Measure: [Number of Products needing to be restocked]
--------------------------------------------------------
MEASURE 'Products'[Number of Products needing to be restocked] = 
    COUNTROWS(
        FILTER(
            'Products',
            'Products'[UnitsInStock] <= [Restock level]
                && 'Products'[Discontinued] = FALSE
        )
    )
    Description = "Day 17 - How many products need to be restocked? (based on restock levels)"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day16
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
## DAX Code:
```
---------------------------------------------
-- Measure: [Number of Products out of stock]
---------------------------------------------
MEASURE 'Products'[Number of Products out of stock] = 
    COUNTROWS(
                CALCULATETABLE( 'Products', 'Products'[UnitsInStock] = 0 )
            )
    Description = "Day 16 - How many products are out of stock?"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day15
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [DISTINCTCOUNT](https://dax.guide/DISTINCTCOUNT)
- [FILTER](https://dax.guide/FILTER)
- [NATURALINNERJOIN](https://dax.guide/NATURALINNERJOIN)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
----------------------------------------------------------------
-- Measure: [Number of Customer Orders with only Queso Cabrales]
----------------------------------------------------------------
MEASURE 'Orders'[Number of Customer Orders with only Queso Cabrales] = 
    //Get the list of customers by order with only 1 product
    VAR CustomerOrderProducts =
        SUMMARIZE(
            'Orders',
            'Orders'[CustomerID],
            'Orders'[OrderID],
            "@ProductCount", DISTINCTCOUNT( 'Orders'[ProductID] )
        )
    VAR CustomersOneProduct = FILTER( CustomerOrderProducts, [@ProductCount] = 1 )
    //Get the list of customers by Order that purchased "Queso Cabrales"
    VAR CustomerOrderQuesoProduct =
        SUMMARIZE(
            'Orders',
            'Orders'[CustomerID],
            'Orders'[OrderID],
            "@ProductCount",
                COUNTROWS(
                    CALCULATETABLE(
                        VALUES( 'Orders'[ProductID] ),
                        'Products'[ProductName] = "Queso Cabrales"
                    )
                )
        )
    VAR CustomersWithQueso = FILTER( CustomerOrderQuesoProduct, [@ProductCount] = 1 )
    //Joining the lists will provide the result
    VAR CustomerOrdersJustQueso = NATURALINNERJOIN( CustomersWithQueso, CustomersOneProduct )
    VAR Result = COUNTROWS( CustomerOrdersJustQueso )
    RETURN
        Result
    Description = "Day 15 - How many customers have purchased only Queso Cabrales (on an order)"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day14
## Functions used:
- [ALL](https://dax.guide/ALL)
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [EXCEPT](https://dax.guide/EXCEPT)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
-----------------------------------------------------------
-- Measure: [Number of Customers not buying Queso Cabrales]
-----------------------------------------------------------
MEASURE 'Orders'[Number of Customers not buying Queso Cabrales] = 
    VAR CustomersWithQueso =
        CALCULATETABLE(
            VALUES( 'Orders'[CustomerID] ),
            'Products'[ProductName] = "Queso Cabrales"
        )
    VAR AllCustomers = ALL( 'Orders'[CustomerID] )
    VAR CustomersNotBuyingQ = EXCEPT( AllCustomers, CustomersWithQueso )
    VAR Result = COUNTROWS( CustomersNotBuyingQ )
    RETURN
        Result
    Description = "Day 14 - How many customers have NEVER purchased Queso Cabrales"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day13
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [EXCEPT](https://dax.guide/EXCEPT)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
--------------------------------------
-- Measure: [Number of Lost Customers]
--------------------------------------
MEASURE 'Orders'[Number of Lost Customers] = 
    VAR CurrentYear = [Current year]
    VAR CustomersPriorYears =
        CALCULATETABLE(
            VALUES( 'Orders'[CustomerID] ),
            'Calendar'[Year] <> CurrentYear
        )
    VAR CustomersCurrentYear =
        CALCULATETABLE(
            VALUES( 'Orders'[CustomerID] ),
            'Calendar'[Year] = CurrentYear
        )
    VAR LostCustomers = EXCEPT( CustomersPriorYears, CustomersCurrentYear )
    RETURN
        COUNTROWS( LostCustomers )
    Description = "Day 13 - How mant Lost customers (no purchases in current year) in 2021"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day12
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [MIN](https://dax.guide/MIN)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [YEAR](https://dax.guide/YEAR)
## DAX Code:
```
-------------------------------------------
-- Measure: [New Customers in Current Year]
-------------------------------------------
MEASURE 'Orders'[New Customers in Current Year] = 
    VAR CurrentYear = [Current year]
    VAR CustomerMinOrderDate =
        SUMMARIZE(
            'Orders',
            'Orders'[CustomerID],
            "@FirstOrderDate", MIN( 'Orders'[OrderDate] )
        )
    VAR CustomerFirstOrderYear =
        ADDCOLUMNS(
            CustomerMinOrderDate,
            "@Year", YEAR( [@FirstOrderDate] )
        )
    RETURN
        COUNTROWS(
            FILTER( CustomerFirstOrderYear, [@Year] = CurrentYear )
        )
    Description = "Day 12 - How many New customers (first purchase in current year) in 2021"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day11
## Functions used:
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
----------------------------------------------
-- Measure: [Number of Single order Customers]
----------------------------------------------
MEASURE 'Orders'[Number of Single order Customers] = 
    VAR CustomerOrderCount =
        SUMMARIZE(
            'Orders',
            'Orders'[CustomerID],
            "@OrderCount", COUNTROWS( VALUES( 'Orders'[OrderID] ) )
        )
    VAR Result = COUNTROWS( FILTER( CustomerOrderCount, [@OrderCount] = 1 ) )
    RETURN
        Result
    Description = "Day 11"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day10
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [INT](https://dax.guide/INT)
- [MAX](https://dax.guide/MAX)
- [NOW](https://dax.guide/NOW)
## DAX Code:
```
-------------------------------------------------
-- Measure: [Days since North/South last ordered]
-------------------------------------------------
MEASURE 'Orders'[Days since North/South last ordered] = 
    VAR MaxDate =
        CALCULATE(
            MAX( 'Orders'[OrderDate] ),
            'Customers'[CompanyName] = "North/South"
        )
    VAR Result = INT( NOW( ) - MaxDate )
    RETURN
        Result
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day9
## Functions used:
- [AVERAGEX](https://dax.guide/AVERAGEX)
- [FILTER](https://dax.guide/FILTER)
- [RELATED](https://dax.guide/RELATED)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
## DAX Code:
```
------------------------------------------------
-- Measure: [Average Sales for Romero y tomillo]
------------------------------------------------
MEASURE 'Orders'[Average Sales for Romero y tomillo] = 
    VAR CustomerSales =
        SUMMARIZE(
            FILTER(
                'Orders',
                RELATED( 'Customers'[CompanyName] ) = "Romero y tomillo"
            ),
            'Orders'[OrderID],
            "@Sales", [Total sales]
        )
    RETURN
        AVERAGEX( CustomerSales, [@Sales] )
    DisplayFolder = "My Answers"
    FormatString = "$ #,##0.00"
```
# Day8
## Functions used:
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [DISTINCTCOUNT](https://dax.guide/DISTINCTCOUNT)
- [FILTER](https://dax.guide/FILTER)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
## DAX Code:
```
----------------------------------------
-- Measure: [Single Product Order Count]
----------------------------------------
MEASURE 'Orders'[Single Product Order Count] = 
    VAR OrderProduct =
        SUMMARIZE(
            'Orders',
            'Orders'[OrderID],
            "@ProductCount", DISTINCTCOUNT( 'Orders'[ProductID] )
        )
    VAR Result = COUNTROWS( FILTER( OrderProduct, [@ProductCount] = 1 ) )
    RETURN
        Result
    Description = "Day 8"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day7
## Functions used:
- [BLANK](https://dax.guide/BLANK)
- [CALCULATE](https://dax.guide/CALCULATE)
## DAX Code:
```
-------------------------------
-- Measure: [Open Orders Value]
-------------------------------
MEASURE 'Orders'[Open Orders Value] = 
    CALCULATE(
        [Total sales],
        'Orders'[ShippedDate] = BLANK( )
    )
    Description = "Day 7"
    DisplayFolder = "My Answers"
    FormatString = "$ #,##0.00"
```
# Day6
## Functions used:
- [AVERAGEX](https://dax.guide/AVERAGEX)
- [SUM](https://dax.guide/SUM)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
## DAX Code:
```
------------------------------------
-- Measure: [Average Order Quantity]
------------------------------------
MEASURE 'Orders'[Average Order Quantity] = 
    VAR OrderTotalQty =
        SUMMARIZE(
            'Orders',
            'Orders'[OrderID],
            "@TotalQty", SUM( 'Orders'[Quantity] )
        )
    VAR Result = AVERAGEX( OrderTotalQty, [@TotalQty] )
    RETURN
        Result
    Description = "Day 6"
    DisplayFolder = "My Answers"
    FormatString = "0.00"
```
# Day5
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
## DAX Code:
```
------------------------------------------
-- Measure: [Products between $15 and $25]
------------------------------------------
MEASURE 'Products'[Products between $15 and $25] = 
    CALCULATE(
        COUNTROWS( 'Products' ),
        'Products'[UnitPrice] >= 15 && 'Products'[UnitPrice] <= 25
    )
    Description = "Day 5"
    DisplayFolder = "My Answers"
    FormatString = "#,##0"
```
# Day4
## Functions used:
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [SELECTCOLUMNS](https://dax.guide/SELECTCOLUMNS)
## DAX Code:
```
-------------------------------------------
-- Measure: [Count Products above Unit Avg]
-------------------------------------------
MEASURE 'Products'[Count Products above Unit Avg] = 
    VAR AvgUnitPrice = [Average Unit Price]
    VAR ProductsGreater =
        SELECTCOLUMNS(
            FILTER( 'Products', 'Products'[UnitPrice] > AvgUnitPrice ),
            "@ProductID", 'Products'[ProductID]
        )
    RETURN
        COUNTROWS( ProductsGreater )
    Description = "Day 4"
    DisplayFolder = "My Answers"
```
# Day3
## Functions used:
- [AVERAGE](https://dax.guide/AVERAGE)
## DAX Code:
```
--------------------------------
-- Measure: [Average Unit Price]
--------------------------------
MEASURE 'Products'[Average Unit Price] = AVERAGE( 'Products'[UnitPrice] )
    Description = "Day 3"
    DisplayFolder = "My Answers"
    FormatString = "$ #,##0.00"
```
# Day2
## Functions used:
- [ALL](https://dax.guide/ALL)
- [CALCULATE](https://dax.guide/CALCULATE)
- [FORMAT](https://dax.guide/FORMAT)
- [MAXX](https://dax.guide/MAXX)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
------------------------------------
-- Measure: [Most Expensive Product]
------------------------------------
MEASURE 'Products'[Most Expensive Product] = 
    VAR _MaxPrice = MAXX( ALL( 'Products' ), 'Products'[UnitPrice] )
    VAR _Product =
        CALCULATE(
            VALUES( 'Products'[ProductName] ),
            'Products'[UnitPrice] = _MaxPrice
        )
    VAR _ProductID =
        CALCULATE(
            VALUES( 'Products'[ProductID] ),
            'Products'[UnitPrice] = _MaxPrice
        )
    VAR Result =
        FORMAT( _ProductID, "0" ) & " - " & _Product & " @ "
            & FORMAT( _MaxPrice, "Currency" )
    RETURN
        Result
    Description = "Day 2"
    DisplayFolder = "My Answers"
```
# Day1
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FALSE](https://dax.guide/FALSE)
## DAX Code:
```
---------------------------------------------
-- Measure: [Count Current Products under 20]
---------------------------------------------
MEASURE 'Products'[Count Current Products under 20] = 
    CALCULATE(
        COUNTROWS( 'Products' ),
        'Products'[Discontinued] = FALSE( ),
        'Products'[UnitPrice] < 20
    )
    Description = "Day 1"
    DisplayFolder = "My Answers"
    FormatString = "0"
```
