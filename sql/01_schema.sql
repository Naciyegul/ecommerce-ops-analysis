-- ============================================================
-- E-Commerce Operations Analysis - Database Schema
-- Author: Naciye Gul Aydogan
-- Tool: SQLite (DB Browser for SQLite)
-- ============================================================

-- Orders table: all marketplace orders across platforms
CREATE TABLE IF NOT EXISTS orders (
    order_id        TEXT PRIMARY KEY,
    order_date      DATE NOT NULL,
    platform        TEXT NOT NULL,       -- Trendyol, Hepsiburada, GuvenliCalis
    sku_id          TEXT NOT NULL,
    product_name    TEXT,
    category        TEXT,
    quantity        INTEGER,
    unit_price      REAL,
    total_revenue   REAL,
    commission      REAL,
    net_revenue     REAL,
    customer_city   TEXT,
    order_status    TEXT,                -- Delivered, Shipped, Processing, Returned, Cancelled
    shipping_days   INTEGER,
    supplier_name   TEXT
);

-- Products table: SKU catalog with compliance info
CREATE TABLE IF NOT EXISTS products (
    sku_id              TEXT PRIMARY KEY,
    product_name        TEXT,
    category            TEXT,
    unit_price          REAL,
    supplier_name       TEXT,
    supplier_city       TEXT,
    has_ce              TEXT,            -- Yes / No
    has_tse             TEXT,            -- Yes / No
    stock_quantity      INTEGER,
    return_rate_category REAL
);

-- Supplier Performance table: monthly KPIs per supplier
CREATE TABLE IF NOT EXISTS supplier_performance (
    month               TEXT,
    supplier_name       TEXT,
    supplier_city       TEXT,
    orders_fulfilled    INTEGER,
    on_time_delivery_pct REAL,
    defect_rate_pct     REAL,
    avg_lead_days       INTEGER,
    quality_score       REAL,
    ce_compliance       TEXT,
    tse_compliance      TEXT
);
