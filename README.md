# serverless-SQLite-db-on-google-cloud

Create an E2-Micro with read/write access to Cloud Storage

Run the following on the VM:

```bash
sudo apt update 
sudo apt install sqlite3 

# litestream setup #
wget https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.deb
sudo dpkg -i litestream-v0.3.13-linux-amd64.deb
sudo vim /etc/litestream.yml # paste in the litestream config here (https://github.com/J-sephB-lt-n/cloud-sqlite/blob/main/litestream.yml)
sudo systemctl enable litestream
sudo systemctl start litestream
journalctl -u litestream -f # this shows the litestream logs

# create SQL databases #
sudo sqlite3 /var/lib/mydb1.db <<EOF
CREATE TABLE users (user_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);
INSERT INTO users (first_name, last_name) VALUES ('oscar', 'peterson');
INSERT INTO users (first_name, last_name) VALUES ('bill', 'evans');
PRAGMA busy_timeout = 5000;
PRAGMA synchronous = NORMAL;
PRAGMA wal_autocheckpoint = 0;
EOF

sudo sqlite3 /var/lib/mydb2.db <<EOF
CREATE TABLE sales (transaction_id INTEGER PRIMARY KEY, product_id INTEGER, quantity INTEGER);
INSERT INTO sales (product_id, quantity) VALUES (69, 1);
INSERT INTO sales (product_id, quantity) VALUES (4, 20);
PRAGMA busy_timeout = 5000;
PRAGMA synchronous = NORMAL;
PRAGMA wal_autocheckpoint = 0;
EOF
```

To create a new database from a litestream Cloud Storage backup:

```bash
sudo litestream restore -o /var/lib/db_restore_mydb1.db gcs://sqlite-db-litestream-backups/mydb1.db
```

# Old Stuff

The database works as follows:

* The SQLite database file is stored on Google Cloud Storage

* The database is accessed via an endpoint on Google Cloud Run

    - The cloud run service is limited to maximum 1 instance 

    - On instance start, the latest database file backup is downloaded from Google Cloud Storage

    - The database is interacted with via endpoint

Test the container locally:

```bash
$ docker build --tag gcp_sqlite_img .
$ docker run --name local_test \
    -e PORT=5000 \
    -e BACKUP_DB_EVERY_N_SECONDS=10 \
    -p 8000:5000 \
    gcp_sqlite_img
$ curl "http://localhost:8000/health_check" 
$ docker stop local_test
$ docker rm local_test
```


