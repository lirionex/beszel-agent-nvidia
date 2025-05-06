# 🛰️ Beszel Agent

This repository builds a Docker image for the `beszel-agent`, based on the `henrygd/beszel-agent` builder image and packages it with NVIDIA driver support.

## 🧱 Docker Image

The final image is based on `ubuntu:24.04` and installs `nvidia-driver-535-server`. It includes the `/agent` binary copied from a multi-stage build.

## 🛠 Build Locally

You can build the image locally using Docker:

```bash
git clone git@github.com:lirionex/beszel-agent-nvidia.git
cd beszel-agent-nvidia
docker build -t beszel-agent-nvidia .
```


## ⚙️ Prerequisites: NVIDIA Container Toolkit

Before running this image, you must install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-docker). This is required for Docker containers to access your system's NVIDIA GPU.

### Install Guide:
👉 [Configure Docker for NVIDIA GPUs](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-docker)

---

## 📦 Run using docker-compose
```yaml
services:
  beszel-agent:
    image: "ghcr.io/lirionex/beszel-agent-nvidia/beszel-agent-nvidia:latest"
    container_name: "beszel-agent"
    restart: unless-stopped
    network_mode: host
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      # monitor other disks / partitions by mounting a folder in /extra-filesystems
      # - /mnt/disk/.beszel:/extra-filesystems/sda1:ro
    environment:
      LISTEN: 45876
      KEY: "ssh-ed25519 YOUR_PUBLIC_KEY"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```