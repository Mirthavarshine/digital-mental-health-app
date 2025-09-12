# App Flavors Setup Guide

## Overview
This guide explains how to set up and use app flavors for different environments (development, staging, production) in the Material 3 Demo App.

## What are App Flavors?

App flavors allow you to build different versions of your app with different configurations, resources, and settings. This is essential for:

- **Development**: Testing with debug features and development APIs
- **Staging**: Testing with production-like settings but staging APIs
- **Production**: Final release with production APIs and optimizations

## Environment Configuration

### 1. Development Environment
- **Purpose**: Local development and testing
- **Features**: All features enabled, debug mode on
- **APIs**: Development endpoints
- **Analytics**: Disabled
- **Crash Reporting**: Disabled
- **Performance Monitoring**: Disabled

### 2. Staging Environment
- **Purpose**: Testing and QA
- **Features**: All features enabled, debug mode off
- **APIs**: Staging endpoints
- **Analytics**: Enabled for testing
- **Crash Reporting**: Enabled for testing
- **Performance Monitoring**: Enabled for testing

### 3. Production Environment
- **Purpose**: Live app for end users
- **Features**: All features enabled, debug mode off
- **APIs**: Production endpoints
- **Analytics**: Enabled
- **Crash Reporting**: Enabled
- **Performance Monitoring**: Enabled

## Setup Instructions

### 1. Android Setup

#### Create Flavor Directories
Create the following directory structure:
```
android/app/src/
├── dev/
│   ├── res/
│   │   └── values/
│   │       └── strings.xml
│   └── AndroidManifest.xml
├── staging/
│   ├── res/
│   │   └── values/
│   │       └── strings.xml
│   └── AndroidManifest.xml
└── prod/
    ├── res/
    │   └── values/
    │       └── strings.xml
    └── AndroidManifest.xml
```

#### Update build.gradle
Add to `android/app/build.gradle`:
```gradle
android {
    flavorDimensions "environment"
    
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
            resValue "string", "app_name", "Material 3 Demo (Dev)"
        }
        
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
            resValue "string", "app_name", "Material 3 Demo (Staging)"
        }
        
        prod {
            dimension "environment"
            resValue "string", "app_name", "Material 3 Demo"
        }
    }
}
```

#### Create Flavor-Specific Resources

**dev/res/values/strings.xml**:
```xml
<resources>
    <string name="app_name">Material 3 Demo (Dev)</string>
    <string name="api_base_url">https://api-dev.example.com</string>
    <string name="environment">development</string>
</resources>
```

**staging/res/values/strings.xml**:
```xml
<resources>
    <string name="app_name">Material 3 Demo (Staging)</string>
    <string name="api_base_url">https://api-staging.example.com</string>
    <string name="environment">staging</string>
</resources>
```

**prod/res/values/strings.xml**:
```xml
<resources>
    <string name="app_name">Material 3 Demo</string>
    <string name="api_base_url">https://api.example.com</string>
    <string name="environment">production</string>
</resources>
```

### 2. iOS Setup

#### Create Flavor Schemes
1. Open `ios/Runner.xcworkspace` in Xcode
2. Duplicate the Runner scheme for each flavor
3. Rename schemes: Runner-Dev, Runner-Staging, Runner-Prod

#### Update Info.plist
Create flavor-specific Info.plist files:
```
ios/
├── Runner/
│   ├── Info-Dev.plist
│   ├── Info-Staging.plist
│   └── Info-Prod.plist
```

#### Update project.pbxproj
Add build configurations for each flavor:
```xcconfig
// Debug-Dev.xcconfig
#include "Generated.xcconfig"
FLUTTER_TARGET=lib/main.dart
DART_OBFUSCATION=false
TRACK_WIDGET_CREATION=true
TREE_SHAKE_ICONS=false
PACKAGE_CONFIG=.dart_tool/package_config.json
ENVIRONMENT=development
```

### 3. Flutter Configuration

#### Update main.dart
```dart
import 'package:flutter/material.dart';
import 'core/config/app_config.dart';
import 'core/config/build_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize configuration
  AppConfig.initialize();
  BuildConfig.initialize();
  
  runApp(const MyApp());
}
```

#### Update pubspec.yaml
Add flavor-specific assets:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/dev/
    - assets/images/staging/
    - assets/images/prod/
```

## Build Commands

### Development Build
```bash
# Android
flutter build apk --flavor dev --dart-define=ENVIRONMENT=development

# iOS
flutter build ios --flavor dev --dart-define=ENVIRONMENT=development

# Web
flutter build web --dart-define=ENVIRONMENT=development
```

### Staging Build
```bash
# Android
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging

# iOS
flutter build ios --flavor staging --dart-define=ENVIRONMENT=staging

# Web
flutter build web --dart-define=ENVIRONMENT=staging
```

### Production Build
```bash
# Android
flutter build apk --flavor prod --dart-define=ENVIRONMENT=production

# iOS
flutter build ios --flavor prod --dart-define=ENVIRONMENT=production

# Web
flutter build web --dart-define=ENVIRONMENT=production
```

### Using Build Scripts
```bash
# Development
./scripts/build_dev.sh

# Staging
./scripts/build_staging.sh

# Production
./scripts/build_prod.sh
```

## Configuration Usage

### In Code
```dart
// Get current environment
final environment = AppConfig.instance.environment;

// Check if feature is enabled
if (AppConfig.instance.isFeatureEnabled('voice_journaling')) {
  // Show voice journaling feature
}

// Get API URL
final apiUrl = AppConfig.instance.apiBaseUrl;

// Check if analytics is enabled
if (AppConfig.instance.analyticsCollectionEnabled) {
  // Initialize analytics
}
```

### Environment-Specific Behavior
```dart
class ApiService {
  String get baseUrl => AppConfig.instance.apiBaseUrl;
  
  Duration get timeout => AppConfig.instance.apiTimeout;
  
  int get retryAttempts => AppConfig.instance.retryAttempts;
  
  bool get enableLogging => AppConfig.instance.isDevelopment;
}
```

## Testing

### Unit Tests
```dart
void main() {
  group('AppConfig Tests', () {
    test('should return correct environment', () {
      AppConfig.initialize(environment: AppEnvironment.development);
      expect(AppConfig.instance.environment, AppEnvironment.development);
    });
    
    test('should return correct API URL', () {
      AppConfig.initialize(environment: AppEnvironment.production);
      expect(AppConfig.instance.apiBaseUrl, 'https://api.example.com');
    });
  });
}
```

### Integration Tests
```dart
void main() {
  group('Flavor Tests', () {
    testWidgets('should show correct app name', (WidgetTester tester) async {
      AppConfig.initialize(environment: AppEnvironment.development);
      
      await tester.pumpWidget(const MyApp());
      
      expect(find.text('Material 3 Demo (Dev)'), findsOneWidget);
    });
  });
}
```

## CI/CD Integration

### GitHub Actions
```yaml
name: Build and Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
    
    - name: Build Development
      run: ./scripts/build_dev.sh
    
    - name: Build Staging
      run: ./scripts/build_staging.sh
    
    - name: Build Production
      run: ./scripts/build_prod.sh
```

### Bitrise
```yaml
workflows:
  build-dev:
    steps:
    - flutter-install@1
    - flutter-test@1
    - flutter-build@1:
        inputs:
        - project_location: "."
        - build_configuration: "dev"
        - build_arguments: "--dart-define=ENVIRONMENT=development"
```

## Best Practices

### 1. Environment Variables
- Use environment variables for sensitive data
- Never commit API keys or secrets
- Use different keys for different environments

### 2. Feature Flags
- Use feature flags to enable/disable features
- Test features in staging before production
- Have rollback capability

### 3. Configuration Management
- Centralize configuration in one place
- Use type-safe configuration
- Validate configuration at startup

### 4. Testing
- Test all environments
- Use different test data for different environments
- Automate testing in CI/CD

### 5. Deployment
- Use different deployment pipelines
- Test staging thoroughly before production
- Have rollback procedures

## Troubleshooting

### Common Issues

#### Build Failures
- Check flavor configuration
- Verify environment variables
- Check resource files

#### Runtime Errors
- Verify configuration initialization
- Check environment-specific settings
- Validate API endpoints

#### Testing Issues
- Ensure proper test configuration
- Check mock data for different environments
- Verify test isolation

### Debug Mode
```dart
// Enable debug mode for development
if (AppConfig.instance.isDevelopment) {
  // Show debug information
  print('Environment: ${AppConfig.instance.environment}');
  print('API URL: ${AppConfig.instance.apiBaseUrl}');
  print('Features: ${AppConfig.instance.enabledFeatures}');
}
```

## Conclusion

App flavors provide a robust way to manage different environments and configurations. This setup ensures:

- **Separation of Concerns**: Different environments have different configurations
- **Testing**: Easy testing in different environments
- **Deployment**: Smooth deployment to different environments
- **Maintenance**: Easy maintenance and updates

Remember to:
- Test all environments thoroughly
- Keep configurations up to date
- Use proper versioning
- Monitor deployments
- Have rollback procedures
