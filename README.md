# Castiq - Professional Marketplace for Models

A professional marketplace Flutter application connecting models with brand owners. The app features a black and white theme and provides comprehensive tools for both models and brands to connect, collaborate, and manage bookings.

## Features

### For Models
- **Portfolio Management**: Upload and showcase images and videos
- **Job Discovery**: Browse and apply for modeling jobs
- **Profile Boost**: Premium feature to increase visibility
- **ID Verification**: Secure identity verification system
- **Earnings Tracking**: Monitor payments and completed jobs
- **Direct Messaging**: Chat with brand owners

### For Brand Owners
- **Model Discovery**: Search and filter models based on requirements
- **Job Posting**: Create and manage job listings
- **Booking System**: Book models directly through the app
- **Payment Management**: Secure payment processing through Castiq
- **Direct Messaging**: Communicate with models

## Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **UI Theme**: Custom Black & White theme
- **Media Handling**: Image Picker, Video Player
- **Authentication**: Custom auth system (ready for backend integration)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart       # Black & white theme configuration
├── models/                  # Data models
│   ├── user.dart
│   ├── model_profile.dart
│   ├── brand_profile.dart
│   ├── portfolio_item.dart
│   ├── job.dart
│   ├── booking.dart
│   └── chat_message.dart
├── providers/               # State management
│   ├── auth_provider.dart
│   ├── portfolio_provider.dart
│   └── job_provider.dart
├── screens/                 # UI screens
│   ├── auth/               # Authentication screens
│   ├── home_screen.dart    # Main dashboard
│   ├── profile/            # Profile and verification
│   ├── portfolio/          # Portfolio management
│   ├── matchmaker/         # Job/model discovery
│   ├── payment/            # Payment and boost
│   ├── chat/               # Messaging
│   └── booking/            # Booking management
└── widgets/                # Reusable components
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Laibrez/castiq_2.git
cd castiq_2
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## User Flow

### Model Registration Flow
1. Select "Continue as Model" on welcome screen
2. Sign up with email and password
3. Complete profile setup
4. Submit ID verification
5. Build portfolio by uploading photos/videos
6. Browse and apply for jobs
7. Optional: Purchase profile boost for increased visibility

### Brand Owner Registration Flow
1. Select "Continue as Brand Owner" on welcome screen
2. Sign up with company details
3. Complete brand profile setup
4. Submit ID verification
5. Create job postings
6. Browse and filter models
7. Book models for jobs
8. Process payments through Castiq

## Key Features Explained

### ID Verification
- Front and back ID photo upload
- Selfie with ID for identity confirmation
- Secure verification process
- Builds trust in the marketplace

### Payment System
- Brand owners pay Castiq
- Castiq pays models after job completion
- Secure escrow-like payment flow
- Profile boost purchases for models

### Matchmaker
- **For Models**: Browse available jobs, filter by location/budget, apply directly
- **For Brands**: Discover models, filter by skills/measurements, view portfolios

### Chat System
- Real-time messaging (ready for WebSocket integration)
- Direct communication between models and brands
- Message history and notifications

## Customization

### Theme Colors
Edit `lib/theme/app_theme.dart` to customize the black and white color scheme:
```dart
static const Color primaryBlack = Color(0xFF000000);
static const Color primaryWhite = Color(0xFFFFFFFF);
// Add more customizations...
```

## Backend Integration

This app is designed with mock data and is ready for backend integration. Key integration points:

1. **Authentication**: Replace mock auth in `auth_provider.dart` with actual API calls
2. **Media Upload**: Implement file upload to cloud storage (AWS S3, Firebase Storage, etc.)
3. **Real-time Chat**: Integrate WebSocket or Firebase for real-time messaging
4. **Payment Gateway**: Integrate Stripe, PayPal, or similar for payment processing
5. **Push Notifications**: Add FCM for notifications

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Contact

For questions or support, please contact the Castiq team.

---

**Note**: This is a frontend implementation. Backend services need to be set up separately for production use.
