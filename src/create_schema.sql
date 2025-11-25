BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE order_backorders PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE products PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE seq_backorder_id';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE t_order_table';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE t_order_item';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE t_recent_products';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Create products table
CREATE TABLE products (
  product_id    NUMBER PRIMARY KEY,
  product_code  VARCHAR2(30) UNIQUE,
  description   VARCHAR2(200),
  qty_on_hand   NUMBER,
  reorder_level NUMBER,
  unit_price    NUMBER(10,2)
);

-- Create backorders log table
CREATE TABLE order_backorders (
  backorder_id  NUMBER PRIMARY KEY,
  product_id    NUMBER,
  requested_qty NUMBER,
  created_at    DATE DEFAULT SYSDATE
);

-- Sequence for backorder ids
CREATE SEQUENCE seq_backorder_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- SQL object type for an order item (used by nested table)
CREATE OR REPLACE TYPE t_order_item AS OBJECT (
  product_id NUMBER,
  qty        NUMBER
);
/

CREATE OR REPLACE TYPE t_order_table AS TABLE OF t_order_item;
/

-- VARRAY type for recent product codes
CREATE OR REPLACE TYPE t_recent_products AS VARRAY(5) OF VARCHAR2(30);
/
