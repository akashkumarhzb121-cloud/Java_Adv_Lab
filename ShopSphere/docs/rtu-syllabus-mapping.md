# RTU Advanced Java syllabus mapping

| Syllabus topic | ShopSphere implementation |
|---|---|
| Swing | `swing-admin/` contains the desktop administration client and its MVC UI. |
| MVC | Swing separates views/controllers/DAO; the web app separates JSP views, servlet controllers, services and DAOs. |
| JDBC | `web/src/main/java/com/shopsphere/util/Database.java` and DAO classes use JDBC with prepared statements. |
| Socket / ServerSocket | The `network/` module provides an inventory TCP server and client. |
| Client-server | Socket and RMI clients communicate with independent Java server processes. |
| RMI | `rmi/` exports inventory methods through Java Remote Method Invocation. |
| RMI Registry | The RMI server creates/binds its service to a registry; clients look up the binding. |
| JNDI | `/jndi-demo` resolves `java:comp/env/demo/greeting`, configured in `web/src/main/webapp/META-INF/context.xml`. |
| Serialization | The network module includes serializable transfer objects and object-stream exercises. |
| URL / URLConnection | `network/com/shopsphere/network/UrlConnectionDemo.java` performs a bounded HTTP(S) URLConnection request. |
| Internationalization | `ResourceBundle` files under `web/src/main/resources/com/shopsphere/` provide English/Hindi labels; locale selection is session-scoped. |
| URL / URLConnection | The network syllabus exercise demonstrates HTTP URL connections without coupling them to checkout. |
| Applets | Applets are obsolete and unsupported in modern browsers; historical context is covered in `docs/legacy-applets.md` only. |
| J2EE / Jakarta EE | Servlet 6.1, JSP, EL and JSTL are packaged as a WAR for Tomcat 11. |
| N-tier architecture | Browser/JSP → Servlet → Service → DAO → JDBC → MySQL. |
| HTTP | Browser routes are mapped to servlet controllers with GET/POST semantics. |
| Web container | Tomcat 11 hosts the WAR, JSP engine, filters, listeners and JNDI context. |
| Servlets | The `controller/` package contains customer, admin, health, JNDI, locale and syllabus servlets. |
| Sessions | Authenticated `User` objects are kept in `HttpSession`; session fixation is mitigated at login. |
| Events | `ApplicationListener` and `SessionListener` observe application/session lifecycle events. |
| Filters | Authentication, admin authorization and CSRF validation are implemented in `filter/`. |
| JSP | JSP pages in `WEB-INF/views` render customer/admin screens; an isolated legacy syntax exercise is under `/syllabus/`. |
| EL | The view pages render JavaBeans/model values through Expression Language. |
| Tag extensions | `WEB-INF/tags/productCard.tag` and `rating.tag` are reusable JSP tag files. |
| JSP fragments | Shared header, navbar, footer and admin sidebar live under `WEB-INF/fragments/`. |
| JSTL core / functions | JSTL core is used for iteration, conditions and output; locale-aware formatting uses the fmt library. |
| JSTL XML / SQL | Isolated exercises under `/syllabus/jstl-xml.jsp` and `/syllabus/jstl-sql` demonstrate those optional tags; production paths remain DAO-based. |

The syllabus examples are separate from the production shopping path so they do not weaken the application's layered architecture.
