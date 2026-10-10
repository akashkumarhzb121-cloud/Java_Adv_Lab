CREATE DATABASE IF NOT EXISTS shopsphere
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE shopsphere;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(254) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('CUSTOMER','ADMIN') NOT NULL DEFAULT 'CUSTOMER',
  phone VARCHAR(30),
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_users_role_active (role, active)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS addresses (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  label VARCHAR(40) NOT NULL DEFAULT 'Home',
  line1 VARCHAR(180) NOT NULL,
  line2 VARCHAR(180),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  country VARCHAR(80) NOT NULL DEFAULT 'India',
  is_default BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT fk_addresses_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_addresses_user (user_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categories (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  slug VARCHAR(120) NOT NULL UNIQUE,
  description VARCHAR(500),
  active BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS products (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  category_id BIGINT NOT NULL,
  name VARCHAR(180) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  image_url VARCHAR(1000),
  price DECIMAL(12,2) NOT NULL,
  discount_percent DECIMAL(5,2) NOT NULL DEFAULT 0,
  stock INT NOT NULL DEFAULT 0,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id),
  CONSTRAINT chk_products_price CHECK (price >= 0),
  CONSTRAINT chk_products_discount CHECK (discount_percent BETWEEN 0 AND 100),
  CONSTRAINT chk_products_stock CHECK (stock >= 0),
  INDEX idx_products_category_active (category_id, active),
  INDEX idx_products_name (name),
  INDEX idx_products_stock (stock)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS cart (
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, product_id),
  CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  CONSTRAINT chk_cart_quantity CHECK (quantity > 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS wishlist (
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, product_id),
  CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS coupons (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(40) NOT NULL UNIQUE,
  discount_percent DECIMAL(5,2) NOT NULL,
  minimum_order DECIMAL(12,2) NOT NULL DEFAULT 0,
  starts_at DATETIME NOT NULL,
  expires_at DATETIME NOT NULL,
  usage_limit INT,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT chk_coupon_percent CHECK (discount_percent BETWEEN 0.01 AND 100),
  INDEX idx_coupons_active_dates (active, starts_at, expires_at)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  address_id BIGINT NOT NULL,
  status ENUM('PLACED','PROCESSING','SHIPPED','DELIVERED','CANCELLED') NOT NULL DEFAULT 'PLACED',
  subtotal DECIMAL(12,2) NOT NULL,
  discount DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL,
  coupon_id BIGINT,
  placed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_orders_address FOREIGN KEY (address_id) REFERENCES addresses(id),
  CONSTRAINT fk_orders_coupon FOREIGN KEY (coupon_id) REFERENCES coupons(id),
  INDEX idx_orders_user_date (user_id, placed_at),
  INDEX idx_orders_status_date (status, placed_at)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  product_name VARCHAR(180) NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  quantity INT NOT NULL,
  CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id),
  CONSTRAINT chk_order_item_quantity CHECK (quantity > 0),
  INDEX idx_order_items_order (order_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT NOT NULL UNIQUE,
  method ENUM('MOCK_CARD','CASH_ON_DELIVERY') NOT NULL,
  status ENUM('PENDING','PAID','FAILED','REFUNDED') NOT NULL DEFAULT 'PENDING',
  amount DECIMAL(12,2) NOT NULL,
  transaction_ref VARCHAR(80) NOT NULL UNIQUE,
  paid_at TIMESTAMP NULL,
  CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS reviews (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  order_id BIGINT,
  rating TINYINT NOT NULL,
  title VARCHAR(120),
  body VARCHAR(2000),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  CONSTRAINT fk_reviews_order FOREIGN KEY (order_id) REFERENCES orders(id),
  CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
  UNIQUE KEY uq_review_user_product (user_id, product_id),
  INDEX idx_reviews_product_date (product_id, created_at)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS coupon_usage (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  coupon_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  order_id BIGINT NOT NULL UNIQUE,
  used_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_coupon_usage_coupon FOREIGN KEY (coupon_id) REFERENCES coupons(id),
  CONSTRAINT fk_coupon_usage_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_coupon_usage_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  UNIQUE KEY uq_coupon_user (coupon_id, user_id)
) ENGINE=InnoDB;

INSERT IGNORE INTO categories (id, name, slug, description) VALUES
  (1, 'Electronics', 'electronics', 'Everyday technology and accessories'),
  (2, 'Home & Living', 'home-living', 'Thoughtful essentials for your home'),
  (3, 'Fashion', 'fashion', 'Comfortable, modern wardrobe staples'),
  (4, 'Books', 'books', 'Ideas, stories, and learning');

INSERT IGNORE INTO users (id, full_name, email, password_hash, role) VALUES
  (1, 'ShopSphere Administrator', 'admin@shopsphere.local',
   'pbkdf2-sha256$210000$c2hvcHNwaGVyZS1hZG1pbi0yMDI2$HAZj9oINeHefe92O3/LMV1WF0fyp5YymIO94kBgDQ/E=', 'ADMIN'),
  (2, 'Demo Customer', 'customer@shopsphere.local',
   'pbkdf2-sha256$210000$c2hvcHNwaGVyZS1jdXN0b21lci0yMDI2$5ciIO7+BIgXp+XVuEEHwrXUQxURFg1cJz8uSUQxy4hU=', 'CUSTOMER');

INSERT IGNORE INTO products
  (id, category_id, name, slug, description, image_url, price, discount_percent, stock) VALUES
  (1, 1, 'Aurora Wireless Headphones', 'aurora-wireless-headphones',
   'Comfort-fit wireless headphones with clear sound, Bluetooth connectivity, and a long-lasting battery.',
   'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80', 3999.00, 15, 35),
  (2, 1, 'Pulse Smart Watch', 'pulse-smart-watch',
   'Track activity and notifications with a bright display and water-resistant everyday design.',
   'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80', 5499.00, 10, 22),
  (3, 2, 'Studio Ceramic Lamp', 'studio-ceramic-lamp',
   'A warm, minimal ceramic table lamp designed for reading corners and bedside tables.',
   'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=800&q=80', 2499.00, 0, 18),
  (4, 3, 'Everyday Canvas Backpack', 'everyday-canvas-backpack',
   'Durable canvas backpack with a padded laptop sleeve and room for daily essentials.',
   'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80', 1899.00, 20, 40),
  (5, 4, 'The Design of Everyday Things', 'design-of-everyday-things',
   'A practical exploration of how thoughtful design makes everyday products easier to use.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=800&q=80', 799.00, 5, 50),
  (6, 2, 'Linen Throw Blanket', 'linen-throw-blanket',
   'A soft, breathable throw blanket in a neutral tone for relaxed living spaces.',
   'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80', 1599.00, 12, 27);

INSERT IGNORE INTO coupons
  (code, discount_percent, minimum_order, starts_at, expires_at, usage_limit, active)
VALUES
  ('WELCOME10', 10, 500, CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 YEAR), 1000, TRUE);
