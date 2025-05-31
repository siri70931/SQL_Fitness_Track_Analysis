# Fitness Tracker Analysis SQL Project

## Project Overview

**Project Title**: Fitness Tracker Analysis 
**Database**: `fitness_tracker_db`

This project is to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a fitness tacker database**: Create and populate a fitness tracker database with the provided data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `fitness_tracker_db`.
- **Table Creation**: A table named `Fitness_Tracker` is created to store the sales data. The table structure includes columns for User_id, Date, steps, Heart_rate_avg, Calories_burned, Workout_type.

```sql
CREATE DATABASE fitness_tracker_db;

CREATE TABLE Fitness_Tracker
(
    User_id SMALLINT,
    Date DATE,	
    steps SMALLINT,
    Heart_Avg_rate TINYINT,	
    Calories_burned SMALLINT,
    Workout_type NVARCHAR(50)
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **User ID Count**: Find out how many unique customers are in the dataset.
- **Workout type Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM Fitness_Tracker_Data;
SELECT COUNT(DISTINCT User_id) FROM Fitness_Tracker_Data;
SELECT DISTINCT workout_type FROM Fitness_Tracker_Data;

SELECT * FROM Fitness_Tracker_Data
WHERE 
    User_id IS NULL OR Date IS NULL OR steps IS NULL OR 
    Heart_Avg_rate IS NULL OR Calories_burned IS NULL OR workout_type IS NULL ;

DELETE FROM Fitness_Tracker_Data
WHERE 
    User_id IS NULL OR Date IS NULL OR steps IS NULL OR 
    Heart_Avg_rate IS NULL OR Calories_burned IS NULL OR workout_type IS NULL ;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for users who goes to gym on January Month**:
```sql
SELECT *
FROM Fitness_Tracker_Data
WHERE month(Date) = 01;
```

2. **Write a SQL query to retrieve all data where the workout_type is 'Cardio' and the Calories_burned more than 500 in the month of March month**:
```sql
SELECT *
FROM Fitness_Tracker_Data
WHERE 
workout_type = 'cardio'
and calories_burned > 500
and month(date) = 03;
```

3. **Write a SQL query to calculate the total calories_burned for each workout_type.**:
```sql
SELECT 
workout_type, 
sum(calories_burned) as total_calories
FROM Fitness_Tracker_Data
group by workout_type;
```

4. **Write a SQL query to find the average steps of users whose workout is strength**:
```sql
SELECT avg(steps) as Avg_Steps, Workout_Type
FROM Fitness_Tracker_Data
where workout_type = 'strength'
group by workout_type;
```

5. **Write a SQL query to find all user_ids where the steps count is greater than 10000.**:
```sql
SELECT user_id 
from fitness_tracker_data
where steps > 10000
```

6. **Write a SQL query to find the top 1 based on steps under each workout_type and on feb month**:
```sql
SELECT TOP 1  SUM(STEPS) as steps, workout_type
FROM fitness_tracker_data
WHERE MONTH(date) = 2
GROUP BY workout_type
ORDER BY steps DESC;
```

7. **Write a SQL query to calculate the average calories burns for each workout type. Find out highest workout type in each month**:
```sql

WITH cte AS (
    SELECT  
        MONTH(date) AS month,
        AVG(calories_burned) AS Avg_Cal,
        workout_type,
        RANK() OVER (PARTITION BY MONTH(date) ORDER BY AVG(calories_burned) DESC) AS rank
    FROM 
        fitness_tracker_data
    GROUP BY 
        workout_type, MONTH(date)
)
SELECT 
    month,
    workout_type,
    Avg_Cal
FROM 
    cte
WHERE 
    rank = 1;

```
8. **Write a SQL query to find the top 5 users based on the highest calories burned**:
```sql

select top 5 user_id, calories_burned
from fitness_tracker_data
order by calories_burned desc

```
9. **Write a SQL query to define user as person who done less exercise - calories less than 200,
medium exercise - calories 200 to 500, high exercise - calories greater than 500**:
```sql

with cte as (
    select user_id, case 
	                    when calories_burned < 200 then 'Less Excercise' 
						when calories_burned > 200 and calories_burned < 500 then 'Medium Excercise' 
						when calories_burned > 500 then 'High Excercise' 
				    end as Excercise_Type, 
calories_burned
    from fitness_tracker_data
)
select user_id, calories_burned, Excercise_type from cte;

```



## Reports

- **Fitness_Track Summary**: A detailed report summarizing total calories burned, workout type, and steps performance.
- **Trend Analysis**: Insights into calories burned for each workout type and steps for each and every user.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding patterns, users behavior, and their performance.

## How to Use

1. **Set Up the Database**: Run the SQL scripts provided in the `Fitness_Tracker_Queries.sql` file to create and populate the database.
2. **Run the Queries**: Use the SQL queries provided in the `Fitness_Tracker_Queries.sql` file to perform your analysis.
3. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.



