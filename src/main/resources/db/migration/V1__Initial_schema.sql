-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Categories Table
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Create Stores Table
CREATE TABLE stores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    address TEXT
);

-- Create Expenses Table
CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    category_id UUID REFERENCES categories(id),
    store_id UUID REFERENCES stores(id),
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes
CREATE INDEX idx_expenses_user_id ON expenses(user_id);
CREATE INDEX idx_expenses_category_id ON expenses(category_id);
CREATE INDEX idx_expenses_date ON expenses(date);

-- Add Constraint
ALTER TABLE expenses ADD CONSTRAINT check_positive_amount CHECK (amount > 0);

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