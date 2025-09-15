# Use official Python 3.9 image
FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements first (helps Docker cache dependencies)
COPY requirements.txt /app/backend/

# Install system dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app/backend/

# Expose Django port
EXPOSE 8000

# Optional: run migrations (uncomment if needed)
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Run Django server on 0.0.0.0 (shell form)
CMD python manage.py runserver 0.0.0.0:8000
