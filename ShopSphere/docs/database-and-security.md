# Database and security notes

## Database

Import `database/shopsphere.sql` into MySQL 8.0 or newer. The script creates the `shopsphere` schema, all core e-commerce tables, constraints and indexes, sample catalog entries, a development coupon, and two development-only accounts.

The application reads only `SHOPSPHERE_DB_URL`, `SHOPSPHERE_DB_USER`, and `SHOPSPHERE_DB_PASSWORD` from its process environment. Create an application-specific MySQL user with only the permissions needed by the schema and app; do not use the MySQL root account in the running application.

## Security behavior

- Passwords use salted PBKDF2-HMAC-SHA-256 hashes; no password is stored in a cookie.
- User-controlled values are bound through JDBC `PreparedStatement` parameters.
- Checkout locks cart inventory rows, validates stock/coupons and writes the order, payment record, usage and inventory changes in one transaction.
- The mock-card path never requests or stores actual card data.
- Sessions use HTTP-only cookies and cookie-only session tracking; login rotates the session id.
- Mutating POST routes require a session-bound CSRF token. Customer routes and `/admin/*` require authenticated role checks.
- Order ownership is checked on customer detail requests; all totals are recomputed on the server.
- Generic database errors are logged server-side and are not returned to the browser with SQL details.

For production use, replace the development seed accounts, use HTTPS, rotate database credentials, and configure stronger operational controls such as rate limiting and backups.
