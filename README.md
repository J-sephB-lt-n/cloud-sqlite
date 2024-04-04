# serverless-SQLite-db-on-google-cloud

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


