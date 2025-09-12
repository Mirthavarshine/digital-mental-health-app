# 🌸 Digital Mental Health & Psychological Support System

A comprehensive Flutter application designed to provide mental health support through mood tracking, AI-powered chatbot assistance, resource library, and counselor booking system.

## 🚀 Live Demo

**Currently Running Locally:** http://localhost:15000

## ✨ Features

### 🎯 Core Features
- **Mood Tracking**: Track daily moods with analytics dashboard
- **AI Chatbot**: Intelligent mental health support with OpenAI integration
- **Resource Library**: Curated articles, videos, and mental health resources
- **Counselor Booking**: Schedule appointments with mental health professionals
- **Analytics Dashboard**: Visual insights into mood patterns and trends

### 🎨 UI/UX Features
- **Material 3 Design**: Modern, accessible interface
- **Dark/Light Theme**: Customizable theme with system preference support
- **Smooth Animations**: Hero animations, page transitions, and micro-interactions
- **Responsive Design**: Works seamlessly on web and mobile devices
- **Accessibility**: Screen reader support, high contrast, and keyboard navigation

### 🔧 Technical Features
- **Firebase Integration**: Authentication, Firestore database, and real-time sync
- **Offline Support**: Local data storage with cloud synchronization
- **Multi-language Support**: English and Tamil localization
- **Advanced Settings**: Theme customization, font scaling, and data management

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **Backend**: Firebase (Auth, Firestore, Analytics)
- **AI Integration**: OpenAI GPT-3.5-turbo
- **Charts**: FL Chart for data visualization
- **State Management**: Provider pattern
- **Animations**: Flutter Animate, Lottie
- **Localization**: Flutter Intl

## 📱 Screenshots

### Home Screen
- Welcome interface with quick access to all features
- Mood tracking widget with current mood display
- Quick action cards for main features

### Mood Analytics
- Weekly trend line chart
- Monthly summary bar chart
- Mood distribution pie chart
- Key insights and statistics

### AI Chatbot
- Real-time chat interface
- Typing indicators and message animations
- Context-aware mental health support

### Resource Library
- Categorized mental health resources
- Article and video content
- Search and filter functionality

### Counselor Booking
- Available counselor profiles
- Appointment scheduling form
- Confirmation with Lottie animations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Firebase project setup
- OpenAI API key (optional, for chatbot)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/digital-mental-health-app.git
   cd digital-mental-health-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project
   - Enable Authentication and Firestore
   - Download `firebase_options.dart` and replace the existing file
   - Update Firebase configuration in `lib/firebase_options.dart`

4. **Configure OpenAI (Optional)**
   - Create a `.env` file in the root directory
   - Add your OpenAI API key:
     ```
     OPENAI_API_KEY=your_api_key_here
     ```

5. **Run the application**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   ```

## 🌐 Deployment

### Web Deployment (Firebase Hosting)

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**
   ```bash
   firebase login
   ```

3. **Build for production**
   ```bash
   flutter build web --release
   ```

4. **Deploy to Firebase Hosting**
   ```bash
   firebase deploy --only hosting
   ```

### Alternative Deployment Options

- **Netlify**: Drag and drop the `build/web` folder
- **Vercel**: Connect your GitHub repository
- **GitHub Pages**: Use GitHub Actions for automatic deployment

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   ├── mood_entry.dart
│   ├── mood_analytics.dart
│   ├── resource.dart
│   └── booking.dart
├── screens/                  # UI screens
│   ├── auth/
│   │   └── login_screen.dart
│   ├── mood_tracker_screen.dart
│   ├── mood_analytics_screen.dart
│   ├── chatbot_screen.dart
│   ├── resources_screen.dart
│   ├── counselor_booking_screen.dart
│   └── settings_screen.dart
├── services/                 # Business logic
│   ├── auth_service.dart
│   ├── mood_service.dart
│   ├── chatbot_service.dart
│   ├── resource_service.dart
│   └── booking_service.dart
└── widgets/                  # Reusable widgets
    └── mood_chart.dart
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file with the following variables:
```
OPENAI_API_KEY=your_openai_api_key
FIREBASE_PROJECT_ID=your_firebase_project_id
```

### Firebase Setup
1. Enable Authentication (Email/Password, Anonymous)
2. Create Firestore database
3. Set up security rules
4. Configure Firebase Analytics (optional)

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

## 📊 Analytics

The app includes comprehensive analytics tracking:
- User engagement metrics
- Feature usage statistics
- Mood tracking patterns
- Performance monitoring

## 🔒 Privacy & Security

- **Data Encryption**: All sensitive data is encrypted
- **Privacy-First**: Minimal data collection with user consent
- **Secure Authentication**: Firebase Auth with best practices
- **GDPR Compliant**: Data export and deletion features

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- OpenAI for AI capabilities
- Material Design for UI guidelines
- Open source community for various packages

## 📞 Support

For support, email support@mentalhealthapp.com or create an issue in this repository.

## 🗺️ Roadmap

- [ ] Voice journaling feature
- [ ] Group therapy sessions
- [ ] Medication tracking
- [ ] Crisis intervention tools
- [ ] Wearable device integration
- [ ] Advanced AI insights
- [ ] Multi-language expansion

---

**Made with ❤️ for mental health awareness and support**