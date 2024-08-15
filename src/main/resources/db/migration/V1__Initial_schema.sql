-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Categories Table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Stores Table
CREATE TABLE stores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    address TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Brands Table
CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    logo TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Measurement Units Table
CREATE TABLE measurement_units (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Package Types Table
CREATE TABLE package_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Package Sizes Table
CREATE TABLE package_sizes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Products Table with foreign key relationships
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INTEGER NOT NULL,
    brand_id INTEGER NOT NULL,
    measurement_unit_id INTEGER,
    package_type_id INTEGER,
    package_size_id INTEGER,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (measurement_unit_id) REFERENCES measurement_units(id),
    FOREIGN KEY (package_type_id) REFERENCES package_types(id),
    FOREIGN KEY (package_size_id) REFERENCES package_sizes(id)
);

-- Create Products-Stores junction table for many-to-many relationship
CREATE TABLE products_stores (
    product_id INTEGER,
    store_id UUID,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, store_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (store_id) REFERENCES stores(id)
);

-- Create Tags Table
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Products-Tags junction table for many-to-many relationship
CREATE TABLE products_tags (
    product_id INTEGER,
    tag_id INTEGER,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, tag_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);

-- Indexes for the products table
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_brand_id ON products(brand_id);
CREATE INDEX idx_products_measurement_unit_id ON products(measurement_unit_id);
CREATE INDEX idx_products_package_type_id ON products(package_type_id);
CREATE INDEX idx_products_package_size_id ON products(package_size_id);

-- Indexes for the products_stores junction table
CREATE INDEX idx_products_stores_product_id ON products_stores(product_id);
CREATE INDEX idx_products_stores_store_id ON products_stores(store_id);

-- Indexes for the products_tags junction table
CREATE INDEX idx_products_tags_product_id ON products_tags(product_id);
CREATE INDEX idx_products_tags_tag_id ON products_tags(tag_id);

-- Create a trigger function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger function to the users table
CREATE TRIGGER update_users_timestamp
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the categories table
CREATE TRIGGER update_categories_timestamp
BEFORE UPDATE ON categories
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the stores table
CREATE TRIGGER update_stores_timestamp
BEFORE UPDATE ON stores
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the brands table
CREATE TRIGGER update_brands_timestamp
BEFORE UPDATE ON brands
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the measurement_units table
CREATE TRIGGER update_measurement_units_timestamp
BEFORE UPDATE ON measurement_units
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the package_types table
CREATE TRIGGER update_package_types_timestamp
BEFORE UPDATE ON package_types
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the package_sizes table
CREATE TRIGGER update_package_sizes_timestamp
BEFORE UPDATE ON package_sizes
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the products table
CREATE TRIGGER update_products_timestamp
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the products_stores table
CREATE TRIGGER update_products_stores_timestamp
BEFORE UPDATE ON products_stores
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the tags table
CREATE TRIGGER update_tags_timestamp
BEFORE UPDATE ON tags
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Apply the trigger function to the products_tags table
CREATE TRIGGER update_products_tags_timestamp
BEFORE UPDATE ON products_tags
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Insert Initial Categories
INSERT INTO categories (name) VALUES 
('Fruits & Vegetables'),
('Meat & Seafood'),
('Dairy & Eggs'),
('Bakery'),
('Pantry Staples'),
('Snacks'),
('Beverages'),
('Household');