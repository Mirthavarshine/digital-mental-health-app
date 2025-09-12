# Error Monitoring and Analytics Setup Guide

## Overview
This guide explains how to set up comprehensive error monitoring and analytics for the Material 3 Demo App using Sentry and Firebase.

## Services Integrated

### 1. Sentry (Error Monitoring)
- **Purpose**: Real-time error tracking and performance monitoring
- **Features**: Crash reporting, performance monitoring, release tracking
- **Setup**: Requires Sentry account and DSN

### 2. Firebase Analytics
- **Purpose**: User behavior tracking and app analytics
- **Features**: Event tracking, user properties, conversion tracking
- **Setup**: Requires Firebase project

### 3. Firebase Crashlytics
- **Purpose**: Crash reporting and stability monitoring
- **Features**: Crash reports, non-fatal errors, user impact analysis
- **Setup**: Part of Firebase project

### 4. Firebase Performance
- **Purpose**: App performance monitoring
- **Features**: Network monitoring, screen rendering, custom traces
- **Setup**: Part of Firebase project

## Setup Instructions

### 1. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Analytics, Crashlytics, and Performance
4. Add your app (Android/iOS/Web)

#### Configure Firebase
1. Download configuration files:
   - `google-services.json` (Android)
   - `GoogleService-Info.plist` (iOS)
2. Place files in appropriate directories
3. Update `firebase_options.dart` with your project details

#### Android Setup
1. Add to `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
apply plugin: 'com.google.firebase.crashlytics'
```

2. Add to `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
    classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.9'
}
```

#### iOS Setup
1. Add to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

### 2. Sentry Setup

#### Create Sentry Project
1. Go to [Sentry.io](https://sentry.io/)
2. Create a new project
3. Select Flutter as the platform
4. Get your DSN

#### Configure Sentry
1. Update environment variables:
```bash
export SENTRY_DSN="https://your-dsn@sentry.io/project-id"
export ENVIRONMENT="production"
export APP_VERSION="1.0.0"
```

2. Or update `ErrorMonitoringService` directly:
```dart
static String _getSentryDsn() {
  return 'https://your-dsn@sentry.io/project-id';
}
```

### 3. Environment Configuration

#### Development Environment
```dart
// In ErrorMonitoringService
static String _getEnvironment() {
  return kDebugMode ? 'development' : 'production';
}
```

#### Production Environment
```dart
// In ErrorMonitoringService
static String _getEnvironment() {
  return 'production';
}
```

## Usage Examples

### Error Reporting
```dart
// Report a non-fatal error
await ErrorMonitoringService.reportNonFatalError(
  Exception('Something went wrong'),
  context: 'user_action',
  extra: {'action': 'button_click'},
);

// Report a fatal error
await ErrorMonitoringService.reportFatalError(
  Exception('Critical error'),
  context: 'app_startup',
);
```

### Analytics Tracking
```dart
// Track screen view
await AnalyticsService.trackScreenView(
  screenName: 'home_screen',
  parameters: {'user_type': 'premium'},
);

// Track custom event
await AnalyticsService.trackEvent(
  eventName: 'button_click',
  parameters: {
    'button_name': 'submit',
    'screen_name': 'form',
  },
);

// Track user engagement
await AnalyticsService.trackUserEngagement(
  engagementType: 'feature_usage',
  parameters: {'feature': 'voice_journaling'},
);
```

### Performance Monitoring
```dart
// Start a performance trace
final trace = await AnalyticsService.startTrace('api_call');
try {
  // Perform operation
  await apiCall();
} finally {
  await AnalyticsService.stopTrace(trace);
}
```

### User Context
```dart
// Set user context for error reporting
await ErrorMonitoringService.setUserContext(
  userId: 'user123',
  email: 'user@example.com',
  username: 'john_doe',
  extra: {'subscription': 'premium'},
);
```

## Configuration Options

### Sentry Configuration
```dart
await SentryFlutter.init(
  (options) {
    options.dsn = 'your-dsn';
    options.environment = 'production';
    options.release = '1.0.0';
    options.debug = false;
    options.tracesSampleRate = 0.1; // 10% of transactions
    options.profilesSampleRate = 0.1; // 10% of profiles
  },
);
```

### Firebase Analytics Configuration
```dart
await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
await FirebaseAnalytics.instance.setUserProperty(
  name: 'app_version',
  value: '1.0.0',
);
```

## Testing

### Test Error Reporting
```dart
// Test error reporting (development only)
await ErrorMonitoringService.testErrorReporting();
```

### Test Analytics
```dart
// Test analytics (development only)
await AnalyticsService.testAnalytics();
```

## Monitoring and Alerts

### Sentry Alerts
1. Set up alerts for:
   - New errors
   - Error rate spikes
   - Performance degradation
   - Release health

### Firebase Alerts
1. Set up alerts for:
   - Crash-free users
   - ANR (Application Not Responding)
   - Performance issues

## Best Practices

### Error Reporting
1. **Context**: Always provide context for errors
2. **User Impact**: Distinguish between fatal and non-fatal errors
3. **Breadcrumbs**: Add breadcrumbs for debugging
4. **User Context**: Set user context for better debugging

### Analytics
1. **Privacy**: Respect user privacy and data protection
2. **Consent**: Get user consent for analytics
3. **Relevance**: Only track relevant events
4. **Performance**: Don't impact app performance

### Performance
1. **Traces**: Use traces for important operations
2. **Metrics**: Track key performance metrics
3. **Thresholds**: Set performance thresholds
4. **Monitoring**: Monitor performance continuously

## Troubleshooting

### Common Issues

#### Firebase Not Initializing
- Check configuration files
- Verify project settings
- Check network connectivity

#### Sentry Not Reporting
- Verify DSN
- Check network connectivity
- Verify project settings

#### Analytics Not Tracking
- Check if analytics is enabled
- Verify event parameters
- Check Firebase console

### Debug Mode
```dart
// Enable debug mode for development
if (kDebugMode) {
  await ErrorMonitoringService.testErrorReporting();
  await AnalyticsService.testAnalytics();
}
```

## Security Considerations

### Data Privacy
1. **User Consent**: Get explicit consent for data collection
2. **Data Minimization**: Collect only necessary data
3. **Data Retention**: Set appropriate retention periods
4. **Data Encryption**: Ensure data is encrypted in transit

### API Keys
1. **Environment Variables**: Use environment variables for sensitive data
2. **Build Configs**: Use different configs for different environments
3. **Access Control**: Limit access to monitoring dashboards

## Cost Optimization

### Sentry
1. **Sample Rates**: Adjust sample rates based on traffic
2. **Retention**: Set appropriate retention periods
3. **Quotas**: Monitor usage and set quotas

### Firebase
1. **Analytics**: Use analytics efficiently
2. **Crashlytics**: Monitor crash rates
3. **Performance**: Use performance monitoring judiciously

## Conclusion

This setup provides comprehensive error monitoring and analytics for your Flutter app. Regular monitoring and analysis of the data will help improve app quality, user experience, and performance.

Remember to:
- Test the setup thoroughly
- Monitor costs and usage
- Respect user privacy
- Keep configurations up to date
- Review and act on insights regularly
