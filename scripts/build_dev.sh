#!/bin/bash

# Build script for development environment
# Usage: ./scripts/build_dev.sh

set -e

echo "Building for development environment..."

# Set environment variables
export ENVIRONMENT=development
export VERSION_NAME=1.0.0-dev
export VERSION_CODE=1
export BUILD_NUMBER=1
export GIT_COMMIT_HASH=$(git rev-parse --short HEAD)
export GIT_BRANCH=$(git branch --show-current)
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Build for Android
echo "Building Android APK..."
flutter build apk \
  --flavor dev \
  --dart-define=ENVIRONMENT=development \
  --dart-define=VERSION_NAME=$VERSION_NAME \
  --dart-define=VERSION_CODE=$VERSION_CODE \
  --dart-define=BUILD_NUMBER=$BUILD_NUMBER \
  --dart-define=GIT_COMMIT_HASH=$GIT_COMMIT_HASH \
  --dart-define=GIT_BRANCH=$GIT_BRANCH \
  --dart-define=BUILD_DATE=$BUILD_DATE \
  --target-platform android-arm,android-arm64,android-x64 \
  --split-per-abi

# Build for iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Building iOS app..."
  flutter build ios \
    --flavor dev \
    --dart-define=ENVIRONMENT=development \
    --dart-define=VERSION_NAME=$VERSION_NAME \
    --dart-define=VERSION_CODE=$VERSION_CODE \
    --dart-define=BUILD_NUMBER=$BUILD_NUMBER \
    --dart-define=GIT_COMMIT_HASH=$GIT_COMMIT_HASH \
    --dart-define=GIT_BRANCH=$GIT_BRANCH \
    --dart-define=BUILD_DATE=$BUILD_DATE \
    --no-codesign
fi

# Build for Web
echo "Building Web app..."
flutter build web \
  --dart-define=ENVIRONMENT=development \
  --dart-define=VERSION_NAME=$VERSION_NAME \
  --dart-define=VERSION_CODE=$VERSION_CODE \
  --dart-define=BUILD_NUMBER=$BUILD_NUMBER \
  --dart-define=GIT_COMMIT_HASH=$GIT_COMMIT_HASH \
  --dart-define=GIT_BRANCH=$GIT_BRANCH \
  --dart-define=BUILD_DATE=$BUILD_DATE

echo "Development build completed!"
echo "APK location: build/app/outputs/flutter-apk/"
echo "Web location: build/web/"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "iOS location: build/ios/iphoneos/"
fi
