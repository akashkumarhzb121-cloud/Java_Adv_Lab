# RTU 5th Sem Advanced Java Lab (5CS4-24) ☕

This repository contains the complete practical implementation, source code, and configurations for the **Advanced Java Laboratory** course prescribed for the **5th Semester B.Tech in Computer Science and Engineering (CSE)** at **Rajasthan Technical University (RTU), Kota**.

---

## 📌 Course Details
* **Course Title:** Advanced Java Lab
* **Course Code:** 5CS4-24
* **Semester:** V Semester (3rd Year)
* **Branch:** Computer Science & Engineering (CSE)
* **Affiliation:** Rajasthan Technical University (RTU), Kota

---

## 📂 Repository Structure

The project is organized by experiments covering key advanced Java technologies:

```text
├── Exp01_Swing_GUI/         # Swing UI components & MVC architecture layout
├── Exp02_JDBC_Connectivity/ # Database interactions using java.sql
├── Exp03_Socket_Networking/ # TCP/IP Client-Server network communication
├── Exp04_RMI_Application/   # Distributed applications using RMI architecture
├── Exp05_Java_Servlets/     # Server-side HTTP request/response & session filters
├── Exp06_JSP_Application/   # Dynamic page handling, Expression Language & JSTL
└── README.md                # Project documentation (This file)
```

---

## 📋 List of Experiments (As per RTU Syllabus)

### 🔹 Module 1: Graphical User Interfaces with Swing
* **Experiment 1:** Study and implementation of Java Swing components (JTextField, JButton, JToggleButton, JCheckBox, JRadioButton) utilizing the **MVC Architecture** and Pluggable Look and Feel.
* **Experiment 2:** Creation of a multi-window desktop GUI application (e.g., Calculator or User Registration Form).

### 🔹 Module 2: Database Programming & Networking
* **Experiment 3:** Establish database connectivity via the **`java.sql`** package using proper JDBC drivers to execute CRUD commands and handle `ResultSet` mappings.
* **Experiment 4:** Client-Server Socket programming using the **`java.net`** package demonstrating reliable data transfer via TCP protocol.

### 🔹 Module 3: Distributed Computing
* **Experiment 5:** Development of a distributed enterprise application via **Remote Method Invocation (RMI)** by defining Remote Interfaces, Stubs, Skeletons, and binding with the `rmiregistry`.

### 🔹 Module 4: Server-Side Web Technologies
* **Experiment 6:** Implementation of **Java Servlets** mapping the web container lifecycle, parameter parsing, session tracking (`HttpSession`), and filter configurations.
* **Experiment 7:** Creation of dynamic **JavaServer Pages (JSP)** leveraging JSP implicit objects, custom action elements, Expression Language (EL), and JSTL tags.

---

## 🛠️ Tech Stack & Environment Setup

Ensure you have the following prerequisites installed on your local system:

* **Java Development Kit:** JDK 8 or higher (JDK 11+ recommended)
* **Web Server/Servlet Container:** Apache Tomcat (v9.0 or later)
* **Database Management System:** MySQL Server 8.x (or Oracle XE)
* **IDE:** Eclipse IDE for Enterprise Java Developers / IntelliJ IDEA Ultimate / NetBeans
* **Database Driver jar:** `mysql-connector-j-xxx.jar` added to the classpath

---

## 🚀 Execution & Setup Guide

### 1. Cloned Repository Setup
```bash
git clone https://github.com
cd rtu-advanced-java-lab
```

### 2. Compiling & Running Core Java (Swing/Networking/RMI)
```bash
# Compile
javac Exp01_Swing_GUI/Calculator.java
# Run
java Exp01_Swing_GUI.Calculator
```

### 3. Deploying Web Applications (Servlets/JSP)
1. Move the specific lab project folder into the `webapps` directory of your local **Apache Tomcat** installation.
2. Start the Tomcat server instance (`catalina.sh run` or `startup.bat`).
3. Open your browser and navigate to `http://localhost:8080/your_experiment_folder/`.

---

## 📝 Lab Outcomes
Upon completion of this lab, you will be able to:
1. Develop rich, modular window-based desktop applications.
2. Connect production-grade architectures with structured backend RDBMS.
3. Manage distributed remote network communication objects smoothly.
4. Deploy robust enterprise web solutions via dynamic Servlets and JSP architectures.
5. 
