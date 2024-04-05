FROM python:3.12-slim

# Allow statements and log messages to immediately appear in the Knative logs:
ENV PYTHONUNBUFFERED True

# Copy local code to the container image:
WORKDIR /cloud_sqlite
COPY . ./

# Install production dependencies:
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt
RUN apt update && apt install sqlite3 systemctl vim wget -y

CMD ["bash", "startup.sh"]


