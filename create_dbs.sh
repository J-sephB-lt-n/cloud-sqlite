#!/bin/bash

sqlite3 mydb1.db <<EOF
CREATE TABLE users (user_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);
INSERT INTO users (first_name, last_name) VALUES ('oscar', 'peterson');
INSERT INTO users (first_name, last_name) VALUES ('bill', 'evans');
EOF

sqlite3 mydb2.db <<EOF
CREATE TABLE sales (transaction_id INTEGER PRIMARY KEY, product_id INTEGER, quantity INTEGER);
INSERT INTO sales (product_id, quantity) VALUES (69, 1);
INSERT INTO sales (product_id, quantity) VALUES (4, 20);
EOF
