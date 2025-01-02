# Build stage
FROM rust:1.70-buster as builder

WORKDIR /app

# Accept the build argument
ARG DATABASE_URL

# Make sure to use the ARG in ENV
ENV DATABASE_URL=$DATABASE_URL

# Copy the source code and build the application
COPY . .
RUN cargo build --release && \
    rm -rf /app/target/release/build /app/target/release/deps

# Production stage
FROM debian:buster-slim

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]
