# 🚀 Complete Setup Guide - Digital Mental Health & Psychological Support System

## 📋 Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Firebase project
- OpenAI API key
- Android Studio / Xcode (for mobile development)

## 🛠️ Step-by-Step Setup

### 1. Clone and Install Dependencies

```bash
# Clone the repository
git clone <your-repo-url>
cd "Digital Mental Health & Psychological Support System"

# Install Flutter dependencies
flutter pub get
```

### 2. Firebase Project Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `mental-health-support`
4. Enable Google Analytics (optional)
5. Create project

#### Enable Required Services

**Authentication:**
1. Go to Authentication → Sign-in method
2. Enable Email/Password
3. Enable Google Sign-In
4. Configure OAuth consent screen

**Firestore Database:**
1. Go to Firestore Database
2. Create database in production mode
3. Choose a location close to your users

**Cloud Messaging:**
1. Go to Cloud Messaging
2. Enable for your project

#### Get Configuration Files

**For Android:**
1. Go to Project Settings → General
2. Add Android app
3. Package name: `com.mentalhealth.support`
4. Download `google-services.json`
5. Place in `android/app/` directory

**For iOS:**
1. Add iOS app
2. Bundle ID: `com.mentalhealth.support`
3. Download `GoogleService-Info.plist`
4. Place in `ios/Runner/` directory

**For Web:**
1. Add Web app
2. Copy the configuration object
3. Update `lib/config/firebase_config.dart`

### 3. Update Firebase Configuration

Replace placeholder values in `lib/config/firebase_config.dart`:

```dart
static const String _defaultProjectId = 'your-actual-project-id';
// Update all API keys, app IDs, and other configuration values
```

### 4. OpenAI API Setup

1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Create an account and get API key
3. Update `lib/services/chatbot_service.dart`:

```dart
static const String _openAIApiKey = 'your-actual-openai-api-key';
```

### 5. Deploy Firestore Security Rules

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init firestore

# Deploy rules
firebase deploy --only firestore:rules
```

### 6. Platform-Specific Setup

#### Android Setup

**Notification Channels:**
Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
```

**Notification Icons:**
Add notification icons to `android/app/src/main/res/drawable/`

#### iOS Setup

**Notification Permissions:**
Add to `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

**Push Notifications:**
1. Enable Push Notifications in Xcode
2. Configure APNs certificates in Firebase Console

#### Web Setup

**Service Worker:**
The Firebase SDK will automatically handle service worker registration.

### 7. Run the Application

```bash
# For development
flutter run

# For web
flutter run -d chrome

# For Android
flutter run -d android

# For iOS
flutter run -d ios
```

### 8. Test the Features

#### Authentication
1. Create a new account
2. Sign in with email/password
3. Test Google Sign-In
4. Test anonymous login

#### Mood Tracking
1. Add mood entries
2. Verify data appears in Firestore
3. Check analytics screen

#### Journaling
1. Create journal entries
2. Test search and filtering
3. Verify offline functionality

#### Analytics
1. Add multiple mood entries
2. View weekly/monthly charts
3. Check insights generation

#### Notifications
1. Enable daily reminders
2. Set reminder time
3. Test notification delivery

#### Privacy Features
1. Export user data
2. Test data deletion
3. Verify account deletion

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/widget_test.dart
flutter test test/auth_test.dart
flutter test test/analytics_test.dart
```

### Seed Test Data (Debug Only)

```dart
// Add to your app for testing
import 'package:mental_health_support/utils/seed_data.dart';

// Call this in debug mode
await SeedData.seedAllData();
```

## 🚀 Deployment

### Web Deployment

```bash
# Build for web
flutter build web

# Deploy to Firebase Hosting
firebase init hosting
firebase deploy
```

### Android Deployment

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Deployment

```bash
# Build for iOS
flutter build ios --release

# Open in Xcode for App Store submission
open ios/Runner.xcworkspace
```

## 🔧 Configuration Options

### Environment Variables

Create `.env` file in project root:

```env
FIREBASE_PROJECT_ID=your-project-id
OPENAI_API_KEY=your-openai-key
ENVIRONMENT=development
```

### Feature Flags

In `lib/config/app_config.dart`:

```dart
class AppConfig {
  static const bool enableAnalytics = true;
  static const bool enableJournaling = true;
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = true;
}
```

## 🐛 Troubleshooting

### Common Issues

**Firebase Initialization Failed:**
- Check if `google-services.json` is in correct location
- Verify Firebase project configuration
- Ensure all required services are enabled

**OpenAI API Errors:**
- Verify API key is correct
- Check API usage limits
- Ensure proper error handling

**Notification Issues:**
- Check device notification permissions
- Verify FCM configuration
- Test on physical device

**Build Errors:**
- Run `flutter clean`
- Run `flutter pub get`
- Check Flutter and Dart versions

### Debug Mode

Enable debug logging:

```dart
// In main.dart
import 'package:flutter/foundation.dart';

void main() {
  if (kDebugMode) {
    print('Debug mode enabled');
  }
  runApp(MyApp());
}
```

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11+)
- ✅ **Web** (Modern browsers)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Windows** (Windows 10+)

## 🔒 Security Considerations

1. **API Keys**: Never commit API keys to version control
2. **Firestore Rules**: Always use proper security rules
3. **Data Encryption**: All data is encrypted in transit and at rest
4. **User Privacy**: Implement proper data deletion and export features

## 📞 Support

For technical support:
1. Check the troubleshooting section
2. Review Firebase and Flutter documentation
3. Create an issue in the repository
4. Contact the development team

---

**Note**: This setup guide assumes you have basic knowledge of Flutter, Firebase, and mobile development. For beginners, consider reviewing Flutter and Firebase documentation first.
