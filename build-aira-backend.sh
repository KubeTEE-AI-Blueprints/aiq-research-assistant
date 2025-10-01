#!/bin/bash

# AIQ AIRA Backend Container Build and Push Script
# This script builds the AIQ AIRA backend container from source and pushes it to DockerHub
#
# Usage:
#   ./build-aira-backend.sh [dockerhub-username] [tag]
#
# Examples:
#   ./build-aira-backend.sh                                # Uses default: pamanseau/aira-backend:v1.2.0
#   ./build-aira-backend.sh myusername                     # Uses: myusername/aira-backend:v1.2.0
#   ./build-aira-backend.sh myusername v1.3.0              # Uses: myusername/aira-backend:v1.3.0
#
# Prerequisites:
#   - Docker installed and running
#   - DockerHub account with push permissions
#   - Logged into DockerHub (docker login)

set -e  # Exit on any error

# Default values
DEFAULT_USERNAME="pamanseau"
DEFAULT_TAG="v1.2.0"
DEFAULT_IMAGE_NAME="aira-backend"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"

# Parse command line arguments
DOCKERHUB_USERNAME="${1:-$DEFAULT_USERNAME}"
TAG="${2:-$DEFAULT_TAG}"
IMAGE_NAME="${3:-$DEFAULT_IMAGE_NAME}"

# Construct full image name
FULL_IMAGE_NAME="${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${TAG}"
LATEST_IMAGE_NAME="${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"

echo "=========================================="
echo "AIQ AIRA Backend Container Build & Push"
echo "=========================================="
echo "DockerHub Username: $DOCKERHUB_USERNAME"
echo "Image Name: $IMAGE_NAME"
echo "Tag: $TAG"
echo "Full Image Name: $FULL_IMAGE_NAME"
echo "Latest Image Name: $LATEST_IMAGE_NAME"
echo "Platform: linux/amd64"
echo "Project Root: $PROJECT_ROOT"
echo "=========================================="

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if user is logged into DockerHub
if ! docker info | grep -q "Username:"; then
    echo "⚠️  Warning: You may not be logged into DockerHub."
    echo "   Run 'docker login' if you encounter authentication errors."
fi

# Navigate to project root
cd "$PROJECT_ROOT"

# Verify Dockerfile exists
if [ ! -f "deploy/Dockerfile" ]; then
    echo "❌ Error: Dockerfile not found at deploy/Dockerfile"
    echo "   Make sure you're running this script from the AIQ Research Assistant root directory."
    exit 1
fi

echo ""
echo "🔨 Building container..."
echo "   Dockerfile: deploy/Dockerfile"
echo "   Context: . (current directory)"
echo "   Platform: linux/amd64"
echo ""

# Build the container with multi-platform support
docker build \
    --platform linux/amd64 \
    --file deploy/Dockerfile \
    --tag "$FULL_IMAGE_NAME" \
    --tag "$LATEST_IMAGE_NAME" \
    --progress=plain \
    .

if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
else
    echo "❌ Build failed!"
    exit 1
fi

echo ""
echo "📦 Image details:"
docker images | grep "$DOCKERHUB_USERNAME/$IMAGE_NAME" | head -2

echo ""
echo "🚀 Pushing to DockerHub..."
echo "   Pushing: $FULL_IMAGE_NAME"
docker push "$FULL_IMAGE_NAME"

if [ $? -eq 0 ]; then
    echo "✅ Successfully pushed $FULL_IMAGE_NAME"
else
    echo "❌ Failed to push $FULL_IMAGE_NAME"
    exit 1
fi

echo ""
echo "🚀 Pushing latest tag..."
echo "   Pushing: $LATEST_IMAGE_NAME"
docker push "$LATEST_IMAGE_NAME"

if [ $? -eq 0 ]; then
    echo "✅ Successfully pushed $LATEST_IMAGE_NAME"
else
    echo "❌ Failed to push $LATEST_IMAGE_NAME"
    exit 1
fi

echo ""
echo "🎉 Build and push completed successfully!"
echo ""
echo "📋 Summary:"
echo "   Image: $FULL_IMAGE_NAME"
echo "   Latest: $LATEST_IMAGE_NAME"
echo "   Platform: linux/amd64"
echo ""
echo "🔗 DockerHub URLs:"
echo "   https://hub.docker.com/r/$DOCKERHUB_USERNAME/$IMAGE_NAME"
echo ""
echo "💡 Usage examples:"
echo "   docker pull $FULL_IMAGE_NAME"
echo "   docker run -p 3838:3838 $FULL_IMAGE_NAME"
echo ""
echo "📝 To use in Kubernetes/Helm:"
echo "   Update your values.yaml:"
echo "   image:"
echo "     repository: $DOCKERHUB_USERNAME/$IMAGE_NAME"
echo "     tag: $TAG"
echo ""

# Optional: Clean up local images to save space
read -p "🗑️  Do you want to remove local images to save space? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Cleaning up local images..."
    docker rmi "$FULL_IMAGE_NAME" "$LATEST_IMAGE_NAME" 2>/dev/null || true
    echo "✅ Local images removed"
fi

echo ""
echo "✨ Done!"
