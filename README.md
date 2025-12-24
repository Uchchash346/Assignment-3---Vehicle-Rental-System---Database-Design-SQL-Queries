````markdown
# 🚗 Vehicle Rental System – Database Design & SQL

## 📌 Project Overview

This project demonstrates the **database design and SQL querying** of a simplified **Vehicle Rental System**.  
It is designed to evaluate core relational database concepts such as:

- Entity Relationship Diagram (ERD)
- Primary and Foreign Keys
- Table relationships (1-to-Many, Many-to-1)
- SQL queries using `JOIN`, `WHERE`, `EXISTS`, `GROUP BY`, and `HAVING`

The system models real-world vehicle rental operations, including users, vehicles, and bookings.

---

## 🎯 Objectives

- Design a normalized relational database schema
- Implement business rules using database constraints
- Write efficient SQL queries to retrieve meaningful data
- Practice interview/viva-level database theory concepts

---

## 🗂️ Database Schema

The database consists of **three core tables**:

### 1️⃣ Users
Stores system users such as admins and customers.

**Key Fields:**
- `user_id` (Primary Key)
- `role` (Admin / Customer)
- `name`
- `email` (Unique)
- `password`
- `phone`

---

### 2️⃣ Vehicles
Stores information about rental vehicles.

**Key Fields:**
- `vehicle_id` (Primary Key)
- `vehicle_name`
- `vehicle_type` (Car / Bike / Truck)
- `model`
- `registration_no` (Unique)
- `price_per_day`
- `availability_status` (Available / Rented / Maintenance)

---

### 3️⃣ Bookings
Stores rental booking information.

**Key Fields:**
- `booking_id` (Primary Key)
- `user_id` (Foreign Key → Users)
- `vehicle_id` (Foreign Key → Vehicles)
- `start_date`
- `end_date`
- `booking_status` (Pending / Confirmed / Completed / Cancelled)
- `total_cost`

---

## 🔗 Entity Relationships

- **Users → Bookings**: One-to-Many  
  One user can create multiple bookings.

- **Vehicles → Bookings**: One-to-Many  
  One vehicle can be booked multiple times over different periods.

- **Bookings → User & Vehicle**: One-to-One (Logical)  
  Each booking connects exactly one user and one vehicle.

---

## 🧾 SQL Queries (`queries.sql`)

This file contains all required SQL queries with explanations and solutions.

---

### 🔹 Query 1: Retrieve Booking Details (INNER JOIN)

**Purpose:**  
Display booking information along with the customer name and vehicle name.

```sql
SELECT 
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    b.booking_status,
    b.total_cost
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
````

**Concepts Used:**
`INNER JOIN`

---

### 🔹 Query 2: Vehicles Never Booked (NOT EXISTS)

**Purpose:**
Find all vehicles that have never been booked.

```sql
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```

**Concepts Used:**
`NOT EXISTS`, Subquery

---

### 🔹 Query 3: Available Vehicles by Type (WHERE)

**Purpose:**
Retrieve all available vehicles of a specific type (e.g., Cars).

```sql
SELECT *
FROM vehicles
WHERE vehicle_type = 'Car'
AND availability_status = 'Available';
```

**Concepts Used:**
`SELECT`, `WHERE`

---

### 🔹 Query 4: Vehicles with More Than 2 Bookings (GROUP BY & HAVING)

**Purpose:**
Find vehicles that have been booked more than two times.

```sql
SELECT 
    v.vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2;
```

**Concepts Used:**
`GROUP BY`, `HAVING`, `COUNT`

---

## 🧠 Key Concepts Demonstrated

* Relational database design
* Primary & Foreign key constraints
* Data integrity and normalization
* SQL joins and aggregations
* Real-world business logic implementation

---

## 📌 Tools & Technologies

* SQL (MySQL / PostgreSQL compatible)
* Lucidchart (for ERD design)
* GitHub (version control & documentation)

---

## ✅ How to Use This Repository

1. Review the ERD to understand table relationships
2. Execute queries from `queries.sql`
3. Compare results with expected outputs
4. Use theory explanations for viva or interviews

---

## 📄 License

This project is created for **educational purposes** and can be freely used for learning, assignments, and interview preparation.

```

If you want, I can also add:
- `CREATE TABLE` scripts  
- Sample `INSERT` data  
- A **Bangla version of README**  
- Screenshots section for ERD  

Just let me know 👍
```

## Submission Links

| Resource              | Link                  |
| --------------------- | --------------------- |
| **GitHub Repository** | [GitHub Repo][github] |
| **ER Diagram**       | [ERD Link][erd]       |
| **Viva Video**        | [Viva Video][viva]    |

[github]: https://github.com/Uchchash346/Assignment-3---Vehicle-Rental-System---Database-Design-SQL-Queries
[erd]: https://lucid.app/lucidchart/a00db083-9788-42de-80c4-300b61d04f7c/edit?viewport_loc=-1835%2C-561%2C2992%2C1466%2C0_0&invitationId=inv_39ba83bf-ac33-4a44-bb18-df384d1ac256
[viva]: https://drive.google.com/file/d/115IwOtIhCt8D_l1et1Zpa9bY1GcGNpjq/view?usp=sharing
