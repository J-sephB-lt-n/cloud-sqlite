FROM python:3.12-slim

# Allow statements and log messages to immediately appear in the Knative logs:
ENV PYTHONUNBUFFERED True

# Copy local code to the container image:
WORKDIR /cloud_sqlite
COPY . ./

# Install production dependencies:
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt
RUN apt update && apt install sqlite3 systemctl vim wget -y
RUN bash setup_litestream.sh
#RUN bash create_db.sh
#RUN bash replicate_db.sh

# Run the web service on container startup. Here we use the gunicorn webserver
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
#CMD ["bash", "start.sh"]


