use zoom;

-- Stored Procedure
/*
A Stored Procedure is a precompiled collection of one or more SQL statements that can be executed
as a single unit. Stored procedures are stored in the database and can be called by applications
or other SQL statements. They help in encapsulating business logic, improving performance, and
enhancing security by controlling access to data.

Types of Stored Procedures
1. Simple Stored Procedures: These perform basic operations like inserting, updating, or deleting records.
2. Parameterized Stored Procedures: These accept parameters to perform operations based on input values.
3. Stored Procedures with Output Parameters: These return values to the caller, allowing for more complex
operations.
4. Stored Procedures with Cursors: These are used to process multiple rows returned by a query one at a time.

Basic Syntax for Creating a Stored Procedure:

DELIMITER //
CREATE PROCEDURE procedure_name (IN parameter_name datatype)
BEGIN
    -- SQL statements
END //
DELIMITER ;


In Short -->

Purpose:
1. Encapsulate business logic
2. Reuse SQL statements
3. Improve performance
4. Secure data access

Types:
1. Simple SP – basic CRUD(Create, read, update,delete) operations
2. Parameterized SP – accepts inputs
3. SP with Output Parameters – returns results
4. SP with Cursors – row-by-row processing

*/

-- Create the Stored Procedure:
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_id INT)
BEGIN
    SELECT * FROM employees WHERE department_id = dept_id;
END //

DELIMITER ;

select * from employees;

-- call the procedure
CALL GetEmployeesByDepartment(10);

-- drop procedure
DROP PROCEDURE IF EXISTS GetEmployeesByDepartment;

-- Modifying a Stored Procedure:
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_id INT)
BEGIN
    SELECT employee_id, first_name FROM employees WHERE department_id = dept_id;
END //
DELIMITER ;

CALL GetEmployeesByDepartment(30);



-- stored procedures vs user defined functions
/*
Stored Procedures-  are best for executing complex logic, managing transactions, and modifying data.

User Defined Functions-  are ideal for calculations and transformations that can be reused in SQL expressions.


When to Use Each---

Use Stored Procedures When:

1. You need to perform complex operations that involve multiple SQL statements.
2. You want to manage transactions.
3. You need to encapsulate business logic that modifies data.
4. You want to return multiple result sets.

Use User-Defined Functions When:

1. You need to perform calculations or transformations that can be reused in SQL queries.
2. You want to return a single value or a table.
3. You need to use the function in a SELECT statement, WHERE clause, or other SQL expressions.

*/

-- Example of a Stored Procedure
DELIMITER //
CREATE PROCEDURE GetEmployeeDetails(IN empId INT)
BEGIN
    SELECT * FROM Employees WHERE Employee_id = empId;
END //
DELIMITER ;

-- Usage:
CALL GetEmployeeDetails(1);

-- Example of a User-Defined Function
DELIMITER //
CREATE FUNCTION GetEmployeeFullName(empId INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE fullName VARCHAR(100);
    SELECT CONCAT(First_name, ' ', Last_name) INTO fullName
    FROM Employees WHERE Employee_ID = empId;
    RETURN fullName;
END //
DELIMITER ;

drop function if exists getemployeefullname;

-- Usage:
SELECT GetEmployeeFullName(1);

select * from employees;


-- Solved Problems on Simple SP

-- 1. Get All Employees
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM Employees;
END //
DELIMITER ;

CALL GetAllEmployees();
DROP PROCEDURE IF EXISTS GetAllEmployees;


-- 2. Get Employees by Department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN deptId INT)
BEGIN
    SELECT * FROM Employees WHERE Department_ID = deptId;
END //
DELIMITER ;
CALL GetEmployeesByDept(10);

-- 3. Add a New Product
DELIMITER //
CREATE PROCEDURE AddProduct(IN name VARCHAR(50), IN price DECIMAL(10,2))
BEGIN
    INSERT INTO Products(Name, Price) VALUES(name, price);
END //
DELIMITER ;
CALL AddProduct('Laptop', 50000);


-- 4. Update Product Price
DELIMITER //
CREATE PROCEDURE UpdateProductPrice(IN pId INT, IN newPrice DECIMAL(10,2))
BEGIN
    UPDATE Products SET Price=newPrice WHERE ProductID=pId;
END //
DELIMITER ;
CALL UpdateProductPrice(1, 45000);


-- 5. Delete a Product
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN pId INT)
BEGIN
    DELETE FROM Products WHERE ProductID=pId;
END //
DELIMITER ;
CALL DeleteProduct(1);

-- Unsolved Problems on Simple SP
-- 1. Retrieve employees with salary > 50,000
-- 2. Insert a new user into Users table
-- 3. Update department name for a given department ID
-- 4. Delete orders older than 2023-01-01
-- 5. Fetch products with stock < 10
-- (Hint: Use IN parameters and WHERE conditions)


-- Solved Problems on SP with Output Parameters

-- 1. Get Total Sales of a Product

DELIMITER //
CREATE PROCEDURE GetTotalSales(IN productId INT, OUT total DECIMAL(10,2))
BEGIN
    SELECT SUM(Quantity * Price) INTO total FROM Orders WHERE ProductID=productId;
END //
DELIMITER ;
SET @t=0; CALL GetTotalSales(1, @t); SELECT @t AS TotalSales;


2. Count Employees in a Department

DELIMITER //
CREATE PROCEDURE CountEmployees(IN deptId INT, OUT empCount INT)
BEGIN
    SELECT COUNT(*) INTO empCount FROM Employees WHERE Department_ID=deptId;
END //
DELIMITER ;
SET @c=0; CALL CountEmployees(10, @c); SELECT @c;


3. Max Product Price

DELIMITER //
CREATE PROCEDURE MaxProductPrice(OUT maxPrice DECIMAL(10,2))
BEGIN
    SELECT MAX(Price) INTO maxPrice FROM Products;
END //
DELIMITER ;
SET @max=0; CALL MaxProductPrice(@max); SELECT @max;


4. Employee Full Name

DELIMITER //
CREATE PROCEDURE GetFullName(IN empId INT, OUT fullName VARCHAR(100))
BEGIN
    SELECT CONCAT(First_Name,' ',Last_Name) INTO fullName FROM Employees WHERE Employee_ID=empId;
END //
DELIMITER ;
SET @name=''; CALL GetFullName(1, @name); SELECT @name;


5. Average Salary by Department

DELIMITER //
CREATE PROCEDURE AvgSalary(IN deptId INT, OUT avgSal DECIMAL(10,2))
BEGIN
    SELECT AVG(Salary) INTO avgSal FROM Employees WHERE Department_ID=deptId;
END //
DELIMITER ;
SET @a=0; CALL AvgSalary(10, @a); SELECT @a;

5️⃣ Unsolved Problems – Output Parameters

Get the minimum product price

Count total orders for a product

Calculate total stock in all products

Return employee’s age based on DOB

Return number of users registered in last month

6️⃣ Solved Problems – SP with Cursors

1. Print all Product Names

DELIMITER //
CREATE PROCEDURE PrintProducts()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pname VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT Name FROM Products;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO pname;
        IF done THEN LEAVE read_loop; END IF;
        SELECT pname AS ProductName;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL PrintProducts();


2. Print Employee Names in Dept 10

DELIMITER //
CREATE PROCEDURE PrintEmpNames()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE ename VARCHAR(50);
    DECLARE cur CURSOR FOR SELECT First_Name FROM Employees WHERE Department_ID=10;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

    OPEN cur;
    loop1: LOOP
        FETCH cur INTO ename;
        IF done THEN LEAVE loop1; END IF;
        SELECT ename;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL PrintEmpNames();


3. Print Product Names with Price > 100
4. Loop through Orders and print OrderID
5. Cursor for Users registered in last month

(3–5 similar; logic: DECLARE, OPEN, FETCH, LOOP, CLOSE)

7️⃣ Unsolved Problems – SP with Cursors

Fetch employees with salary > 60,000 row by row

Print products with stock < 50

Display orders placed in last 7 days

Loop through Users table and print usernames

Print products with Price between 500–1000

-- Example 1: Simple Stored Procedure
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- Usage:
CALL GetAllProducts();

-- delete it
DROP PROCEDURE IF EXISTS GetAllProducts;

-- Example 2: Parameterized Stored Procedure
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN categoryName VARCHAR(50))
BEGIN
    SELECT * FROM Products WHERE Category = categoryName;
END //
DELIMITER ;

-- Usage:
CALL GetProductsByCategory('Electronics');


-- Example 3: Stored Procedure with Output Parameter
DELIMITER //
CREATE PROCEDURE GetTotalSales(IN productId INT, OUT totalSales DECIMAL(10, 2))
BEGIN
    SELECT SUM(Quantity * Price) INTO totalSales
    FROM Orders
    WHERE ProductID = productId;
END //
DELIMITER ;

select * from Orders;

-- price does not exist in orders table
-- add column price in orders table
-- insert price values according to condition.

ALTER TABLE Orders
ADD COLUMN Price DECIMAL(10, 2);

UPDATE Orders
SET Price = CASE
    WHEN Product_ID = 1 THEN 10.00
    WHEN Product_ID = 2 THEN 15.50
    WHEN Product_ID = 3 THEN 20.00
    WHEN Product_ID = 4 THEN 25.00
    -- Add more conditions as needed
    ELSE 0.00  -- Default price if no condition matches
END;

SET SQL_SAFE_UPDATES=1;

-- Usage:
SET @totalSales = 0;
CALL GetTotalSales(1, @totalSales);
SELECT @totalSales AS TotalSales;  -- Output: Total sales for product with ID 1


-- Example-4 Stored Procedures with Cursors
-- Step 1: Create the Products Table
CREATE TABLE Product1 (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Product VARCHAR(100) NOT NULL
);

-- Step 2: Insert Sample Data
INSERT INTO Product1 (Product) VALUES
('Apple'),
('Banana'),
('Cherry'),
('Date'),
('Elderberry');

select * from product1;

-- Step 3: Create the Stored Procedure
DELIMITER //

CREATE PROCEDURE PrintProductNames()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE product VARCHAR(100);
    DECLARE productCursor CURSOR FOR SELECT Product FROM Product1 WHERE Product IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN productCursor;

    read_loop: LOOP
        FETCH productCursor INTO product;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT product AS ProductName;  -- Print the product name
    END LOOP;

    CLOSE productCursor;
END //

DELIMITER ;

-- Call the Stored Procedure
CALL PrintProductNames();

-- Drop the Procedure after Execution
DROP PROCEDURE IF EXISTS PrintProductNames;

-- Verify Table Data
SELECT * FROM Product1;

-- Next Examples for better understanding
SELECT * FROM Products;

-- Example 1: Inserting Data with a Stored Procedure
DELIMITER //
CREATE PROCEDURE AddProduct(IN name VARCHAR(100),
IN Price DECIMAL(10, 2), IN stock int, IN Category VARCHAR(50))
BEGIN
    INSERT INTO Products (name, Price,stock, Category) VALUES (name, Price,stock, Category);
END //
DELIMITER ;

-- Usage:
CALL AddProduct('New Gadget', 99.99,50, 'Electronics');

-- delete it
DROP PROCEDURE IF EXISTS AddProduct;

-- Example 2: Updating Data with a Stored Procedure
DELIMITER //
CREATE PROCEDURE UpdateProductPrice(IN productId INT, IN newPrice DECIMAL(10, 2))
BEGIN
    UPDATE Products SET Price = newPrice WHERE ProductID = productId;
END //
DELIMITER ;

-- Usage:
CALL UpdateProductPrice(1, 89.99);


-- Example 3: Deleting Data with a Stored Procedure
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN productId INT)
BEGIN
    DELETE FROM Products WHERE ProductID = productId;
END //
DELIMITER ;
set SQL_SAfe_updates=0;
-- Usage:
CALL DeleteProduct(1);


-- Example 4: Retrieving Data with Conditional Logic
DELIMITER //
CREATE PROCEDURE GetProductsByPriceRange(IN minPrice DECIMAL(10, 2), IN maxPrice DECIMAL(10, 2))
BEGIN
    SELECT * FROM Products WHERE Price BETWEEN minPrice AND maxPrice;
END //
DELIMITER ;

-- Usage:
CALL GetProductsByPriceRange(50.00, 150.00);


-- Example 5: Using Transactions in a Stored Procedure
DELIMITER //
CREATE PROCEDURE TransferProductStock(IN fromProductId INT, IN toProductId INT, IN quantity INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback in case of an error
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Subtract stock from the source product
    UPDATE Products SET Stock = Stock - quantity WHERE ProductID = fromProductId;

    -- Add stock to the destination product
    UPDATE Products SET Stock = Stock + quantity WHERE ProductID = toProductId;

    COMMIT;
END //
DELIMITER ;

-- Usage:
CALL TransferProductStock(1, 2, 5);


-- Example 6: Stored Procedure with Multiple Output Parameters
DELIMITER //
CREATE PROCEDURE GetProductStatistics(OUT totalCount INT, OUT minPrice DECIMAL(10, 2), OUT maxPrice DECIMAL(10, 2))
BEGIN
    SELECT COUNT(*), MIN(Price), MAX(Price) INTO totalCount, minPrice, maxPrice FROM Products;
END //
DELIMITER ;

-- Usage:
SET @count = 0;
SET @min = 0;
SET @max = 0;
CALL GetProductStatistics(@count, @min, @max);
SELECT @count AS TotalCount, @min AS MinPrice, @max AS MaxPrice;


-- Example 7: Stored Procedure for Bulk Insertion
DELIMITER //
CREATE PROCEDURE BulkInsertProducts()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE productName VARCHAR(100);
    DECLARE productPrice DECIMAL(10, 2);
    DECLARE productCategory VARCHAR(50);
   
    -- Create a temporary table to hold the products
    CREATE TEMPORARY TABLE TempProducts (
        ProductName VARCHAR(100),
        Price DECIMAL(10, 2),
        Category VARCHAR(50)
    );

    -- Insert sample data into the temporary table
    INSERT INTO TempProducts (ProductName, Price, Category) VALUES
    ('Gadget A', 49.99, 'Electronics'),
    ('Gadget B', 59.99, 'Electronics'),
    ('Gadget C', 69.99, 'Electronics');

    -- Insert data from the temporary table into the main Products table
    INSERT INTO Products (ProductName, Price, Category)
    SELECT ProductName, Price, Category FROM TempProducts;

    -- Drop the temporary table
    DROP TEMPORARY TABLE TempProducts;
END //
DELIMITER ;

-- Usage:
CALL BulkInsertProducts();


-- Example 8: Stored Procedure for Conditional Updates
DELIMITER //
CREATE PROCEDURE UpdatePriceIfLower(IN productId INT, IN newPrice DECIMAL(10, 2))
BEGIN
    UPDATE Products
    SET Price = newPrice
    WHERE ProductID = productId AND newPrice < Price;
END //
DELIMITER ;

-- Usage:
CALL UpdatePriceIfLower(1, 45.00);  -- This will update if the current price is higher than 45.00


-- Example 9: Stored Procedure for Pagination
DELIMITER //
CREATE PROCEDURE GetPaginatedProducts(IN pageNumber INT, IN pageSize INT)
BEGIN
    SET @ofset = (pageNumber - 1) * pageSize;

    SELECT * FROM Products
    LIMIT pageSize OFFSET ofset;
END //
DELIMITER ;

-- Usage:
CALL GetPaginatedProducts(1, 10);  -- Get the first 10 products
CALL GetPaginatedProducts(2, 10);  -- Get the next 10 products


-- Example 10: Stored Procedure for Error Handling
DELIMITER //
CREATE PROCEDURE UpdateProductStock(IN productId INT, IN quantity INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback in case of an error
        ROLLBACK;
        SELECT 'Error occurred while updating stock.' AS ErrorMessage;
    END;

    START TRANSACTION;

    UPDATE Products SET Stock = Stock + quantity WHERE ProductID = productId;

    COMMIT;
    SELECT 'Stock updated successfully.' AS SuccessMessage;
END //
DELIMITER ;

-- Usage:
CALL UpdateProductStock(1, 10);  -- Update stock for product with ID 1


-- Example 11: Stored Procedure for Reporting
DELIMITER //
CREATE PROCEDURE GenerateSalesReport(IN productId INT)
BEGIN
    SELECT
        o.OrderID,
        o.Quantity,
        o.OrderDate,
        (o.Quantity * p.Price) AS TotalSale
    FROM
        Orders o
    JOIN
        Products p ON o.ProductID = p.ProductID
    WHERE
        p.ProductID = productId;
END //
DELIMITER ;

-- Usage:
CALL GenerateSalesReport(1);  -- Generate sales report for product with ID 1


-- Example 12: Stored Procedure for User Authentication
DELIMITER //
CREATE PROCEDURE AuthenticateUser (IN username VARCHAR(50), IN password VARCHAR(50), OUT isAuthenticated BOOLEAN)
BEGIN
    DECLARE userCount INT;

    SELECT COUNT(*) INTO userCount
    FROM Users
    WHERE Username = username AND Password = password;

    SET isAuthenticated = (userCount > 0);
END //
DELIMITER ;

-- Usage:
SET @isAuthenticated = FALSE;
CALL AuthenticateUser ('john_doe', 'password123', @isAuthenticated);
SELECT @isAuthenticated AS IsAuthenticated;
