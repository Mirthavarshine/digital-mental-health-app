#!/bin/bash

# Digital Mental Health App - Deployment Script
# This script builds and deploys the Flutter web app

echo "🌸 Digital Mental Health App - Deployment Script"
echo "================================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI is not installed. Installing..."
    npm install -g firebase-tools
fi

echo "🔧 Building Flutter web app..."
flutter clean
flutter pub get
flutter build web --release

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed!"
    exit 1
fi

echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --only hosting

if [ $? -eq 0 ]; then
    echo "✅ Deployment successful!"
    echo "🌐 Your app is now live at: https://your-project-id.web.app"
else
    echo "❌ Deployment failed!"
    exit 1
fi

echo "🎉 Deployment complete!"