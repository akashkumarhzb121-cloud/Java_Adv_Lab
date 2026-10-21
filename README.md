# Advanced Java Lab — Semester 5

This repository contains my **Advanced Java Laboratory** experiments for **CSE, 5th semester**, plus **ShopSphere**, a Java e-commerce project that brings several of the lab technologies together.

## Live project

- **ShopSphere on Render:** [https://java-adv-lab.onrender.com/](https://java-adv-lab.onrender.com/)

## Student and course details

| Detail | Information |
| --- | --- |
| Student | Akash Kumar |
| Roll number | 24EGJCS015 |
| Semester | 5th | 3rd Year |
| Branch | Computer Science and Engineering (CSE) |
| College | GIT College |
| University | Rajasthan Technical University (RTU) |
| Course | Advanced Java Lab |

## Repository layout

The experiments are kept in separate, numbered folders. ShopSphere is a separate capstone project with its own web, Swing, socket, and RMI code.

```text
Java_Adv_Lab/
├── Experiment-01-Registration-Form-Using-Java/
│   ├── registration portalStudentRegistrationSystem.java
│   └── registration portalstudent_database.sql
├── Experiment-02-Database-Operations-With-JDBC/
│   ├── jdbcApp.java
│   └── pom.xml
├── Experiment-03-MVC-Pattern-Based-Calculator/
│   ├── model.java
│   ├── view.java
│   ├── controller.java
│   └── main.java
├── Experiment-04-Distributed-Calculator-Using-RMI/
│   ├── calculator.java
│   ├── server.java
│   ├── client.java
│   └── Sample.java
├── Experiment-05-Multithreaded-TCP-Client-Server/
│   ├── Server.java
│   └── Client.java
├── Experiment-06-HTTP-Request-Handling-With-Servlets/
│   ├── pom.xml
│   └── src/
├── Experiment-07-Web-Based-Student-Portal/
│   └── jsp-servlet-student-main/
├── OTHERS/                           # Additional/alternate lab implementations
└── ShopSphere/                       # E-commerce capstone project
    ├── database/                     # ShopSphere database schema and seed data
    ├── docs/                         # Project and syllabus documentation
    ├── network/                      # TCP socket, serialization, URLConnection demos
    ├── rmi/                          # Remote inventory service and client
    ├── swing-admin/                  # Swing administration application
    ├── web/src/main/java/com/shopsphere/
    │   ├── controller/               # Servlet controllers
    │   ├── dao/                      # JDBC data access
    │   ├── filter/                   # Authentication, admin and CSRF filters
    │   ├── listener/                 # Application and session listeners
    │   ├── model/
    │   ├── service/
    │   └── util/
    ├── web/src/main/webapp/          # JSP views, tags, assets and syllabus demos
    ├── pom.xml
    ├── Dockerfile
    └── render.yaml
```

## Lab experiments

### Experiment 1 — Registration form using Java

Builds a Java Swing student registration form and includes a SQL script for the student database. The source combines GUI event handling with database connectivity.

### Experiment 2 — Database operations with JDBC

Demonstrates Java database connectivity and database operations in `jdbcApp.java`. The folder includes a Maven `pom.xml` for its dependencies and build.

### Experiment 3 — MVC-pattern calculator

Implements a calculator with separate model, view, and controller classes, coordinated by `main.java`.

### Experiment 4 — Distributed calculator using RMI

Shows a calculator service split between an RMI server and client, with a remote calculator interface.

### Experiment 5 — Multithreaded TCP client-server

Uses a TCP server and client to demonstrate socket-based communication and handling clients with threads.

### Experiment 6 — HTTP request handling with Servlets

A Maven web application covering HTTP request handling with Jakarta Servlets. Its source includes servlet examples, filters, listeners, and HTML pages.

### Experiment 7 — Web-based student portal

A JSP and Servlet student portal demonstrating form submission, servlet processing, and displaying results in JSP pages.

### Additional material

`OTHERS/` contains alternate or supporting versions of the form, MVC calculator, RMI, and socket examples. These are separate from the numbered experiment folders.

## ShopSphere capstone project

[ShopSphere](ShopSphere/) is an e-commerce web application and the main integrated project in this repository. The source is divided by responsibility and Java technology:

- **Web application:** Servlet controllers, services, JDBC DAOs, models, filters, listeners, JSP views, reusable JSP tags, and web assets.
- **Database:** SQL schema and seed data in `ShopSphere/database/`.
- **Swing administration:** Desktop administration UI with MVC-style controllers and JDBC DAOs in `ShopSphere/swing-admin/`.
- **TCP networking:** Inventory client/server, object serialization, and a URLConnection example in `ShopSphere/network/`.
- **RMI:** Remote inventory service, server, and client in `ShopSphere/rmi/`.
- **Syllabus demonstrations:** JNDI, localization, JSP/JSTL examples, and related topic notes.

The web application uses a layered structure:

```text
Browser and JSP views
        ↓
Servlet controllers and filters
        ↓
Services
        ↓
DAO classes
        ↓ JDBC
Database
```

The project is packaged as a WAR using Maven and is configured for Jakarta Servlet 6.1 and Tomcat 11. Its root-level `Dockerfile` packages ShopSphere for deployment, and `render.yaml` contains the Render service configuration.

## Technologies

- Java (ShopSphere Maven build targets Java 21)
- Swing and Java event handling
- JDBC and MySQL
- TCP sockets, multithreading, and serialization
- Java RMI
- Jakarta Servlets, JSP, Expression Language, and JSTL
- Maven, Apache Tomcat, Docker, and Render

## Running ShopSphere locally

Install a compatible JDK, Maven, Docker (if using the container), and MySQL if you want to run against a local database. For database setup, environment variables, and the standalone Java demos, see the [ShopSphere project guide](ShopSphere/README.md).

From the repository root, build and test the web project:

```powershell
cd ShopSphere
mvn clean test
mvn clean package
```

To build and run the Docker image from the repository root:

```powershell
docker build -t shopsphere -f Dockerfile .
docker run -p 8080:8080 shopsphere
```

The local application is available at `http://localhost:8080/`. The ShopSphere guide explains database configuration required for features that use persistent storage.

## Links

- **GitHub:** [akashkumarhzb121-cloud](https://github.com/akashkumarhzb121-cloud)
- **LinkedIn:** [Akash Kumar](https://www.linkedin.com/in/akash-kumar-488074309/)
- **Live ShopSphere deployment:** [java-adv-lab.onrender.com](https://java-adv-lab.onrender.com/)
