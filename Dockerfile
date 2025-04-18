FROM node:18-slim

# Avoids interaction prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update apt and install Python3 + pip with dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    ca-certificates \
    curl \
    gnupg \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Node.js deps
RUN npm install

# Install Python deps
RUN pip3 install --upgrade pip && \
    pip3 install -r backend/requirements.txt

# Expose port (adjust if needed)
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
