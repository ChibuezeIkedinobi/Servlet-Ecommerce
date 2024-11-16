# Servlet-Ecommerce

## Project Description

**Servlet-Ecommerce** is a simple e-commerce web application built using Java Servlets and JSPs. The project provides basic functionality for an online shopping platform, including user registration, login, product management (for admins), and a shopping cart for customers.

## Features

### User Management
- User registration and login.
- Admin-specific functionality for managing products.

### Product Management
- Admin can add, view, and remove products from the database.
- Products are displayed dynamically using JSPs.

### Shopping Cart
- Users can add products to their cart.
- Real-time cart updates with product quantities and total price calculations.

### Database Integration
- MySQL database to store user data, products, and cart information.

### Responsive Interface
- Styled with CSS to provide a clean and user-friendly interface.
- Admin dashboard for product management.
- Home page for browsing products.

### Core Technologies Used
- Java Servlets and JSPs.
- JDBC for database connectivity.
- Apache Tomcat server.

## How to Use

1. Clone the repository and import the project into your preferred Java IDE (e.g., IntelliJ IDEA).
2. Set up the MySQL database with the provided schema and seed data.
3. Configure the database connection in the `Util` class.
4. Deploy the project on an Apache Tomcat server.
5. Access the application via a web browser:
   - **Home Page:** Browse products and add them to your cart.
   - **Admin Dashboard:** Manage products (requires admin credentials).

## Future Enhancements
- Implement payment gateway integration.
- Add product search and filtering features.
- Enhance security with password encryption.
- Include user order history and invoice generation.

