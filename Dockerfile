# 1. Start from a Node.js base image (with Debian under the hood)
FROM node:18-bullseye

# 2. Tell Debian not to prompt for input during installs
ENV DEBIAN_FRONTEND=noninteractive

# 3. Disable proxy for apt-get by unsetting the variables
ENV http_proxy=""
ENV https_proxy=""
ENV HTTP_PROXY=""
ENV HTTPS_PROXY=""

# 4. Update & install Python + pip + build tools without proxy interference
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3 python3-pip ca-certificates curl gnupg build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 5. Now re‑enable your proxy for all other network traffic
ENV HTTP_PROXY=http://18.217.122.138:8080
ENV HTTPS_PROXY=http://18.217.122.138:8080
# (and lowercase if your tools read that too)
ENV http_proxy=http://18.217.122.138:8080
ENV https_proxy=http://18.217.122.138:8080

# 6. Copy the rest of your backend code
WORKDIR /app
COPY . .

# 7. Install Node dependencies
RUN npm install

# 8. Install Python dependencies through the proxy
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

# 9. Expose your application port
EXPOSE 3000

# 10. Start your server
CMD ["node", "index.js"]
