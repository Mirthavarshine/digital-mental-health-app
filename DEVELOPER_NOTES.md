# Developer Notes

## 🚀 Quick Start Guide

### 1. Project Setup
```bash
# Clone and setup
git clone <repository-url>
cd material3_demo_app
flutter pub get

# Run the app
flutter run
```

### 2. Key Files to Know

#### Theme System
- `lib/core/theme/app_colors.dart` - All color definitions
- `lib/core/theme/app_theme.dart` - Complete theme configuration

#### Core Components
- `lib/core/widgets/app_button.dart` - Custom buttons with micro-interactions
- `lib/core/widgets/app_card.dart` - Enhanced cards with animations
- `lib/core/widgets/app_app_bar.dart` - Various app bar configurations
- `lib/core/widgets/app_bottom_nav.dart` - Navigation components

#### Utilities
- `lib/core/utils/animation_utils.dart` - Animation helpers and transitions
- `lib/core/utils/accessibility_utils.dart` - Accessibility utilities

#### Sample Screens
- `lib/screens/home_screen.dart` - Dashboard with cards and statistics
- `lib/screens/details_screen.dart` - Expandable sections with animations
- `lib/screens/settings_screen.dart` - Settings with toggles and sliders

## 🎨 Design System

### Color Usage
```dart
// Get current color scheme
final colorScheme = AppTheme.getColorScheme(context);

// Use semantic colors
colorScheme.primary          // Primary brand color
colorScheme.onPrimary        // Text on primary
colorScheme.surface          // Surface color
colorScheme.onSurface        // Text on surface
colorScheme.error            // Error color
```

### Typography
```dart
// Use theme text styles
Theme.of(context).textTheme.headlineLarge
Theme.of(context).textTheme.titleMedium
Theme.of(context).textTheme.bodyLarge
```

### Spacing
- Use 8px grid system
- Common spacing: 8, 16, 24, 32px
- Card margins: 8px
- Section spacing: 24px

## 🎭 Animations

### Standard Durations
- Short: 200ms (micro-interactions)
- Medium: 300ms (page transitions)
- Long: 500ms (complex animations)

### Standard Curves
- `Curves.easeInOut` - Default for most animations
- `Curves.fastOutSlowIn` - Material motion
- `Curves.bounceOut` - Playful interactions

### Animation Examples
```dart
// Fade in
AnimationUtils.createFadeInAnimation(controller)

// Slide from bottom
AnimationUtils.createSlideInFromBottomAnimation(controller)

// Scale animation
AnimationUtils.createScaleAnimation(controller, begin: 0.0, end: 1.0)
```

## ♿ Accessibility

### Best Practices
- Minimum touch target: 44x44 logical pixels
- Provide semantic labels for screen readers
- Support high contrast mode
- Respect reduced motion preferences
- Use proper text scaling

### Implementation
```dart
// Check accessibility settings
AccessibilityUtils.prefersReducedMotion(context)
AccessibilityUtils.isHighContrast(context)

// Get appropriate animation duration
AccessibilityUtils.getAnimationDuration(context)

// Ensure minimum touch target
AccessibilityUtils.ensureMinTouchTarget(child)
```

## 🏗️ Architecture Patterns

### Component Structure
```dart
class CustomWidget extends StatefulWidget {
  // Widget properties
  final String title;
  final VoidCallback? onPressed;
  
  const CustomWidget({
    super.key,
    required this.title,
    this.onPressed,
  });
  
  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = AnimationUtils.createFadeInAnimation(_controller);
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: child,
        );
      },
      child: // Widget content
    );
  }
}
```

### State Management
- Use `StatefulWidget` for local state
- Use `Provider` for global state
- Use `AnimationController` for animations
- Dispose controllers properly

## 📱 Platform Considerations

### Android
- Material 3 design system
- Adaptive icons
- Edge-to-edge display
- Gesture navigation

### iOS
- Cupertino-style transitions
- Safe area handling
- Haptic feedback
- iOS-specific animations

### Web
- Responsive design
- Keyboard navigation
- Touch and mouse support
- Performance optimization

## 🔧 Customization Guide

### Adding New Colors
1. Add color to `app_colors.dart`
2. Update light and dark color schemes
3. Test contrast ratios
4. Update documentation

### Creating New Components
1. Follow naming convention: `App[ComponentName]`
2. Include accessibility features
3. Add micro-interactions
4. Support theming
5. Add documentation

### Adding Animations
1. Use `AnimationUtils` for common animations
2. Respect reduced motion preferences
3. Use appropriate durations and curves
4. Test performance on low-end devices

## 🧪 Testing Strategy

### Unit Tests
- Test business logic
- Test utility functions
- Test data models

### Widget Tests
- Test component behavior
- Test user interactions
- Test accessibility

### Integration Tests
- Test complete user flows
- Test cross-platform behavior
- Test performance

## 📦 Dependencies

### Core Dependencies
- `flutter` - Flutter SDK
- `material_color_utilities` - Material 3 colors
- `provider` - State management

### Animation Dependencies
- `flutter_animate` - Declarative animations
- `lottie` - Vector animations
- `animations` - Material animations

### UI Dependencies
- `fl_chart` - Charts and graphs
- `flutter_rating_bar` - Rating components
- `badges` - Badge components

### Utility Dependencies
- `intl` - Internationalization
- `uuid` - Unique identifiers
- `equatable` - Value equality

## 🚀 Performance Tips

### Animation Performance
- Use `AnimatedBuilder` for complex animations
- Dispose controllers properly
- Use `RepaintBoundary` for expensive widgets
- Test on low-end devices

### Memory Management
- Dispose controllers and streams
- Use `const` constructors where possible
- Avoid creating objects in build methods
- Use `ListView.builder` for large lists

### Build Performance
- Use `const` widgets
- Minimize rebuilds
- Use `RepaintBoundary`
- Profile with Flutter Inspector

## 🔍 Debugging

### Common Issues
- Animation not working: Check controller disposal
- Theme not applied: Check MaterialApp configuration
- Accessibility issues: Check semantic labels
- Performance issues: Profile with Flutter Inspector

### Debug Tools
- Flutter Inspector
- Performance overlay
- Debug paint
- Semantics debugger

## 📚 Resources

### Documentation
- [Material 3 Design](https://m3.material.io/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Accessibility Guidelines](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)

### Tools
- [Material Theme Builder](https://m3.material.io/theme-builder)
- [Flutter Inspector](https://docs.flutter.dev/development/tools/devtools/inspector)
- [Performance Profiling](https://docs.flutter.dev/development/tools/devtools/performance)

---

Happy coding! 🎉
