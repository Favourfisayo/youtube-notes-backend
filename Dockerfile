# Use an official image with both Python and Node.js
FROM node:18-bullseye

# Install pip and Python dependencies
RUN apt-get update && \
    apt-get install -y python3-pip

# Set working directory
WORKDIR /app

# Copy both frontend and backend files
COPY . .

# Install Node.js dependencies
RUN npm install

# Install Python packages
RUN pip3 install --upgrade pip
RUN PIP_CONFIG_FILE=./pip.conf pip3 install -r requirements.txt

# Set environment variables if needed (can also be set in Render dashboard)

# Command to start your app (change this if you're using something else)
CMD ["npm", "start"]
