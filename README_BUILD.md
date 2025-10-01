# AIQ AIRA Backend Container Build Guide

## Overview

This guide provides complete instructions for building and pushing the AIQ AIRA backend container to DockerHub. The build process creates a production-ready container from the source code in the `aira/` directory.

## Quick Start

### Prerequisites
- **Docker** installed and running
- **DockerHub account** with push permissions
- **Logged into DockerHub** (`docker login`)

### Build and Push
```bash
# Default build: pamanseau/aira-backend:v1.2.0
./build-aira-backend.sh

# Custom username: myusername/aira-backend:v1.2.0
./build-aira-backend.sh myusername

# Custom username and tag: myusername/aira-backend:v1.3.0
./build-aira-backend.sh myusername v1.3.0
```

## Script Usage

### Basic Syntax
```bash
./build-aira-backend.sh [dockerhub-username] [tag] [image-name]
```

### Parameters
| Parameter | Default | Description |
|-----------|---------|-------------|
| `dockerhub-username` | `pamanseau` | Your DockerHub username |
| `tag` | `v1.2.0` | Container version tag |
| `image-name` | `aira-backend` | Docker image name |

### Examples

#### Default Build
```bash
./build-aira-backend.sh
# Result: pamanseau/aira-backend:v1.2.0
```

#### Custom Username
```bash
./build-aira-backend.sh myusername
# Result: myusername/aira-backend:v1.2.0
```

#### Custom Username and Tag
```bash
./build-aira-backend.sh myusername v1.3.0
# Result: myusername/aira-backend:v1.3.0
```

#### Custom Everything
```bash
./build-aira-backend.sh myusername v1.3.0 my-aira-backend
# Result: myusername/my-aira-backend:v1.3.0
```

## Build Process

### Multi-Stage Build
The Dockerfile uses a multi-stage build process:

1. **Builder Stage**:
   - Uses `ghcr.io/astral-sh/uv:python3.12-bookworm`
   - Installs Python dependencies
   - Builds the `aiq-aira` package

2. **Final Stage**:
   - Uses `nvcr.io/nvidia/base/ubuntu:jammy-20250619`
   - Installs runtime dependencies
   - Copies built package
   - Sets up configuration

### Platform Support
- **Target Platform**: `linux/amd64`
- **Cross-Platform**: Supported via Docker BuildKit
- **Architecture**: x86_64 (Intel/AMD)

### Build Features
- ✅ **Multi-platform builds** (linux/amd64)
- ✅ **Layer caching** for faster rebuilds
- ✅ **Security scanning** compatible
- ✅ **Production optimized**
- ✅ **Health check ready**

## Container Specifications

### Base Image
- **OS**: Ubuntu 22.04 LTS (Jammy)
- **Python**: 3.12
- **Package Manager**: uv (ultra-fast Python package manager)

### Runtime Configuration
- **Working Directory**: `/app`
- **Port**: 3838 (configurable)
- **User**: Non-root (security best practice)
- **Entrypoint**: `/entrypoint.sh`

### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `NIM_SERVER_PORT` | Backend server port | 3838 |
| `NIM_HTTP_API_PORT` | HTTP API port | 3838 |
| `NIM_GRPC_API_PORT` | gRPC API port | 8001 |
| `NIM_LOG_LEVEL` | Logging level | INFO |

## Deployment Integration

### Kubernetes/Helm Integration
Update your `values.yaml`:

```yaml
image:
  repository: pamanseau/aira-backend
  tag: v1.2.0
  pullPolicy: IfNotPresent
```

### Docker Compose Integration
```yaml
services:
  aira-backend:
    image: pamanseau/aira-backend:v1.2.0
    ports:
      - "3838:3838"
    environment:
      - NVIDIA_API_KEY=${NVIDIA_API_KEY}
      - TAVILY_API_KEY=${TAVILY_API_KEY}
```

## Troubleshooting

### Common Issues

#### 1. Docker Not Running
```bash
❌ Error: Docker is not running
```
**Solution**: Start Docker Desktop or Docker daemon

#### 2. Authentication Failed
```bash
❌ Failed to push to DockerHub
```
**Solution**: Run `docker login` and enter your credentials

#### 3. Build Context Issues
```bash
❌ Error: Dockerfile not found
```
**Solution**: Ensure you're in the AIQ Research Assistant root directory

#### 4. Platform Issues
```bash
❌ Error: Platform linux/amd64 not supported
```
**Solution**: Update Docker to latest version with BuildKit support

### Build Optimization

#### Enable BuildKit
```bash
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
```

#### Parallel Builds
```bash
# Build multiple tags simultaneously
docker build --platform linux/amd64 -t pamanseau/aira-backend:v1.2.0 -t pamanseau/aira-backend:latest .
```

#### Cache Optimization
```bash
# Use build cache for faster rebuilds
docker build --cache-from pamanseau/aira-backend:latest .
```

## Security Considerations

### Image Security
- ✅ **Non-root user** in container
- ✅ **Minimal base image** (Ubuntu LTS)
- ✅ **No unnecessary packages**
- ✅ **Security updates** applied

### Registry Security
- 🔐 **Private repositories** recommended for production
- 🔐 **Image signing** with Docker Content Trust
- 🔐 **Vulnerability scanning** with Docker Scout

## Monitoring and Maintenance

### Health Checks
```bash
# Test container health
docker run --rm pamanseau/aira-backend:v1.2.0 curl -f http://localhost:3838/health
```

### Log Monitoring
```bash
# View container logs
docker logs <container-id>
```

### Updates
```bash
# Pull latest version
docker pull pamanseau/aira-backend:latest

# Update running container
docker-compose pull && docker-compose up -d
```

## Usage Examples

### Basic Usage
```bash
# Default build
./build-aira-backend.sh
# Result: pamanseau/aira-backend:v1.2.0

# Custom username
./build-aira-backend.sh myusername
# Result: myusername/aira-backend:v1.2.0

# Custom username and tag
./build-aira-backend.sh myusername v1.3.0
# Result: myusername/aira-backend:v1.3.0
```

### Docker Usage
```bash
# Pull and run
docker pull pamanseau/aira-backend:v1.2.0
docker run -p 3838:3838 pamanseau/aira-backend:v1.2.0
```

## Support and Resources

### Documentation
- [AIQ Research Assistant README](../README.md)
- [Local Development Guide](docs/local-development.md)
- [Docker Documentation](https://docs.docker.com/)

### Community
- [NVIDIA AIQ Toolkit](https://github.com/NVIDIA/NeMo-Agent-Toolkit)
- [NVIDIA RAG Blueprint](https://github.com/NVIDIA-AI-Blueprints/rag)

### Issues
- Report issues in the [GitHub repository](https://github.com/NVIDIA-AI-Blueprints/aiq-research-assistant)
- Check [troubleshooting guide](docs/troubleshooting.md)

---

**Last Updated**: September 26, 2025  
**Version**: v1.2.0  
**Maintainer**: AIQ Research Assistant Team



