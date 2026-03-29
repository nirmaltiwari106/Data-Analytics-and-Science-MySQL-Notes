# Data-Analytics-and-Science-MySQL-Notes
This repository contains structured MySQL class notes with practical examples, queries, and concepts for beginners to intermediate learners in data analytics."
# 📊 MySQL Class Notes

Welcome to my MySQL learning repository! 🚀  
This repository contains all my **MySQL class notes**, covering basic to intermediate concepts with practical examples.

---

## 📌 About
- 👨‍💻 Created by: Nirmal Tiwari  
- 🎯 Goal: Learn and practice MySQL for Data Analytics  
- 📚 Level: Beginner to Intermediate  

---

## 🧠 Topics Covered

### 🔹 Basics of SQL
- What is Database?
- What is DBMS?
- What is MySQL?
- SQL vs MySQL

### 🔹 Database Operations
- CREATE Database
- DROP Database
- USE Database

### 🔹 Table Operations
- CREATE TABLE
- ALTER TABLE
- DROP TABLE

### 🔹 Data Manipulation (DML)
- INSERT
- UPDATE
- DELETE

### 🔹 Data Query (DQL)
- SELECT Statement
- WHERE Clause
- ORDER BY
- GROUP BY
- HAVING

### 🔹 Joins
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL JOIN

### 🔹 Functions
- Aggregate Functions (SUM, COUNT, AVG)
- String Functions
- Date Functions

### 🔹 Advanced Topics
- Subqueries
- Views
- Indexes
- Constraints (PRIMARY KEY, FOREIGN KEY)

---

## 💻 Sample Query

```sql
SELECT name, COUNT(*) 
FROM customers
GROUP BY name
HAVING COUNT(*) > 1;
