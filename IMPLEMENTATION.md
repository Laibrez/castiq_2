# Castiq App - Implementation Details

## Overview
This document provides detailed information about the Castiq Flutter application implementation, including architecture, features, and integration points.

## Architecture

### State Management
The app uses the **Provider** pattern for state management with three main providers:

1. **AuthProvider** (`lib/providers/auth_provider.dart`)
   - Manages user authentication state
   - Handles login/signup/logout operations
   - Stores current user information
   - Updates user verification status

2. **PortfolioProvider** (`lib/providers/portfolio_provider.dart`)
   - Manages model portfolio items
   - Handles image/video uploads
   - Provides CRUD operations for portfolio items

3. **JobProvider** (`lib/providers/job_provider.dart`)
   - Manages job listings
   - Handles job creation for brand owners
   - Provides job search and filtering capabilities

### Data Models

All data models are located in `lib/models/` and include:

- **User**: Base user model with type (model/brand owner)
- **ModelProfile**: Extended profile for models
- **BrandProfile**: Extended profile for brand owners
- **PortfolioItem**: Media items in model portfolios
- **Job**: Job postings created by brand owners
- **Booking**: Booking records between brands and models
- **ChatMessage**: Message data for chat functionality

### Theme System

The app uses a custom black and white theme defined in `lib/theme/app_theme.dart`:

**Light Theme**:
- Primary: Black (#000000)
- Background: White (#FFFFFF)
- Accent: Dark Grey (#2C2C2C)

**Dark Theme**:
- Primary: White (#FFFFFF)
- Background: Black (#000000)
- Accent: Light Grey (#E0E0E0)

## Features Implementation

### 1. Authentication System

**Location**: `lib/screens/auth/`

**Flow**:
1. User sees welcome screen with two options (Model/Brand Owner)
2. User can login or signup
3. Credentials validated (currently mock, ready for API integration)
4. User redirected to home screen

**Files**:
- `welcome_screen.dart`: Initial entry point
- `login_screen.dart`: Login form
- `signup_screen.dart`: Registration form

### 2. ID Verification

**Location**: `lib/screens/profile/id_verification_screen.dart`

**Process**:
1. User uploads front of ID
2. User uploads back of ID
3. User takes selfie with ID
4. All images submitted for verification
5. User verification status updated

**Integration Notes**:
- Currently uses local image picker
- Ready for cloud storage upload (AWS S3, Firebase, etc.)
- Verification logic needs backend implementation

### 3. Portfolio Management

**Location**: `lib/screens/portfolio/portfolio_screen.dart`

**Features**:
- Grid view of portfolio items
- Upload images from gallery
- Upload videos from gallery
- Delete portfolio items
- View full-screen media

**Technical Details**:
- Uses `image_picker` package for media selection
- Displays images using `Image.file()`
- Video thumbnails can be generated with `video_thumbnail` package
- Currently stores local file paths (needs cloud storage integration)

### 4. Matchmaker System

**Location**: `lib/screens/matchmaker/matchmaker_screen.dart`

**For Models**:
- Browse available jobs
- Filter by location, budget, date
- View job details and requirements
- Apply for jobs directly

**For Brand Owners**:
- Browse model profiles
- Filter by skills, measurements, location
- View portfolios
- Contact models directly

**Data Flow**:
```
JobProvider → Load Jobs → Display in List
User Action → Apply/Contact → Update Backend
```

### 5. Payment System

**Location**: `lib/screens/payment/payment_screen.dart`

**Profile Boost Plans**:
- 7 Days: $9.99
- 30 Days: $29.99 (Popular)
- 90 Days: $69.99

**Benefits**:
- Priority in search results
- Featured badge on profile
- 3x more profile views
- Higher job match rate

**Payment Flow**:
```
Select Plan → Enter Card Details → Process Payment → Activate Boost
```

**Integration Requirements**:
- Payment gateway (Stripe, PayPal, Square)
- Secure card tokenization
- Backend payment processing
- Receipt generation

### 6. Chat System

**Location**: `lib/screens/chat/chat_screen.dart`

**Features**:
- List of conversations
- Real-time messaging interface
- Message history
- Unread message indicators
- Video/voice call buttons (UI only)

**Integration Needed**:
- WebSocket for real-time messaging
- Message persistence (database)
- Push notifications for new messages
- Media sharing in chat

### 7. Booking System

**Location**: `lib/screens/booking/booking_screen.dart`

**Booking Statuses**:
- **Pending**: Awaiting confirmation
- **Confirmed**: Booking accepted
- **Completed**: Job finished
- **Cancelled**: Booking cancelled

**Payment Flow**:
```
Brand Owner Books Model → Pays Castiq → Job Completed → Castiq Pays Model
```

**Features**:
- View all bookings
- Filter by status
- Confirm/cancel bookings
- Message models from booking

## Navigation Structure

The app uses a bottom navigation bar with 5 tabs:

**For Models**:
1. Home (Dashboard)
2. Jobs (Matchmaker)
3. Portfolio
4. Messages (Chat)
5. Profile

**For Brand Owners**:
1. Home (Dashboard)
2. Find Models (Matchmaker)
3. Bookings
4. Messages (Chat)
5. Profile

## Backend Integration Guide

### Required API Endpoints

#### Authentication
```
POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout
GET  /api/auth/me
```

#### User Profile
```
GET    /api/users/:id
PUT    /api/users/:id
POST   /api/users/:id/verify
GET    /api/users/:id/portfolio
```

#### Jobs
```
GET    /api/jobs
POST   /api/jobs
GET    /api/jobs/:id
PUT    /api/jobs/:id
DELETE /api/jobs/:id
POST   /api/jobs/:id/apply
```

#### Bookings
```
GET    /api/bookings
POST   /api/bookings
GET    /api/bookings/:id
PUT    /api/bookings/:id/status
```

#### Messages
```
GET    /api/conversations
GET    /api/conversations/:id/messages
POST   /api/conversations/:id/messages
```

#### Payments
```
POST   /api/payments/boost
POST   /api/payments/booking
GET    /api/payments/history
```

### Database Schema Suggestions

#### Users Table
```sql
- id (UUID)
- email (unique)
- password_hash
- name
- user_type (enum: 'model', 'brand_owner')
- is_verified (boolean)
- profile_image_url
- phone
- created_at
- updated_at
```

#### Model Profiles Table
```sql
- id (UUID)
- user_id (FK to users)
- bio
- height
- measurements
- skills (JSON array)
- languages (JSON array)
- location
- is_profile_boosted
- boost_expiry_date
```

#### Jobs Table
```sql
- id (UUID)
- brand_owner_id (FK to users)
- title
- description
- location
- budget
- start_date
- end_date
- requirements (JSON array)
- status (enum)
- created_at
```

#### Bookings Table
```sql
- id (UUID)
- job_id (FK to jobs)
- model_id (FK to users)
- brand_owner_id (FK to users)
- status (enum)
- amount
- booking_date
- created_at
```

## Security Considerations

1. **Authentication**
   - Implement JWT tokens
   - Secure token storage
   - Token refresh mechanism

2. **Data Validation**
   - Client-side validation implemented
   - Server-side validation required
   - Input sanitization

3. **File Uploads**
   - Validate file types
   - Limit file sizes
   - Scan for malware
   - Generate thumbnails server-side

4. **Payment Processing**
   - Use PCI-compliant payment processor
   - Never store raw card data
   - Implement 3D Secure
   - Log all transactions

5. **Privacy**
   - Encrypt sensitive data
   - Implement data retention policies
   - GDPR compliance
   - User data export capability

## Testing Strategy

### Unit Tests
- Test all data models
- Test provider logic
- Test utility functions

### Widget Tests
- Test individual screens
- Test navigation flow
- Test form validation

### Integration Tests
- Test complete user flows
- Test API integration
- Test payment flow

## Performance Optimization

1. **Images**
   - Lazy loading
   - Image caching (using `cached_network_image`)
   - Thumbnail generation
   - Progressive loading

2. **Lists**
   - Pagination for long lists
   - Virtual scrolling
   - Pull-to-refresh

3. **State Management**
   - Minimize rebuilds
   - Use `const` constructors
   - Implement `shouldRebuild` logic

## Future Enhancements

1. **Advanced Search**
   - Multiple filter combinations
   - Saved searches
   - Search history

2. **Analytics Dashboard**
   - Profile views analytics
   - Booking trends
   - Revenue reports

3. **Social Features**
   - Model/brand reviews
   - Rating system
   - Social sharing

4. **Notifications**
   - Push notifications
   - Email notifications
   - In-app notifications center

5. **Multi-language Support**
   - Internationalization (i18n)
   - RTL support
   - Currency localization

## Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Support and Maintenance

For issues or questions:
1. Check the README.md for basic setup
2. Review this documentation for implementation details
3. Check GitHub issues for known problems
4. Contact the development team

---

**Last Updated**: December 2024
**Version**: 1.0.0
