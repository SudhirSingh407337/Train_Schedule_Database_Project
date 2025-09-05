# Database Project – Online Railway Booking System

**Developer:** Sudhir Singh  

---

## 📖 Project Description
This project is an **online railway booking system** that allows customers to search for train schedules, make one-way or round-trip reservations, and manage their bookings. It also includes administrative and customer service functionalities.  

### Key Features
- **User registration and login** for customers, customer representatives, and admins
- **Search & browse train schedules** by origin, destination, and date
- **Fare calculation**, including discounts for children, seniors, and disabled passengers
- **Reservation management** (create, view, cancel)
- **Admin functions**: generate revenue/usage reports, manage representatives
- **Customer representative functions**: edit train schedules, respond to questions, produce schedule lists
- **Access control**: different levels of functionality for different user roles

---

### 🚆 Train Schedule Database Project Video

[![Train Schedule Database Project](https://img.youtube.com/vi/qWJEDCIzUm4/0.jpg)](https://youtu.be/qWJEDCIzUm4)

🎥 [Train Schedule Database Project](https://youtu.be/qWJEDCIzUm4) 🎥  

---

## 🛠️ Technologies Used
- Java  
- JSP/Servlets  
- HTML/CSS/JavaScript  
- MySQL  
- Apache Tomcat  
- Eclipse IDE  

---

## 🚀 How to Run the Project
1. Open **Eclipse**.
2. Go to **File → Import → Existing Projects into Workspace**.
3. Select the extracted folder from `projectCode.zip`.
4. Add the **Apache Tomcat** server (if applicable).
5. Right-click the project → **Run As → Run on Server**.

---

## 🗄️ Database Setup
1. Open **MySQL Workbench**.
2. Create a new schema/database: `[your_database_name]`.
3. Run the `schema.sql` file to create tables:
   - File → Open → select `schema.sql`
   - Click **Execute**.

---

## 📂 Project Structure

- `/src/` – Java source code (Servlets, business logic)
- `/WebContent/` – JSPs, HTML, CSS, JS
- `schema.sql` – SQL schema file
- `README.txt` – This file


---

## ⚠️ Notes
- Use **Java 11+** for compatibility.
- Do **not** run as a WAR file — deploy directly in Eclipse.

---

## 👤 Test User Accounts

### Customers
| Username     | Password  |
|--------------|-----------|
| johndoe      | 1234      |
| alicesmith   | 5678      |
| bobtaylor    | pass1234  |

### Admin
| Username | Password   |
|----------|------------|
| admin    | admin123   |

### Customer Representative
| Username | Password   |
|----------|------------|
| rep1     | rep123     |

---

## 🗓️ Train Schedules for Testing
| Origin     | Destination    | Date       |
|------------|---------------|------------|
| Princeton  | Edison        | 07/25/2025 |
| Princeton  | New Brunswick | 07/24/2025 |
| Trenton    | Princeton     | 01/24/2025 |
| Trenton    | New Brunswick | 01/24/2025 |

---
