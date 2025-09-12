#!/bin/bash

# Flutter Web App Auto-Launcher
# This script automatically runs your Flutter web app and opens it in Chrome

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_DIR="/Users/mirthavarshine/Digital Mental Health & Psychological Support System"
WEB_PORT=8080
WEB_HOSTNAME="localhost"
CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

echo -e "${BLUE}🚀 Flutter Web App Auto-Launcher${NC}"
echo -e "${BLUE}================================${NC}"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a port is in use
port_in_use() {
    lsof -i :$1 >/dev/null 2>&1
}

# Function to wait for Flutter to be ready
wait_for_flutter() {
    local max_attempts=30
    local attempt=1
    
    echo -e "${YELLOW}⏳ Waiting for Flutter web app to be ready...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s "http://$WEB_HOSTNAME:$WEB_PORT" >/dev/null 2>&1; then
            echo -e "${GREEN}✅ Flutter web app is ready!${NC}"
            return 0
        fi
        
        echo -e "${YELLOW}   Attempt $attempt/$max_attempts - waiting...${NC}"
        sleep 2
        attempt=$((attempt + 1))
    done
    
    echo -e "${RED}❌ Flutter web app failed to start within 60 seconds${NC}"
    return 1
}

# Function to open Chrome
open_chrome() {
    local url="http://$WEB_HOSTNAME:$WEB_PORT"
    
    echo -e "${BLUE}🌐 Opening Chrome with your Flutter app...${NC}"
    
    if [ -f "$CHROME_PATH" ]; then
        # Open Chrome with the Flutter app URL
        "$CHROME_PATH" --new-window --disable-web-security --disable-features=VizDisplayCompositor "$url" &
        echo -e "${GREEN}✅ Chrome opened with your Flutter app at: $url${NC}"
    else
        echo -e "${YELLOW}⚠️  Chrome not found at expected path. Trying system default...${NC}"
        open "$url"
    fi
}

# Function to cleanup on exit
cleanup() {
    echo -e "\n${YELLOW}🧹 Cleaning up...${NC}"
    # Kill any existing Flutter processes
    pkill -f "flutter run" 2>/dev/null || true
    echo -e "${GREEN}✅ Cleanup complete${NC}"
}

# Set up cleanup trap
trap cleanup EXIT

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}❌ Error: pubspec.yaml not found. Please run this script from your Flutter project root.${NC}"
    exit 1
fi

# Check if Flutter is installed
if ! command_exists flutter; then
    echo -e "${RED}❌ Error: Flutter is not installed or not in PATH${NC}"
    exit 1
fi

# Check if Chrome is available
if [ ! -f "$CHROME_PATH" ] && ! command_exists open; then
    echo -e "${RED}❌ Error: Chrome not found and 'open' command not available${NC}"
    exit 1
fi

# Kill any existing Flutter processes
echo -e "${YELLOW}🔄 Stopping any existing Flutter processes...${NC}"
pkill -f "flutter run" 2>/dev/null || true

# Check if port is available
if port_in_use $WEB_PORT; then
    echo -e "${YELLOW}⚠️  Port $WEB_PORT is in use. Attempting to free it...${NC}"
    lsof -ti :$WEB_PORT | xargs kill -9 2>/dev/null || true
    sleep 2
fi

# Clean and get dependencies
echo -e "${BLUE}🧹 Cleaning project and getting dependencies...${NC}"
flutter clean
flutter pub get

# Check Flutter doctor
echo -e "${BLUE}🔍 Checking Flutter setup...${NC}"
flutter doctor --android-licenses 2>/dev/null || true

# Run Flutter web app in background
echo -e "${BLUE}🚀 Starting Flutter web app on port $WEB_PORT...${NC}"
flutter run -d chrome --web-port $WEB_PORT --web-hostname $WEB_HOSTNAME > flutter_output.log 2>&1 &

# Get the Flutter process ID
FLUTTER_PID=$!
echo -e "${GREEN}✅ Flutter process started with PID: $FLUTTER_PID${NC}"

# Wait for Flutter to be ready
if wait_for_flutter; then
    # Open Chrome
    open_chrome
    
    echo -e "\n${GREEN}🎉 Success! Your Flutter web app is now running!${NC}"
    echo -e "${GREEN}📍 URL: http://$WEB_HOSTNAME:$WEB_PORT${NC}"
    echo -e "${GREEN}🔄 Flutter process PID: $FLUTTER_PID${NC}"
    echo -e "${GREEN}📝 Logs: flutter_output.log${NC}"
    
    echo -e "\n${BLUE}💡 Tips:${NC}"
    echo -e "${BLUE}   • Press Ctrl+C to stop the app${NC}"
    echo -e "${BLUE}   • Check flutter_output.log for detailed logs${NC}"
    echo -e "${BLUE}   • The app will auto-reload when you make changes${NC}"
    
    # Keep the script running and show live logs
    echo -e "\n${BLUE}📊 Live Flutter logs (Press Ctrl+C to stop):${NC}"
    echo -e "${BLUE}===============================================${NC}"
    tail -f flutter_output.log
else
    echo -e "${RED}❌ Failed to start Flutter web app${NC}"
    echo -e "${RED}📝 Check flutter_output.log for details${NC}"
    exit 1
fi

