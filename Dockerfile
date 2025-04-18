# Use an official Node.js image with Python and pip preinstalled
FROM node:18-slim

# Set working directory
WORKDIR /app

# Install Python3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy files
COPY . .

# Install Node.js dependencies
RUN npm install

# Install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install -r backend/requirements.txt

# Expose port (change if your app uses a different one)
EXPOSE 3000

# Start the Node.js app (adjust this if you're using another script)
CMD ["node", "index.js"]
