=======================================
Project Title: Database Project 
Developer: Sudhir Singh
=======================================

1. Project Description
----------------------
This project is an online railway booking system which allows customers to search for train schedules, make one-way or round-trip reservations, and manage their bookings. It also includes administrative and customer service functionalities.
Key features include:
	•	User registration and login for customers, customer reps, and admins
	•	Search and browse train schedules by origin, destination, and date
	•	Fare calculation, including discounts for children, seniors, and disabled passengers
	•	Reservation management (create, view, cancel)
	•	Admin functions: reports on revenue and usage, manage representatives
	•	Customer rep functions: edit train schedules, respond to questions, produce schedule lists
	•	Access control: Different levels of functionality for different user roles

2. Technologies Used
---------------------
- Java 
- JSP/Servlets
- HTML/CSS/JavaScript
- MySQL
- Apache Tomcat
- Eclipse IDE

3. How to Run the Project
--------------------------
1. Open Eclipse.
2. Go to File → Import → Existing Projects into Workspace.
3. Select the extracted folder from `projectCode.zip`.
4. Add the Apache Tomcat server (if applicable).
5. Right-click the project → Run As → Run on Server.

4. Database Setup
------------------
1. Open MySQL Workbench.
2. Create a new schema/database: `[your_database_name]`
3. Run the `schema.sql` file to create tables:
   - File → Open → select `schema.sql`
   - Click "Execute"


5. Project Structure
---------------------
- `/src/` – Java source code (Servlets, business logic)
- `/WebContent/` – JSPs, HTML, CSS, JS
- `schema.sql` – SQL schema file
- `README.txt` – This file

6. Notes
---------
- Use Java 11+ for compatibility
- Do not run as a WAR file – deploy directly in Eclipse


Customers: 
Username: johndoe
Password: 1234

Username: alicesmith
Password: 5678

Username: bobtaylor
Password: pass1234


Admin:
Username: admin
Password: admin123



Customer Representative: 
Username: rep1
Password: rep123



Train Schedule To Test:

Princeton -> Edison  
Date: 07/25/2025

Princeton -> New Brunswick  
Date: 07/24/2025

Trenton -> Princeton  
Date: 01/24/2025

Trenton -> New Brunswick  
Date: 01/24/2025


