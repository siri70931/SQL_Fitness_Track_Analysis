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

-- 1. **Write a SQL query to retrieve all columns for users who goes to gym on January Month**:

SELECT *
FROM Fitness_Tracker_Data
WHERE month(Date) = 01;


-- 2. **Write a SQL query to retrieve all data where the workout_type is 'Cardio' and the Calories_burned more than 500 in the month of March month**:

SELECT *
FROM Fitness_Tracker_Data
WHERE 
workout_type = 'cardio'
and calories_burned > 500
and month(date) = 03;

-- 3. **Write a SQL query to calculate the total calories_burned for each workout_type.**:

SELECT 
workout_type, 
sum(calories_burned) as total_calories
FROM Fitness_Tracker_Data
group by workout_type;

-- 4. **Write a SQL query to find the average steps of users whose workout is strength**:

SELECT avg(steps) as Avg_Steps, Workout_Type
FROM Fitness_Tracker_Data
where workout_type = 'strength'
group by workout_type;

-- 5. **Write a SQL query to find all user_ids where the steps count is greater than 10000.**:

SELECT user_id 
from fitness_tracker_data
where steps > 10000

-- 6. **Write a SQL query to find the top 1 based on steps under each workout_type and on feb month**:

SELECT TOP 1  SUM(STEPS) as steps, workout_type
FROM fitness_tracker_data
WHERE MONTH(date) = 2
GROUP BY workout_type
ORDER BY steps DESC;

-- 7. **Write a SQL query to calculate the average calories burns for each workout type. Find out highest workout type in each month**:

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

-- 8. **Write a SQL query to find the top 5 users based on the highest calories burned**:

select top 5 user_id, calories_burned
from fitness_tracker_data
order by calories_burned desc;

-- 9. **Write a SQL query to define user as person who done less exercise - calories less than 200,
--      medium exercise - calories 200 to 500, high exercise - calories greater than 500**:

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

with cte as (
    select user_id, case 
	                    when calories_burned < 200 then 'Less Excercise' 
						when calories_burned > 200 and calories_burned < 500 then 'Medium Excercise' 
						when calories_burned > 500 then 'High Excercise' 
				    end as Excercise_Type, calories_burned
    from fitness_tracker_data
)
select user_id, calories_burned, Excercise_type from cte
