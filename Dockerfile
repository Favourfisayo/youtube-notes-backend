# Use a Node.js image that is based on Debian
FROM node:18-bullseye

# Avoid interactive prompts during apt-get installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the apt repository and install dependencies (Python and build tools)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 python3-pip ca-certificates curl gnupg build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY . .

# Install Node.js dependencies
RUN npm install

# Install Python dependencies (from the requirements.txt file)
RUN pip3 install --upgrade pip && \
    pip3 install -r backend/requirements.txt

# Expose the port the app will run on
EXPOSE 3000

# Start the backend server (Node.js)
CMD ["node", "index.js"]
