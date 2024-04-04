#!/bin/bash

sqlite3 mydb.db <<EOF
CREATE TABLE users (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);
INSERT INTO users (first_name, last_name) VALUES ('john', 'smith');
SELECT * FROM users;
EOF

#litestream replicate mydb.db gcs://sqlite-test-69/db_backups/mydb.db
