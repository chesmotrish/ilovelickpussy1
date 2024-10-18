FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone and build Simplex
RUN git clone https://github.com/simplex-chat/simplexmq.git /app
WORKDIR /app
RUN make

# Expose port
EXPOSE 5222

# Run Simplex server
CMD ["./simplexmq"]
