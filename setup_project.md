# 🚀 Complete Flutter Project Setup Guide

## **Step-by-Step Setup for SIH 2025 Demo App**

This guide will help you set up the complete Digital Mental Health & Psychological Support System Flutter app.

---

## 📋 **Prerequisites**

### **Required Software**
- Flutter 3.13+ ([Download](https://flutter.dev/docs/get-started/install))
- Dart 3.0+
- Android Studio / VS Code
- Git
- Firebase CLI (optional)

### **Required Accounts**
- Firebase project ([Create](https://console.firebase.google.com/))
- Google account for Firebase

---

## 🔧 **Setup Steps**

### **1. Project Initialization**

```bash
# Create new Flutter project
flutter create digital_mental_health_app
cd digital_mental_health_app

# Initialize Git
git init
git add .
git commit -m "Initial Flutter project setup"
```

### **2. Dependencies Installation**

Replace the `pubspec.yaml` file with the provided content:

```yaml
name: digital_mental_health_app
description: A comprehensive mental health support application with mood tracking, journaling, and AI-powered insights.

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.5
  
  # Firebase
  firebase_core: ^3.30.0
  firebase_auth: ^6.5.0
  cloud_firestore: ^5.10.0
  firebase_messaging: ^14.7.10
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.2.0
  
  # Localization
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0
  
  # UI & Animations
  flutter_animate: ^4.0.0
  lottie: ^2.3.2
  animations: ^2.0.11
  
  # Charts & Analytics
  syncfusion_flutter_charts: ^24.1.41
  
  # State Management
  provider: ^6.1.2
  
  # Utilities
  shared_preferences: ^2.2.2
  google_fonts: ^6.0.0
  
  # HTTP & AI
  http: ^1.1.0
  
  # Notifications
  flutter_local_notifications: ^16.3.0
  timezone: ^0.9.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/translations/
    - assets/animations/
    - assets/images/
  
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
    - family: NotoSansTamil
      fonts:
        - asset: assets/fonts/NotoSansTamil-Regular.ttf
        - asset: assets/fonts/NotoSansTamil-Bold.ttf
          weight: 700
```

### **3. Install Dependencies**

```bash
flutter pub get
```

### **4. Create Directory Structure**

```bash
# Create necessary directories
mkdir -p lib/models
mkdir -p lib/services
mkdir -p lib/screens/journal
mkdir -p lib/screens/analytics
mkdir -p lib/widgets
mkdir -p lib/utils
mkdir -p assets/translations
mkdir -p assets/animations
mkdir -p assets/images
mkdir -p assets/fonts
mkdir -p test
```

### **5. Firebase Setup**

#### **5.1 Create Firebase Project**
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: "Digital Mental Health App"
4. Enable Google Analytics (optional)
5. Create project

#### **5.2 Enable Firebase Services**
1. **Authentication**: Enable Anonymous authentication
2. **Firestore Database**: Create database in test mode
3. **Cloud Messaging**: Enable for notifications

#### **5.3 Add Firebase to Flutter**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

#### **5.4 Update Firebase Options**
Replace the content in `lib/firebase_options.dart` with your Firebase configuration.

### **6. Asset Files Setup**

#### **6.1 Download Fonts**
Download and place these fonts in `assets/fonts/`:
- [Poppins Regular](https://fonts.google.com/specimen/Poppins)
- [Poppins Bold](https://fonts.google.com/specimen/Poppins)
- [Noto Sans Tamil Regular](https://fonts.google.com/noto/specimen/Noto+Sans+Tamil)
- [Noto Sans Tamil Bold](https://fonts.google.com/noto/specimen/Noto+Sans+Tamil)

#### **6.2 Create Translation Files**

**assets/translations/en.json:**
```json
{
  "app": {
    "title": "Digital Mental Health Support",
    "welcome": "Welcome to your mental health companion",
    "tagline": "Track your mood, journal your thoughts, and discover insights about your mental well-being."
  },
  "welcome": {
    "title": "Welcome",
    "subtitle": "Your Mental Health Companion",
    "description": "Track your mood, journal your thoughts, and discover insights about your mental well-being.",
    "continue": "Continue",
    "skip": "Skip"
  },
  "mood": {
    "title": "Mood Tracker",
    "how_feeling": "How are you feeling today?",
    "select_mood": "Select your current mood",
    "happy": "Happy",
    "neutral": "Neutral",
    "sad": "Sad",
    "angry": "Angry",
    "tired": "Tired",
    "add_note": "Add a note (optional)",
    "note_hint": "What's contributing to this mood?",
    "save": "Save Mood",
    "update_entry": "Update Entry",
    "saved": "Mood saved successfully!",
    "error": "Failed to save mood",
    "delete_entry": "Delete Entry",
    "delete_confirmation": "Are you sure you want to delete this mood entry?",
    "entry_deleted": "Mood entry deleted successfully!",
    "delete_error": "Failed to delete mood entry"
  },
  "journal": {
    "title": "Journal",
    "new_entry": "New Entry",
    "edit_entry": "Edit Entry",
    "search_hint": "Search entries...",
    "add_tag": "Add tag",
    "content_hint": "What's on your mind today?",
    "entry_created": "Journal entry created successfully!",
    "entry_updated": "Journal entry updated successfully!",
    "entry_deleted": "Journal entry deleted successfully!",
    "error": "Failed to save journal entry",
    "delete_entry": "Delete Entry",
    "delete_confirmation": "Are you sure you want to delete this journal entry?",
    "delete_error": "Failed to delete journal entry",
    "unsaved_changes": "Unsaved Changes",
    "unsaved_message": "You have unsaved changes. Do you want to save them?",
    "discard": "Discard",
    "save": "Save",
    "create_entry": "Create Entry",
    "update_entry": "Update Entry",
    "no_entries": "No Journal Entries",
    "no_entries_description": "Start your mental health journey by writing your first journal entry.",
    "no_matches": "No Matching Entries",
    "no_matches_description": "Try adjusting your search or filter criteria.",
    "filter_tags": "Filter Entries"
  },
  "analytics": {
    "title": "Analytics",
    "weekly": "Weekly",
    "monthly": "Monthly",
    "weekly_average": "Weekly Average",
    "monthly_average": "Monthly Average",
    "current_streak": "Current Streak",
    "longest_streak": "Longest Streak",
    "days": "days",
    "weekly_trend": "Weekly Trend",
    "monthly_trend": "Monthly Trend",
    "mood_distribution": "Mood Distribution",
    "insights": "AI Insights",
    "no_data": "No Data Available",
    "no_data_description": "Start tracking your mood and journaling to see your analytics.",
    "error": "Failed to load analytics"
  },
  "common": {
    "cancel": "Cancel",
    "delete": "Delete",
    "save": "Save",
    "edit": "Edit",
    "add": "Add",
    "search": "Search",
    "filter": "Filter",
    "clear": "Clear",
    "done": "Done",
    "continue": "Continue",
    "back": "Back",
    "next": "Next",
    "previous": "Previous",
    "loading": "Loading...",
    "error": "Error",
    "success": "Success",
    "warning": "Warning",
    "info": "Info"
  }
}
```

**assets/translations/ta.json:**
```json
{
  "app": {
    "title": "டிஜிட்டல் மனநல ஆதரவு",
    "welcome": "உங்கள் மனநல துணையை வரவேற்கிறோம்",
    "tagline": "உங்கள் மனநிலையை கண்காணியுங்கள், உங்கள் எண்ணங்களை பதிவு செய்யுங்கள், மற்றும் உங்கள் மனநலம் பற்றிய நுண்ணறிவுகளை கண்டறியுங்கள்."
  },
  "welcome": {
    "title": "வரவேற்கிறோம்",
    "subtitle": "உங்கள் மனநல துணை",
    "description": "உங்கள் மனநிலையை கண்காணியுங்கள், உங்கள் எண்ணங்களை பதிவு செய்யுங்கள், மற்றும் உங்கள் மனநலம் பற்றிய நுண்ணறிவுகளை கண்டறியுங்கள்.",
    "continue": "தொடரவும்",
    "skip": "தவிர்க்கவும்"
  },
  "mood": {
    "title": "மனநிலை கண்காணிப்பு",
    "how_feeling": "இன்று எப்படி உணர்கிறீர்கள்?",
    "select_mood": "உங்கள் தற்போதைய மனநிலையைத் தேர்ந்தெடுக்கவும்",
    "happy": "மகிழ்ச்சி",
    "neutral": "நடுநிலை",
    "sad": "வருத்தம்",
    "angry": "கோபம்",
    "tired": "சோர்வு",
    "add_note": "ஒரு குறிப்பைச் சேர்க்கவும் (விருப்பமானது)",
    "note_hint": "இந்த மனநிலைக்கு என்ன பங்களிக்கிறது?",
    "save": "மனநிலையை சேமிக்கவும்",
    "update_entry": "உள்ளீட்டை புதுப்பிக்கவும்",
    "saved": "மனநிலை வெற்றிகரமாக சேமிக்கப்பட்டது!",
    "error": "மனநிலையை சேமிக்க முடியவில்லை",
    "delete_entry": "உள்ளீட்டை நீக்கவும்",
    "delete_confirmation": "இந்த மனநிலை உள்ளீட்டை நீக்க விரும்புகிறீர்களா?",
    "entry_deleted": "மனநிலை உள்ளீடு வெற்றிகரமாக நீக்கப்பட்டது!",
    "delete_error": "மனநிலை உள்ளீட்டை நீக்க முடியவில்லை"
  },
  "journal": {
    "title": "பத்திரிகை",
    "new_entry": "புதிய உள்ளீடு",
    "edit_entry": "உள்ளீட்டைத் திருத்து",
    "search_hint": "உள்ளீடுகளைத் தேடு...",
    "add_tag": "குறிச்சொல் சேர்",
    "content_hint": "இன்று உங்கள் மனதில் என்ன?",
    "entry_created": "பத்திரிகை உள்ளீடு வெற்றிகரமாக உருவாக்கப்பட்டது!",
    "entry_updated": "பத்திரிகை உள்ளீடு வெற்றிகரமாக புதுப்பிக்கப்பட்டது!",
    "entry_deleted": "பத்திரிகை உள்ளீடு வெற்றிகரமாக நீக்கப்பட்டது!",
    "error": "பத்திரிகை உள்ளீட்டை சேமிக்க முடியவில்லை",
    "delete_entry": "உள்ளீட்டை நீக்கவும்",
    "delete_confirmation": "இந்த பத்திரிகை உள்ளீட்டை நீக்க விரும்புகிறீர்களா?",
    "delete_error": "பத்திரிகை உள்ளீட்டை நீக்க முடியவில்லை",
    "unsaved_changes": "சேமிக்கப்படாத மாற்றங்கள்",
    "unsaved_message": "உங்களுக்கு சேமிக்கப்படாத மாற்றங்கள் உள்ளன. அவற்றை சேமிக்க விரும்புகிறீர்களா?",
    "discard": "நிராகரிக்கவும்",
    "save": "சேமிக்கவும்",
    "create_entry": "உள்ளீட்டை உருவாக்கவும்",
    "update_entry": "உள்ளீட்டை புதுப்பிக்கவும்",
    "no_entries": "பத்திரிகை உள்ளீடுகள் இல்லை",
    "no_entries_description": "உங்கள் முதல் பத்திரிகை உள்ளீட்டை எழுதுவதன் மூலம் உங்கள் மனநல பயணத்தைத் தொடங்குங்கள்.",
    "no_matches": "பொருந்தும் உள்ளீடுகள் இல்லை",
    "no_matches_description": "உங்கள் தேடல் அல்லது வடிகட்டி அளவுகோல்களை சரிசெய்ய முயற்சிக்கவும்.",
    "filter_tags": "உள்ளீடுகளை வடிகட்டு"
  },
  "analytics": {
    "title": "பகுப்பாய்வு",
    "weekly": "வாராந்திர",
    "monthly": "மாதாந்திர",
    "weekly_average": "வாராந்திர சராசரி",
    "monthly_average": "மாதாந்திர சராசரி",
    "current_streak": "தற்போதைய தொடர்",
    "longest_streak": "நீண்ட தொடர்",
    "days": "நாட்கள்",
    "weekly_trend": "வாராந்திர போக்கு",
    "monthly_trend": "மாதாந்திர போக்கு",
    "mood_distribution": "மனநிலை பரவல்",
    "insights": "AI நுண்ணறிவுகள்",
    "no_data": "தரவு இல்லை",
    "no_data_description": "உங்கள் பகுப்பாய்வைப் பார்க்க மனநிலையை கண்காணிக்கவும் மற்றும் பத்திரிகை எழுதவும் தொடங்குங்கள்.",
    "error": "பகுப்பாய்வை ஏற்ற முடியவில்லை"
  },
  "common": {
    "cancel": "ரத்து செய்",
    "delete": "நீக்கு",
    "save": "சேமி",
    "edit": "திருத்து",
    "add": "சேர்",
    "search": "தேடு",
    "filter": "வடிகட்டு",
    "clear": "அழி",
    "done": "முடிந்தது",
    "continue": "தொடரவும்",
    "back": "பின்",
    "next": "அடுத்து",
    "previous": "முந்தைய",
    "loading": "ஏற்றுகிறது...",
    "error": "பிழை",
    "success": "வெற்றி",
    "warning": "எச்சரிக்கை",
    "info": "தகவல்"
  }
}
```

### **7. Copy All Source Files**

Copy all the provided source files to their respective directories:

- `lib/models/` - All model files
- `lib/services/` - All service files  
- `lib/screens/` - All screen files
- `lib/widgets/` - All widget files
- `lib/utils/` - All utility files
- `test/` - All test files

### **8. Platform Configuration**

#### **8.1 Android Configuration**

**android/app/build.gradle:**
```gradle
android {
    compileSdkVersion 34
    defaultConfig {
        applicationId "com.example.digital_mental_health_app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

**android/app/src/main/AndroidManifest.xml:**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    
    <application
        android:label="Digital Mental Health"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme" />
              
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

#### **8.2 iOS Configuration**

**ios/Runner/Info.plist:**
```xml
<key>CFBundleDisplayName</key>
<string>Digital Mental Health</string>
<key>CFBundleIdentifier</key>
<string>com.example.digitalMentalHealthApp</string>
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

### **9. Build and Run**

```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Run on connected device
flutter run

# Build for release
flutter build apk --release
flutter build ios --release
```

### **10. Testing**

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/mood_tracking_test.dart
flutter test test/journaling_test.dart
flutter test test/ui_polish_test.dart

# Run with coverage
flutter test --coverage
```

---

## 🎯 **Demo Preparation**

### **Demo Checklist**
- [ ] Firebase project configured
- [ ] All dependencies installed
- [ ] App runs without errors
- [ ] All screens accessible
- [ ] Theme switching works
- [ ] Language switching works
- [ ] Mood tracking functional
- [ ] Journaling functional
- [ ] Analytics display correctly
- [ ] Notifications work
- [ ] Offline mode works
- [ ] Accessibility features work

### **Demo Flow**
1. **Welcome Screen**: Show onboarding
2. **Home Navigation**: Demonstrate bottom nav
3. **Theme/Language**: Toggle themes and languages
4. **Mood Tracking**: Add mood entries
5. **Analytics**: Show charts and insights
6. **Journaling**: Create journal entries
7. **AI Insights**: Show generated insights
8. **Notifications**: Configure reminders
9. **Accessibility**: Demonstrate screen reader, scaling
10. **Offline Mode**: Show offline functionality

---

## 🚀 **Ready for SIH 2025 Demo!**

Your complete Flutter mental health app is now ready for the SIH 2025 demo with:

- ✅ **Complete Feature Set**: Mood tracking, journaling, AI insights
- ✅ **Professional UI/UX**: Material 3 design with animations
- ✅ **Bilingual Support**: English and Tamil translations
- ✅ **Accessibility**: Full accessibility compliance
- ✅ **Offline Support**: Local caching with auto-sync
- ✅ **Testing**: Comprehensive test coverage
- ✅ **Documentation**: Complete setup and usage guides

**Good luck with your SIH 2025 presentation!** 🎉
