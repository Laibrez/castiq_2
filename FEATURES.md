# Castiq Features Showcase

This document provides a detailed walkthrough of all features in the Castiq application.

## 🎨 Theme & Design

### Black & White Color Scheme
- **Primary Black**: #000000 - Used for headers, buttons, and primary elements
- **Primary White**: #FFFFFF - Used for backgrounds and text on dark elements
- **Dark Grey**: #2C2C2C - Used for secondary elements
- **Light Grey**: #E0E0E0 - Used for borders and dividers

### Design Principles
- Clean, minimalist interface
- High contrast for readability
- Consistent spacing and typography
- Professional, modern aesthetic

---

## 🔐 Authentication System

### Welcome Screen
**Features:**
- Large "CASTIQ" branding
- Two user type options
- Clear call-to-action buttons

**User Flow:**
```
Welcome Screen
├── Continue as Model → Model Login/Signup
└── Continue as Brand Owner → Brand Login/Signup
```

### Login Screen
**Features:**
- Email and password fields
- Password visibility toggle
- Forgot password link (UI ready)
- Sign up redirect
- Loading state during authentication

**Validation:**
- Email format validation
- Password minimum length (6 characters)
- Required field validation

### Signup Screen
**Features:**
- Full name input
- Email validation
- Password with confirmation
- Terms & conditions checkbox
- Account type pre-selected based on user choice

**Security:**
- Password confirmation matching
- Terms acceptance requirement
- Secure password entry

---

## 👤 User Profiles

### Model Profile
**Information Stored:**
- Basic info (name, email, phone)
- Bio and description
- Physical measurements (height, measurements)
- Skills and specialties
- Languages spoken
- Location
- Profile boost status

### Brand Owner Profile
**Information Stored:**
- Company name
- Company description
- Industry type
- Location
- Website (optional)
- Verification status

---

## ✅ ID Verification

### Verification Process
1. **Upload ID Front**
   - Camera or gallery selection
   - Image preview before submission
   - Quality check (visual)

2. **Upload ID Back**
   - Same process as front
   - Both sides required

3. **Selfie with ID**
   - Camera capture
   - Shows user holding ID
   - Verification confirmation

**Benefits:**
- Builds trust in marketplace
- Prevents fraud
- Professional credibility
- Access to premium features

**Visual Feedback:**
- ✓ Green checkmark when image uploaded
- Image thumbnail preview
- Progress indication
- Success confirmation

---

## 📸 Portfolio Management

### For Models Only

**Features:**
- Grid layout display (2 columns)
- Image and video support
- Upload from gallery
- Delete with confirmation
- Empty state with call-to-action

**Upload Process:**
1. Tap "+" button or "Add Item"
2. Choose Image or Video
3. Select from gallery
4. Instant preview
5. Add to portfolio

**Portfolio Display:**
- Images: Full thumbnail display
- Videos: Play icon overlay
- Delete button on each item
- Responsive grid layout
- Smooth animations

---

## 🎯 Matchmaker System

### For Models - Job Discovery

**Job Listing Features:**
- Job title and budget prominently displayed
- Location with icon
- Date range
- Description preview
- Requirements as chips
- Apply button

**Job Details Include:**
- Budget in USD
- Location
- Start and end dates
- Full description
- List of requirements
- Brand owner info (expandable)

**Actions:**
- Browse all available jobs
- Filter by criteria (ready for implementation)
- Apply directly
- Save jobs (ready for implementation)

### For Brand Owners - Model Discovery

**Model Listing Features:**
- Profile picture/avatar
- Name and location
- Height and measurements
- View profile button
- Portfolio access

**Model Profile View:**
- Full portfolio gallery
- Skills and experience
- Contact option
- Booking option
- Reviews (ready for implementation)

---

## 💳 Payment System

### Profile Boost for Models

**Plans Available:**

1. **7 Days - $9.99**
   - Entry level boost
   - Try before committing

2. **30 Days - $29.99** ⭐ POPULAR
   - Best value
   - Most popular choice
   - Highlighted in UI

3. **90 Days - $69.99**
   - Maximum exposure
   - Best for serious models

**Boost Benefits:**
- ✓ Priority in search results
- ✓ Featured badge on profile
- ✓ 3x more profile views
- ✓ Higher job match rate

**Payment Flow:**
1. Select boost plan
2. Enter card details
   - Card number
   - Cardholder name
   - Expiry date (MM/YY)
   - CVV
3. Review total
4. Complete payment
5. Boost activated immediately

**Payment Security:**
- Card detail validation
- Secure input fields
- PCI compliance ready
- Transaction confirmation

---

## 📅 Booking System

### For Brand Owners

**Booking Statuses:**

1. **Pending** 🟠
   - Awaiting model confirmation
   - Can be cancelled
   - Can be confirmed

2. **Confirmed** 🟢
   - Model has accepted
   - Payment processed
   - Can message model

3. **Completed** 🔵
   - Job finished
   - Payment released to model
   - Can leave review

4. **Cancelled** 🔴
   - Booking cancelled
   - Refund processed

**Booking Details:**
- Model name
- Job title
- Date and time
- Amount
- Status indicator
- Action buttons based on status

**Actions Available:**
- Confirm pending bookings
- Cancel pending bookings
- Message models (for confirmed bookings)
- View booking history
- Download receipts (ready for implementation)

---

## 💬 Chat System

### Conversations List

**Features:**
- Contact name with avatar
- Last message preview
- Timestamp
- Unread message count badge
- Sorted by most recent

**Conversation View:**
- Message bubbles (sender vs receiver)
- Timestamps
- Message delivery status (ready for implementation)
- Video call button (UI ready)
- Voice call button (UI ready)

**Messaging Features:**
- Text messages
- Real-time updates (ready for WebSocket)
- Message history
- Send button
- Input field with border

**Message Display:**
- Sender messages: Right-aligned, primary color
- Receiver messages: Left-aligned, surface color
- Timestamps on all messages
- Max width constraint (70% of screen)

---

## 📊 Dashboard

### For Models

**Statistics Displayed:**
1. **Profile Views**
   - Blue icon
   - Current count (1,234)
   - Visual card display

2. **Active Applications**
   - Orange icon
   - Number of pending applications (5)
   - Quick access

3. **Completed Jobs**
   - Green icon
   - Total completed (12)
   - Earnings indicator

**Quick Actions:**
- Boost Profile button
- Direct access to payment

### For Brand Owners

**Statistics Displayed:**
1. **Active Jobs**
   - Blue icon
   - Number of open positions (3)

2. **Applications Received**
   - Orange icon
   - Total applications (28)

3. **Upcoming Bookings**
   - Green icon
   - Scheduled bookings (2)

**Quick Actions:**
- Post New Job button
- Access to job posting form

---

## ⚙️ Settings & Profile

### Profile Screen

**User Information:**
- Large profile avatar (letter-based for now)
- Full name
- Email address
- Verification status badge

**Menu Options:**

1. **Edit Profile**
   - Update personal info
   - Change profile picture
   - Update bio

2. **Payment Methods**
   - Saved cards
   - Add new card
   - Set default

3. **Earnings** (Models only)
   - Total earnings
   - Pending payments
   - Transaction history

4. **Activity History**
   - Recent actions
   - Login history
   - Application history

5. **Help & Support**
   - FAQs
   - Contact support
   - Report issue

6. **Privacy Policy**
   - Terms of service
   - Privacy details
   - Data handling

7. **Logout**
   - Confirmation dialog
   - Clear session
   - Return to welcome

---

## 🔔 Notifications (Ready for Implementation)

**Notification Types:**
- New job matches
- Application updates
- Booking confirmations
- Messages received
- Payment received
- Profile boost expiring

**Notification Center:**
- Bell icon in app bar
- Badge with unread count
- Notification list
- Mark as read
- Clear all

---

## 🎯 Navigation

### Bottom Navigation Bar

**5 Tabs for Models:**
1. Home (Dashboard)
2. Jobs (Matchmaker)
3. Portfolio
4. Messages
5. Profile

**5 Tabs for Brand Owners:**
1. Home (Dashboard)
2. Find Models
3. Bookings
4. Messages
5. Profile

**Navigation Features:**
- Active tab highlighting
- Icon changes on selection
- Smooth transitions
- State preservation

---

## 📱 Responsive Design

**Screen Support:**
- Portrait orientation
- Landscape orientation (limited)
- Various screen sizes
- Tablet support (basic)

**Accessibility:**
- High contrast colors
- Large touch targets
- Clear visual hierarchy
- Screen reader support (basic)

---

## 🚀 Performance Features

**Optimizations:**
- Lazy loading for images
- Pagination ready for long lists
- Cached network images
- Minimal rebuilds with Provider
- Const constructors where possible

---

## 🔒 Security Features

**Current Implementation:**
- Password obscuring
- Input validation
- Secure form handling
- Session management (basic)

**Ready for Integration:**
- JWT token storage
- Encrypted data transmission
- Secure file uploads
- Two-factor authentication

---

## 📈 Future Enhancements

**Planned Features:**
1. Advanced search filters
2. In-app reviews and ratings
3. Calendar integration
4. Video portfolios
5. Live chat
6. Push notifications
7. Analytics dashboard
8. Export data functionality
9. Multi-language support
10. Dark mode toggle

---

This showcase demonstrates the comprehensive feature set of the Castiq marketplace application, designed for both models and brand owners.
