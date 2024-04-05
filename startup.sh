#!/bin/bash/

/bin/bash ./setup_litestream.sh
/bin/bash ./create_dbs.sh
#/bin/bash ./pull_dbs.sh
#gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 flask_app:app
