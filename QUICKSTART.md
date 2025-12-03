# Quick Start Guide - Castiq

This guide will help you get the Castiq app up and running quickly.

## Prerequisites Check

Before starting, ensure you have:
- ✅ Flutter SDK 3.0.0 or higher
- ✅ Dart SDK
- ✅ Android Studio (for Android) or Xcode (for iOS)
- ✅ Git

## Quick Setup (5 minutes)

### 1. Clone and Install
```bash
# Clone the repository
git clone https://github.com/Laibrez/castiq_2.git
cd castiq_2

# Install dependencies
flutter pub get
```

### 2. Verify Installation
```bash
# Check Flutter setup
flutter doctor

# Ensure no critical issues are shown
```

### 3. Run the App
```bash
# For Android emulator or device
flutter run

# For iOS simulator (macOS only)
flutter run -d ios

# For web
flutter run -d chrome
```

## First Time Setup

When you first run the app:

1. **Welcome Screen** appears
2. Choose **"Continue as Model"** or **"Continue as Brand Owner"**
3. **Sign Up** with test credentials:
   - Email: test@example.com
   - Password: password123
   - Name: Test User

## Testing the Features

### As a Model:
1. **View Dashboard** - See profile statistics
2. **Browse Jobs** - Navigate to Jobs tab
3. **Build Portfolio** - Go to Portfolio tab → Click "+"
4. **Apply for Jobs** - Jobs tab → Click "APPLY NOW"
5. **Boost Profile** - Dashboard → "Boost Profile" button
6. **Chat** - Messages tab to view conversations

### As a Brand Owner:
1. **View Dashboard** - See business statistics  
2. **Find Models** - Navigate to Find Models tab
3. **View Bookings** - Check Bookings tab
4. **Message Models** - Go to Messages tab
5. **Manage Profile** - Profile tab for settings

## Project Structure at a Glance

```
castiq_2/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/                # Data models (7 files)
│   ├── providers/             # State management (3 files)
│   ├── screens/               # UI screens (13 files)
│   └── theme/                 # App theme
├── test/                      # Unit & widget tests
├── android/                   # Android configuration
├── ios/                       # iOS configuration
└── assets/                    # Images and icons
```

## Common Commands

### Development
```bash
# Hot reload (press 'r' in terminal while running)
# Hot restart (press 'R')

# Format code
flutter format .

# Analyze code
flutter analyze

# Run tests
flutter test
```

### Building
```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web
```

## Mock Data

The app currently uses mock data for demonstration:

- **Jobs**: 2 pre-populated jobs for models to browse
- **Models**: 3 sample model profiles for brands
- **Conversations**: 3 sample chat conversations
- **Bookings**: 3 sample bookings with different statuses

## Key Features Demo

### 1. Authentication Flow
```
Welcome → Login/Signup → Dashboard
```

### 2. Model Workflow
```
Dashboard → Browse Jobs → Apply → Chat with Brand → Get Booked
```

### 3. Brand Owner Workflow
```
Dashboard → Find Models → View Portfolio → Book Model → Chat
```

### 4. Payment Flow
```
Profile → Boost Profile → Select Plan → Payment → Activated
```

## Customization

### Change Theme Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color primaryBlack = Color(0xFF000000);
static const Color primaryWhite = Color(0xFFFFFFFF);
```

### Add New Screen
1. Create file in `lib/screens/`
2. Add route in `lib/main.dart`
3. Add navigation in appropriate screen

### Modify Mock Data
Edit the mock data in:
- `lib/providers/job_provider.dart` - for jobs
- `lib/screens/matchmaker/matchmaker_screen.dart` - for models
- `lib/screens/chat/chat_screen.dart` - for messages

## Troubleshooting

### Issue: Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Issue: Build fails
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean
cd .. && flutter run
```

### Issue: Hot reload not working
```bash
# Stop the app and restart
flutter run
```

## Backend Integration

To connect to a backend API:

1. Create API service in `lib/services/api_service.dart`
2. Update providers to use API service instead of mock data
3. Add API base URL to configuration
4. Handle authentication tokens

Example:
```dart
// lib/services/api_service.dart
class ApiService {
  static const String baseUrl = 'https://your-api.com';
  
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'email': email, 'password': password},
    );
    return User.fromJson(jsonDecode(response.body));
  }
}
```

## Next Steps

1. **Read IMPLEMENTATION.md** - Detailed technical documentation
2. **Check CONTRIBUTING.md** - If you want to contribute
3. **Review README.md** - Complete feature list
4. **Explore the code** - Start with `lib/main.dart`

## Getting Help

- 📖 Check documentation files (README, IMPLEMENTATION, CONTRIBUTING)
- 🐛 Search GitHub issues
- 💬 Open a new issue for questions
- 📧 Contact the development team

## Development Tips

1. **Use Hot Reload** - Press 'r' for instant UI updates
2. **Check Console** - Monitor debug output for errors
3. **Use DevTools** - `flutter pub global run devtools`
4. **Keep Dependencies Updated** - `flutter pub upgrade`
5. **Format Code** - Run `flutter format .` before commits

## Success Criteria

You've successfully set up Castiq when:
- ✅ App launches without errors
- ✅ You can navigate between screens
- ✅ You can switch between Model and Brand Owner views
- ✅ Mock data displays correctly
- ✅ All bottom navigation tabs work

## What's Next?

After getting familiar with the app:
1. Connect to a backend API
2. Implement real authentication
3. Add cloud storage for images/videos
4. Integrate payment gateway
5. Add push notifications

Happy coding! 🚀
