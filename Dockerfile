FROM henrygd/beszel-agent AS builder

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends nvidia-driver-535-server && \
    rm -rf /var/lib/apt/lists/*

# Copy agent from builder stage
COPY --from=builder /agent /agent

ENTRYPOINT ["/agent"]