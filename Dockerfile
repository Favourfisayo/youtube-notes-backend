# 1. Use the full Node.js base (has Python + pip available)
FROM node:18-bullseye

# 2. Non‑interactive apt and proxy settings for apt
ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy=http://18.217.122.138:8080
ENV https_proxy=http://18.217.122.138:8080
ENV HTTP_PROXY=http://18.217.122.138:8080
ENV HTTPS_PROXY=http://18.217.122.138:8080

# 3. Update apt and install Python + pip + build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3 python3-pip ca-certificates curl gnupg build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 4. Set workdir
WORKDIR /app

# 5. Copy backend files
COPY . .

# 6. Install Node.js dependencies
RUN npm install

# 7. Upgrade pip and install Python deps
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

# 8. Expose your port
EXPOSE 3000

# 9. Start your Node server
CMD ["node", "index.js"]
