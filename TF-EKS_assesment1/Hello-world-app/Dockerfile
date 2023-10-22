# Use the official Python image as a parent image
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY ./hello-world.py .

# Install Flask and other dependencies
RUN pip install flask

# Expose the port the apsp runs on
EXPOSE 5000 

# Define the command to run the application
CMD ["python3", "hello-world.py"]
