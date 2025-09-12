#!/bin/bash

# SIH 2025 Flutter App Deployment Script
echo "🚀 Starting deployment for SIH 2025 Demo..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for web
echo "🔨 Building Flutter web app..."
flutter build web --release --web-renderer canvaskit

# Deploy to Firebase
echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --only hosting

echo "✅ Deployment complete!"
echo "🌐 Your app is live at: https://your-project-id.web.app"
echo "📱 Demo ready for SIH 2025!"
