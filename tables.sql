
-- products tablosu
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  is_sponsored BOOLEAN,
  image VARCHAR(255),
  title VARCHAR(255),
  description TEXT,
  category_id INT,
  view_count INT,
  create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- auctions tablosu
CREATE TABLE auctions (
  auction_id INT AUTO_INCREMENT PRIMARY KEY,
  start_time DATETIME,
  end_time DATETIME,
  product_id INT,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- bids tablosu
CREATE TABLE bids (
  bid_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  auction_id INT,
  create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (auction_id) REFERENCES auctions(auction_id)
);

-- categories tablosu

-- favorites tablosu
CREATE TABLE favorites (
  favorite_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);