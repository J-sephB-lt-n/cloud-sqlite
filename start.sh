#!/bin/bash/

python periodic_db_backup.py &
gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 flask_app:app
