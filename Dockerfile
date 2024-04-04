FROM python:3.12-slim

# Allow statements and log messages to immediately appear in the Knative logs:
ENV PYTHONUNBUFFERED True

# Copy local code to the container image:
WORKDIR /serverless-SQLite-db-on-google-cloud
COPY . ./

# Install production dependencies:
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn webserver
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD ["bash", "start.sh"]


