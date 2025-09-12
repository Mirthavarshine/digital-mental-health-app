# Update and Feedback System Setup Guide

## Overview
This guide explains how to set up and use the force update mechanism and in-app user feedback system for the Material 3 Demo App.

## Features

### 1. Force Update System
- **Automatic Update Checking**: Checks for updates on app startup
- **Version Comparison**: Compares current version with latest available
- **Force Update**: Requires users to update for critical versions
- **Optional Update**: Allows users to update at their convenience
- **App Store Integration**: Direct links to app stores for updates

### 2. User Feedback System
- **In-App Feedback**: Built-in feedback dialog
- **Multiple Feedback Types**: Bug reports, feature requests, general feedback
- **Rating System**: 1-5 star rating system
- **Email Integration**: Direct email support
- **Support Resources**: FAQ, support website, contact information

## Setup Instructions

### 1. Server-Side Setup

#### Update Check Endpoint
Create an API endpoint to check for updates:

```json
GET /api/updates/check
Response:
{
  "latest_version": "1.0.1",
  "latest_build_number": "2",
  "force_update": false,
  "update_url": "https://play.google.com/store/apps/details?id=com.example.app",
  "release_notes": "Bug fixes and performance improvements",
  "min_supported_version": "1.0.0"
}
```

#### Feedback Endpoint
Create an API endpoint to receive feedback:

```json
POST /api/feedback
Request:
{
  "type": "general_feedback",
  "message": "Great app!",
  "rating": 5,
  "email": "user@example.com",
  "category": "General",
  "app_version": "1.0.0",
  "build_number": "1",
  "platform": "flutter",
  "environment": "production",
  "timestamp": "2024-01-01T00:00:00Z",
  "metadata": {}
}
```

### 2. App Store Configuration

#### Android (Google Play Store)
1. Upload your app to Google Play Console
2. Get the app store URL
3. Update the `update_url` in your server response

#### iOS (App Store)
1. Upload your app to App Store Connect
2. Get the app store URL
3. Update the `update_url` in your server response

### 3. Email Configuration

#### Support Email
Update the support email in `FeedbackService`:
```dart
// In FeedbackService
final uri = Uri(
  scheme: 'mailto',
  path: 'support@yourcompany.com', // Update this
  query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
);
```

#### Support Website
Update the support website URLs:
```dart
// In FeedbackService
const url = 'https://yourcompany.com/support'; // Update this
```

## Usage Examples

### 1. Check for Updates

#### Automatic Check on Startup
```dart
// In main.dart or app initialization
await UpdateService.instance.checkForUpdatesOnStartup(context);
```

#### Manual Check
```dart
// Check for updates manually
final updateInfo = await UpdateService.instance.checkForUpdates();

if (updateInfo.isUpdateAvailable) {
  await UpdateService.instance.showUpdateDialog(context, updateInfo);
}
```

#### Check if App is Up to Date
```dart
// Check if app is up to date
final isUpToDate = await UpdateService.instance.isAppUpToDate();
```

### 2. User Feedback

#### Show Feedback Dialog
```dart
// Show feedback dialog
await FeedbackService.instance.showFeedbackDialog(context);
```

#### Show Support Dialog
```dart
// Show support dialog
await FeedbackService.instance.showSupportDialog(context);
```

#### Submit Feedback Programmatically
```dart
// Submit feedback
final success = await FeedbackService.instance.submitFeedback(
  type: 'bug_report',
  message: 'App crashes on startup',
  rating: 1,
  email: 'user@example.com',
  category: 'Bug Report',
);
```

#### Report a Bug
```dart
// Report a bug
final success = await FeedbackService.instance.reportBug(
  description: 'App crashes when opening settings',
  steps: '1. Open app\n2. Tap settings\n3. App crashes',
  email: 'user@example.com',
);
```

#### Submit Feature Request
```dart
// Submit feature request
final success = await FeedbackService.instance.submitFeatureRequest(
  description: 'Add dark mode support',
  useCase: 'Better user experience in low light',
  email: 'user@example.com',
);
```

### 3. Support Features

#### Launch Support Website
```dart
// Launch support website
await FeedbackService.instance.launchSupportWebsite();
```

#### Launch FAQ Page
```dart
// Launch FAQ page
await FeedbackService.instance.launchFAQPage();
```

#### Send Support Email
```dart
// Send support email
await FeedbackService.instance.sendSupportEmail(
  subject: 'Need help with app',
  body: 'I need help with...',
);
```

## Integration with UI

### 1. Settings Screen Integration

Add feedback and support options to your settings screen:

```dart
// In settings screen
ListTile(
  leading: Icon(Icons.feedback),
  title: Text('Send Feedback'),
  onTap: () async {
    await FeedbackService.instance.showFeedbackDialog(context);
  },
),

ListTile(
  leading: Icon(Icons.support),
  title: Text('Support'),
  onTap: () async {
    await FeedbackService.instance.showSupportDialog(context);
  },
),

ListTile(
  leading: Icon(Icons.update),
  title: Text('Check for Updates'),
  onTap: () async {
    final updateInfo = await UpdateService.instance.checkForUpdates();
    if (updateInfo.isUpdateAvailable) {
      await UpdateService.instance.showUpdateDialog(context, updateInfo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('App is up to date')),
      );
    }
  },
),
```

### 2. App Bar Integration

Add feedback button to app bar:

```dart
// In app bar
AppBar(
  title: Text('Home'),
  actions: [
    IconButton(
      icon: Icon(Icons.feedback),
      onPressed: () async {
        await FeedbackService.instance.showFeedbackDialog(context);
      },
    ),
  ],
),
```

### 3. Error Handling Integration

Integrate with error handling:

```dart
// In error handling
try {
  // Some operation
} catch (e) {
  // Report error
  await ErrorMonitoringService.reportNonFatalError(e);
  
  // Show feedback option
  if (mounted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Something went wrong'),
        content: Text('Would you like to send feedback about this issue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await FeedbackService.instance.showFeedbackDialog(context);
            },
            child: Text('Send Feedback'),
          ),
        ],
      ),
    );
  }
}
```

## Configuration

### 1. Update Service Configuration

#### API Endpoint
```dart
// In UpdateService
final response = await http.get(
  Uri.parse('${AppConfig.instance.apiBaseUrl}/api/updates/check'),
  // ...
);
```

#### Timeout Configuration
```dart
// In UpdateService
.timeout(AppConfig.instance.apiTimeout)
```

### 2. Feedback Service Configuration

#### API Endpoint
```dart
// In FeedbackService
final response = await http.post(
  Uri.parse('${AppConfig.instance.apiBaseUrl}/api/feedback'),
  // ...
);
```

#### Support Contact Information
```dart
// In FeedbackService
Map<String, String> getSupportContactInfo() {
  return {
    'email': 'support@yourcompany.com',
    'phone': '+1-555-0123',
    'website': 'https://yourcompany.com/support',
    'faq': 'https://yourcompany.com/faq',
  };
}
```

## Testing

### 1. Update Testing

#### Test Update Check
```dart
// Test update check
final updateInfo = await UpdateService.instance.checkForUpdates();
print('Update info: $updateInfo');
```

#### Test Update Dialog
```dart
// Test update dialog
final mockUpdateInfo = UpdateInfo(
  status: UpdateStatus.available,
  currentVersion: '1.0.0',
  latestVersion: '1.0.1',
  isUpdateAvailable: true,
  isForceUpdate: false,
  updateUrl: 'https://play.google.com/store/apps/details?id=com.example.app',
  releaseNotes: 'Test update',
);

await UpdateService.instance.showUpdateDialog(context, mockUpdateInfo);
```

### 2. Feedback Testing

#### Test Feedback Submission
```dart
// Test feedback submission
final success = await FeedbackService.instance.submitFeedback(
  type: 'general_feedback',
  message: 'Test feedback',
  rating: 5,
  email: 'test@example.com',
);

print('Feedback submitted: $success');
```

#### Test Email Launch
```dart
// Test email launch
await FeedbackService.instance.sendFeedbackViaEmail(
  type: 'bug_report',
  message: 'Test bug report',
  rating: 1,
  email: 'test@example.com',
);
```

## Best Practices

### 1. Update Management
- **Regular Updates**: Check for updates regularly
- **Force Updates**: Use sparingly for critical security fixes
- **Release Notes**: Provide clear release notes
- **Testing**: Test updates thoroughly before release

### 2. Feedback Management
- **Response Time**: Respond to feedback promptly
- **Categorization**: Categorize feedback for better organization
- **Analytics**: Track feedback trends and patterns
- **Follow-up**: Follow up on resolved issues

### 3. User Experience
- **Non-intrusive**: Don't interrupt user workflow
- **Clear Messaging**: Use clear and helpful messages
- **Easy Access**: Make feedback easily accessible
- **Multiple Channels**: Provide multiple ways to get support

### 4. Privacy and Security
- **Data Protection**: Protect user data and privacy
- **Consent**: Get user consent for data collection
- **Encryption**: Encrypt sensitive data
- **Compliance**: Comply with privacy regulations

## Troubleshooting

### Common Issues

#### Update Check Fails
- Check network connectivity
- Verify API endpoint
- Check server response format
- Verify authentication if required

#### Feedback Submission Fails
- Check network connectivity
- Verify API endpoint
- Check server response format
- Verify required fields

#### Email Launch Fails
- Check if email client is installed
- Verify email format
- Check device permissions
- Test with different email clients

### Debug Mode
```dart
// Enable debug mode for development
if (AppConfig.instance.isDevelopment) {
  // Show debug information
  print('Update service initialized');
  print('Feedback service initialized');
}
```

## Conclusion

The update and feedback system provides:

- **Automatic Updates**: Seamless update experience
- **User Feedback**: Easy way for users to provide feedback
- **Support Integration**: Multiple support channels
- **Analytics**: Track user feedback and app usage
- **Error Reporting**: Integrated error reporting

Remember to:
- Test all features thoroughly
- Monitor feedback and updates
- Respond to user feedback promptly
- Keep the system updated
- Monitor performance and errors
