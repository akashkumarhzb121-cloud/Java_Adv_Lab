# ShopSphere

ShopSphere is a Java 25 / Jakarta EE e-commerce management capstone for the RTU Advanced Java syllabus. The production shopping flow is a layered web application; standalone Socket, RMI and Swing programs demonstrate the corresponding desktop/distributed Java topics.

## Features

### Customer storefront

- Customer registration, login/logout, PBKDF2 password hashing and server sessions.
- Product catalog with search, category filter, sorting, discounts, stock availability and ratings.
- Product details, shopping cart quantity changes/removal, wishlist and product reviews.
- Profile editing and saved-address management.
- Coupon validation and checkout using server-calculated prices/totals.
- Transactional order placement, stock reservation/decrement, mock payment or cash-on-delivery, order history/details and status timeline.
- Responsive storefront, localized English/Hindi navigation and INR formatting.

### Administration

- Separate administrator sign-in and role-protected `/admin/*` routes.
- Dashboard sales/order/customer/product summaries and low-stock count.
- Product creation/update/visibility, category creation/visibility, coupon creation/activation, customer activation, order status transitions and low-stock inventory restocking.
- Order cancellation restores inventory and marks already-paid mock transactions refunded.

### Advanced Java demonstrations

- TCP inventory server/client and Java object serialization in `network/`.
- Remote inventory service, registry server and client in `rmi/`.
- Swing MVC administration client and JDBC DAOs in `swing-admin/`.
- JNDI environment lookup at `/jndi-demo`, ResourceBundle English/Hindi files, URLConnection client, and isolated JSP/JSTL XML/SQL examples.
- Applets are not executed; their historical syllabus role is explained in [docs/legacy-applets.md](docs/legacy-applets.md).

## Technology and architecture

- JDK 25; Maven WAR packaging.
- Apache Tomcat 11.0.25; Jakarta Servlet 6.1, JSP/EL and JSTL 3.
- MySQL 8.0.16+ and MySQL Connector/J 9.4.
- Bootstrap 5.3, custom responsive CSS and vanilla browser form behavior.
- Swing, JDBC, `Socket`/`ServerSocket`, RMI/registry, serialization, JNDI and ResourceBundle.

The primary application follows:

```text
Browser / JSP / JSTL
        ↓ HTTP
Servlet controllers and filters
        ↓
Service layer
        ↓
DAO layer (PreparedStatement)
        ↓ JDBC
MySQL
```

Presentation, validation/business rules and persistence are kept in separate packages. JSTL SQL is isolated under `/syllabus/` strictly as a syllabus exercise; the store itself does not issue SQL from JSPs.

## Project structure

```text
ShopSphere/
├── pom.xml
├── README.md
├── .gitignore
├── .env.example
├── database/shopsphere.sql
├── docs/
│   ├── database-and-security.md
│   ├── legacy-applets.md
│   └── rtu-syllabus-mapping.md
├── web/
│   └── src/
│       ├── main/java/com/shopsphere/
│       │   ├── controller/
│       │   ├── dao/
│       │   ├── filter/
│       │   ├── listener/
│       │   ├── model/
│       │   ├── service/
│       │   └── util/
│       ├── main/resources/com/shopsphere/messages_{en,hi}.properties
│       ├── main/webapp/
│       │   ├── WEB-INF/fragments/
│       │   ├── WEB-INF/tags/
│       │   ├── WEB-INF/views/
│       │   ├── assets/
│       │   └── syllabus/
│       └── test/java/com/shopsphere/
├── network/
├── rmi/
└── swing-admin/
```

Tomcat is a separately installed runtime at `../apache-tomcat-11.0.25`; it is not part of the ShopSphere application source or build. The parent repository now ignores the runtime path. Existing runtime files are left on disk.

## MySQL setup

1. Start the locally installed MySQL server.
2. From the parent `Java_Adv_Lab` folder, import the schema:

   ```powershell
   $mysql = 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe'
   Get-Content -LiteralPath .\ShopSphere\database\shopsphere.sql -Raw |
       & $mysql --user=root --password
   ```

   The SQL creates the `shopsphere` database, normalized tables, constraints/indexes, sample products/categories, `WELCOME10`, and local development-only login records.
3. Create a least-privilege application account (replace the example password before using it):

   ```sql
   CREATE USER 'shopsphere_app'@'localhost' IDENTIFIED BY 'replace-with-a-local-secret';
   GRANT SELECT, INSERT, UPDATE, DELETE ON shopsphere.* TO 'shopsphere_app'@'localhost';
   FLUSH PRIVILEGES;
   ```

4. Set runtime database values in the PowerShell window that will start Tomcat:

   ```powershell
   $env:SHOPSPHERE_DB_URL = 'jdbc:mysql://localhost:3306/shopsphere?useSSL=false&serverTimezone=UTC'
   $env:SHOPSPHERE_DB_USER = 'shopsphere_app'
   $env:SHOPSPHERE_DB_PASSWORD = 'your-local-secret'
   ```

   The application does not load `.env` automatically; export the values to the process environment. Do not commit a real password. See [docs/database-and-security.md](docs/database-and-security.md).

### Development accounts

The schema seeds two local-only accounts. Change/remove them before production:

| Role | Email | Password |
|---|---|---|
| Admin | `admin@shopsphere.local` | `Admin@ShopSphere25` |
| Customer | `customer@shopsphere.local` | `Customer@ShopSphere25` |

Only salted PBKDF2 hashes are stored in the SQL seed. Customer sign-up is available at `/register`.

## Build and tests

Use JDK 25 and Maven 3.9+:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-25.0.4.1' # set to your installed JDK 25 directory
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
cd ShopSphere
mvn clean test
mvn clean package
```

The WAR is `target\ShopSphere.war`. `mvn test` covers password hash creation/verification and checkout validation that can be checked without a live database.

Standalone modules use the JDK directly. From the parent `Java_Adv_Lab` directory:

```powershell
# TCP server/client and serialization demo
$s = (Get-ChildItem ShopSphere\network -Recurse -Filter *.java).FullName
New-Item -ItemType Directory -Force ShopSphere\network\out | Out-Null
javac --release 25 -d ShopSphere\network\out $s
java -cp ShopSphere\network\out com.shopsphere.network.InventoryServer
# In a second terminal:
java -cp ShopSphere\network\out com.shopsphere.network.InventoryClient
java -cp ShopSphere\network\out com.shopsphere.network.InventorySerializationDemo
java -cp ShopSphere\network\out com.shopsphere.network.UrlConnectionDemo

# RMI registry service and client (start in separate terminals)
$s = (Get-ChildItem ShopSphere\rmi -Recurse -Filter *.java).FullName
New-Item -ItemType Directory -Force ShopSphere\rmi\out | Out-Null
javac --release 25 -d ShopSphere\rmi\out $s
java -cp ShopSphere\rmi\out com.shopsphere.rmi.InventoryServer
# In a second terminal:
java -cp ShopSphere\rmi\out com.shopsphere.rmi.InventoryClient

# Swing administration desktop client
$s = (Get-ChildItem ShopSphere\swing-admin -Recurse -Filter *.java).FullName
New-Item -ItemType Directory -Force ShopSphere\swing-admin\out | Out-Null
javac --release 25 -d ShopSphere\swing-admin\out $s
```

The socket server listens on TCP port 5050 by default; its client commands include `LIST`, `GET <sku>`, `RESTOCK <sku> <quantity>`, and `QUIT`. Optional host/port arguments are accepted by the client. The RMI registry defaults to port 1099; its service uses a dynamically assigned RMI endpoint, so remote firewall deployments must permit that endpoint. Both modules are local educational demonstrations.

Swing login uses `SHOPSPHERE_ADMIN_USER` and `SHOPSPHERE_ADMIN_PASSWORD`. It uses the same `SHOPSPHERE_DB_URL`, `SHOPSPHERE_DB_USER`, and `SHOPSPHERE_DB_PASSWORD` variables as the web application. The MySQL Connector/J 9.4.0 runtime jar is available in the local Maven repository after the Maven build:

```powershell
$mysql = "$env:USERPROFILE\.m2\repository\com\mysql\mysql-connector-j\9.4.0\mysql-connector-j-9.4.0.jar"
$env:SHOPSPHERE_ADMIN_USER = 'admin'
$env:SHOPSPHERE_ADMIN_PASSWORD = 'set-a-local-admin-password'
java -cp "ShopSphere\swing-admin\out;$mysql" com.shopsphere.admin.AdminApp
```

## Deploy to the existing Tomcat

From `ShopSphere`, after building and setting the database environment variables:

```powershell
Copy-Item .\target\ShopSphere.war ..\apache-tomcat-11.0.25\webapps\ShopSphere.war
& ..\apache-tomcat-11.0.25\bin\catalina.bat run
```

If Tomcat is already running, copy the WAR into its `webapps` folder and wait for auto-deployment; environment variables must have been set before that Tomcat process started. No Tomcat installation is downloaded, replaced, or included in the WAR. Useful URLs:

- Store: `http://localhost:8080/ShopSphere/`
- Admin login: `http://localhost:8080/ShopSphere/admin/login`
- Health/lifecycle: `http://localhost:8080/ShopSphere/health`
- JNDI lookup: `http://localhost:8080/ShopSphere/jndi-demo`
- Traditional JSP: `http://localhost:8080/ShopSphere/syllabus/traditional-jsp.jsp`
- JSTL XML: `http://localhost:8080/ShopSphere/syllabus/jstl-xml.jsp`
- JSTL SQL (requires the database environment): `http://localhost:8080/ShopSphere/syllabus/jstl-sql`

## Verification status

The web Java source has been compiled against the installed Tomcat 11 Servlet API with JDK 25, Maven `clean package` produced the WAR, all five JUnit tests passed, and Jasper precompiled the JSP/JSTL views with zero errors. The WAR is deployed to the existing Tomcat; health, login, JNDI, traditional JSP and JSTL XML routes were smoke-tested successfully. Socket/serialization and RMI server-client demonstrations were separately compiled and exercised; the Swing sources compile. The current Tomcat process has no ShopSphere database environment variables, so catalog and JSTL SQL routes correctly report service unavailable until database credentials are configured and Tomcat is restarted. A live MySQL-backed checkout still requires those local credentials. Maven 3.9.9 under JDK 25 emits upstream Jansi/Unsafe restricted/deprecation warnings; they do not fail the build.

## RTU mapping

The full topic-to-code crosswalk is in [docs/rtu-syllabus-mapping.md](docs/rtu-syllabus-mapping.md). Security and schema behavior are summarized in [docs/database-and-security.md](docs/database-and-security.md).
