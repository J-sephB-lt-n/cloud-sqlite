# serverless-SQLite-db-on-google-cloud

Create an E2-Micro with read/write access to Cloud Storage

Run the following on the VM:

```bash
# set up "db_admin" permission group #
sudo groupadd db_admin
sudo usermod --append --groups db_admin joseph_bolton # add myself to the group
su joseph_bolton # log in again to make the group change take effect
id joseph_bolton 

sudo mkdir /var/lib/sqlite_databases/
sudo chgrp db_admin /var/lib/sqlite_databases/
sudo chmod g+rwx /var/lib/sqlite_databases/

# setup dev environment #
wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/setup_joes_dev_environment.sh
sudo bash setup_joes_dev_environment.sh
rm setup_joes_dev_environment.sh

# litestream setup #
wget https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.deb
sudo dpkg -i litestream-v0.3.13-linux-amd64.deb
sudo chgrp db_admin /etc/litestream.yml
sudo chmod g+w /etc/litestream.yml
echo "
dbs:
  - path: /var/lib/sqlite_databases/test_db.db
    replicas:
      - url: gcs://sqlite-db-litestream-backups/test_db.db
" > /etc/litestream.yml
sudo systemctl enable litestream
sudo systemctl start litestream
journalctl -u litestream -f # this shows the litestream logs

# create SQL databases #
sudo apt-get install sqlite3 

sqlite3 /var/lib/sqlite_databases/test_db.db <<EOF
CREATE TABLE users (user_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);
INSERT INTO users (first_name, last_name) VALUES ('oscar', 'peterson');
INSERT INTO users (first_name, last_name) VALUES ('bill', 'evans');
PRAGMA busy_timeout = 5000;
PRAGMA synchronous = NORMAL;
PRAGMA wal_autocheckpoint = 0;
EOF
```

To create a new database from a litestream Cloud Storage backup:

```bash
litestream restore -o /var/lib/db_restore_mydb1.db gcs://sqlite-db-litestream-backups/test_db.db
```

Set up the python flask/gunicorn app:
```bash
sudo apt-get install -y python3-pip
sudo apt-get install -y python3.11-venv
python3 -m venv venv
source venv/bin/activate
pip3 install Flask gunicorn
```


