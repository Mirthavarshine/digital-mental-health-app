#!/bin/bash

# Build script for production environment
# Usage: ./scripts/build_prod.sh

set -e

echo "Building for production environment..."

# Set environment variables
export ENVIRONMENT=production
export VERSION_NAME=1.0.0
export VERSION_CODE=3
export BUILD_NUMBER=3
export GIT_COMMIT_HASH=$(git rev-parse --short HEAD)
export GIT_BRANCH=$(git branch --show-current)
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Build for Android
echo "Building Android APK..."
flutter build apk \
  --flavor prod \
  --dart-define=ENVIRONMENT=production \
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
    --flavor prod \
    --dart-define=ENVIRONMENT=production \
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
  --dart-define=ENVIRONMENT=production \
  --dart-define=VERSION_NAME=$VERSION_NAME \
  --dart-define=VERSION_CODE=$VERSION_CODE \
  --dart-define=BUILD_NUMBER=$BUILD_NUMBER \
  --dart-define=GIT_COMMIT_HASH=$GIT_COMMIT_HASH \
  --dart-define=GIT_BRANCH=$GIT_BRANCH \
  --dart-define=BUILD_DATE=$BUILD_DATE

echo "Production build completed!"
echo "APK location: build/app/outputs/flutter-apk/"
echo "Web location: build/web/"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "iOS location: build/ios/iphoneos/"
fi
