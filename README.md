# Material 3 Demo App

A comprehensive Flutter application demonstrating Material 3 design principles with advanced theming, animations, accessibility features, and modern UI/UX patterns.

## 🎨 Features

### Core Design System
- **Material 3 Design**: Complete implementation of Material 3 design system
- **Dynamic Theming**: Light and dark mode support with system preference detection
- **Custom Color Scheme**: Centralized color management with accessibility considerations
- **Typography**: Material 3 typography scale with responsive text sizing

### UI Components
- **Custom Buttons**: Multiple button types with micro-interactions
- **Enhanced Cards**: Interactive cards with hover and press states
- **Navigation**: Bottom navigation and navigation rail with adaptive behavior
- **App Bars**: Various app bar configurations with search and tabs

### Animations & Transitions
- **Smooth Transitions**: Page transitions with custom curves and durations
- **Micro-interactions**: Button press, hover, and loading animations
- **Staggered Animations**: List item animations with proper timing
- **Hero Animations**: Seamless element transitions between screens

### Accessibility
- **Screen Reader Support**: Proper semantic labels and hints
- **High Contrast Mode**: Enhanced contrast for better visibility
- **Reduced Motion**: Respects user's motion preferences
- **Touch Targets**: Minimum 44x44 logical pixel touch targets
- **Text Scaling**: Responsive text sizing based on system settings

### Sample Screens
- **Home Screen**: Dashboard with cards, statistics, and quick actions
- **Details Screen**: Expandable sections with smooth animations
- **Settings Screen**: Comprehensive settings with toggles and sliders

## 🏗️ Architecture

### Folder Structure
```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart      # Centralized color definitions
│   │   └── app_theme.dart       # Theme configuration
│   ├── widgets/
│   │   ├── app_button.dart      # Custom button components
│   │   ├── app_card.dart        # Enhanced card components
│   │   ├── app_app_bar.dart     # Custom app bar variants
│   │   └── app_bottom_nav.dart  # Navigation components
│   └── utils/
│       ├── animation_utils.dart # Animation helpers
│       └── accessibility_utils.dart # Accessibility utilities
├── screens/
│   ├── home_screen.dart         # Main dashboard
│   ├── details_screen.dart      # Details with expandable sections
│   └── settings_screen.dart     # Settings and preferences
├── database/
│   ├── models/
│   │   └── base_model.dart      # Base model for Supabase
│   └── supabase_client.dart     # Database client setup
└── main.dart                    # App entry point
```

### Design Principles
- **Material 3 Compliance**: Follows all Material 3 design guidelines
- **Accessibility First**: Built with accessibility as a core consideration
- **Performance Optimized**: Efficient animations and smooth interactions
- **Scalable Architecture**: Easy to extend and maintain

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Dependencies
- **Material 3**: `material_color_utilities`
- **Animations**: `flutter_animate`, `lottie`, `animations`
- **Charts**: `fl_chart`, `syncfusion_flutter_charts`
- **Voice**: `speech_to_text`, `flutter_tts`, `record`
- **AI/ML**: `google_ml_kit`, `tflite_flutter`
- **Storage**: `hive`, `shared_preferences`, `sqflite`
- **Network**: `dio`, `connectivity_plus`
- **PDF**: `pdf`, `printing`
- **UI**: `flutter_rating_bar`, `badges`

## 🎯 Usage Examples

### Custom Button
```dart
AppButton(
  text: 'Click Me',
  onPressed: () {},
  type: AppButtonType.filled,
  size: AppButtonSize.medium,
  icon: Icons.add,
  isLoading: false,
)
```

### Interactive Card
```dart
AppCard(
  onTap: () {},
  isInteractive: true,
  child: Text('Card Content'),
)
```

### Animated Transitions
```dart
// Fade transition
FadeTransition(
  opacity: AnimationUtils.createFadeInAnimation(controller),
  child: widget,
)

// Slide transition
SlideTransition(
  position: AnimationUtils.createSlideInFromBottomAnimation(controller),
  child: widget,
)
```

## 🔧 Customization

### Colors
Modify colors in `lib/core/theme/app_colors.dart`:
```dart
static const Color _lightPrimary = Color(0xFF476810);
static const Color _lightOnPrimary = Color(0xFFFFFFFF);
```

### Animations
Adjust animation durations in `lib/core/utils/animation_utils.dart`:
```dart
static const Duration shortDuration = Duration(milliseconds: 200);
static const Duration mediumDuration = Duration(milliseconds: 300);
```

### Accessibility
Configure accessibility settings in `lib/core/utils/accessibility_utils.dart`:
```dart
static const double minTouchTargetSize = 44.0;
```

## 📱 Platform Support

- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Modern browsers with Flutter web support
- **Desktop**: Windows, macOS, Linux

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the code examples

## 🔮 Future Enhancements

- [ ] Supabase integration
- [ ] Advanced animations with Rive
- [ ] Custom icon sets
- [ ] Internationalization
- [ ] Advanced accessibility features
- [ ] Performance monitoring
- [ ] Automated testing

---

Built with ❤️ using Flutter and Material 3