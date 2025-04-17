FROM alpine:latest

ARG PB_VERSION=0.27.0

RUN apk add --no-cache \
    unzip \
    ca-certificates

# Download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Create pb_public directory
RUN mkdir -p /pb/pb_public

# Optional: Copy static files into pb_public (if you have any)
COPY ./pb_public/ /pb/pb_public/

EXPOSE 8080

# Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
