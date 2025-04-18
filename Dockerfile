FROM node:18-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV HTTP_PROXY=http://18.217.122.138:8080
ENV HTTPS_PROXY=http://18.217.122.138:8080
# Update and install Python and deps
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

WORKDIR /app

COPY . .

RUN npm install

RUN pip3 install --upgrade pip && \
    pip3 install -r backend/requirements.txt

EXPOSE 3000

CMD ["node", "index.js"]
