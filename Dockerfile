# Use the official Python image as the base image
FROM python:3.6.1-alpine

# Update pip to minimize dependency errors
RUN pip install --upgrade pip

# Install the required packages inside the Docker image
RUN apk --no-cache add vim net-tools nginx

# Define the present working directory
WORKDIR /docker-flask-test

# Copy the contents into the working directory
ADD . /docker-flask-test

# Run pip to install the dependencies of the Flask app
RUN pip install -r requirements.txt

# Expose port 5000
EXPOSE 80
EXPOSE 8000

# Define the command to start the container
CMD ["python", "app.py"]

# nginx-server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]