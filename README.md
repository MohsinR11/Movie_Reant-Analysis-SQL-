# **Movie Rent Analysis (SQL)**  

## **Overview**  
This project explores movie rental patterns to provide insights for improving rental services.  

## **Objective**  
- Discover most-rented movies and genres.  
- Identify peak rental times and active customers.  
- Analyze rental trends by region and customer type.  

## **Skills and Tools Used**  
- **Skills**: Grouping, filtering, and ranking functions.  
- **Tools**: PostgreSQL/SQL Server.  

## **Key Insights**  
- Top-performing genres by rental count.  
- Peak hours/days for rentals.  
- High-value customers based on rental frequency.  

## **Dataset Details**  
- **Source**: Sample rental data.  
- **Contents**:  
  - Movie details (title, genre).  
  - Rental records (date, time, customer ID).  
  - Customer demographics (age, location).  

## **Sample Queries**  
```sql
-- Most rented movie genres
SELECT Genre, COUNT(*) AS Rental_Count
FROM Movie_Rentals
GROUP BY Genre
ORDER BY Rental_Count DESC;

-- Peak rental hours
SELECT HOUR(Rental_Time) AS Hour, COUNT(*) AS Rentals
FROM Movie_Rentals
GROUP BY HOUR(Rental_Time)
ORDER BY Rentals DESC;


## **Contact**  
📧 **Mohsin Raza**: mohsinansari1799@gmail.com 
