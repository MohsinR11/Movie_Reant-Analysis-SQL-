-- Create Movie Rental Database
CREATE DATABASE movie_rental_analysis;
USE movie_rental_analysis;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(100),
    membership_date DATE
);

-- Movies Table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    genre VARCHAR(50),
    release_year INT,
    rental_price DECIMAL(5,2)
);

-- Rentals Table
CREATE TABLE rentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    movie_id INT,
    rental_date DATE,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Insert Sample Data
INSERT INTO customers (first_name, last_name, email, city, membership_date) VALUES
('John', 'Doe', 'john.doe@email.com', 'New York', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', 'Los Angeles', '2023-02-20'),
('Mike', 'Johnson', 'mike.johnson@email.com', 'Chicago', '2023-03-10'),
('Emily', 'Brown', 'emily.brown@email.com', 'Houston', '2023-04-05');

INSERT INTO movies (title, genre, release_year, rental_price) VALUES
('Inception', 'Sci-Fi', 2010, 4.50),
('The Shawshank Redemption', 'Drama', 1994, 3.99),
('Avengers: Endgame', 'Action', 2019, 5.00),
('Pulp Fiction', 'Crime', 1994, 4.25),
('The Matrix', 'Sci-Fi', 1999, 4.75);

INSERT INTO rentals (customer_id, movie_id, rental_date, return_date) VALUES
(1, 1, '2023-06-01', '2023-06-05'),
(1, 2, '2023-06-02', '2023-06-06'),
(2, 3, '2023-06-10', '2023-06-14'),
(3, 4, '2023-06-15', '2023-06-19'),
(4, 5, '2023-06-20', '2023-06-24'),
(1, 3, '2023-07-01', '2023-07-05'),
(2, 1, '2023-07-05', '2023-07-09'),
(3, 5, '2023-07-10', '2023-07-14');

-- Analysis Queries

-- 1. Most Popular Movies
SELECT 
    m.title, 
    COUNT(r.rental_id) as total_rentals,
    m.genre
FROM movies m
JOIN rentals r ON m.movie_id = r.movie_id
GROUP BY m.movie_id
ORDER BY total_rentals DESC;

-- 2. Customer Rental Activity
SELECT 
    c.first_name, 
    c.last_name,
    COUNT(r.rental_id) as total_rentals,
    SUM(m.rental_price) as total_spending
FROM customers c
JOIN rentals r ON c.customer_id = r.customer_id
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY c.customer_id
ORDER BY total_rentals DESC;

-- 3. Rental Trends by Genre
SELECT 
    m.genre,
    COUNT(r.rental_id) as total_rentals,
    ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) as avg_rental_duration
FROM movies m
JOIN rentals r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY total_rentals DESC;

-- 4. Rental Revenue Analysis
SELECT 
    YEAR(r.rental_date) as rental_year,
    MONTH(r.rental_date) as rental_month,
    ROUND(SUM(m.rental_price), 2) as monthly_revenue,
    COUNT(r.rental_id) as total_rentals
FROM rentals r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;

-- 5. Customer Retention Analysis
SELECT 
    YEAR(membership_date) as join_year,
    COUNT(customer_id) as new_customers,
    COUNT(DISTINCT r.customer_id) as active_customers
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY join_year
ORDER BY join_year;