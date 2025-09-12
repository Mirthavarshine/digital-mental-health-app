#!/bin/bash

# Quick Flutter Web Launcher - Super Simple Version
# Just run this script and it will handle everything automatically

echo "🚀 Quick Flutter Web Launcher"
echo "============================="

# Kill any existing Flutter processes
pkill -f "flutter run" 2>/dev/null || true

# Clean and get dependencies
echo "🧹 Cleaning and getting dependencies..."
flutter clean >/dev/null 2>&1
flutter pub get >/dev/null 2>&1

# Run Flutter web app and open Chrome
echo "🚀 Starting Flutter web app..."
echo "✅ Opening Chrome automatically..."
echo "📍 Your app will be available at: http://localhost:8080"
echo ""
echo "💡 Press Ctrl+C to stop the app"
echo ""

# Run Flutter with auto-open Chrome
flutter run -d chrome --web-port 8080

