# Mobile Stock Opname Application - Technical Documentation

## Table of Contents
1. [Application Overview](#application-overview)
2. [System Architecture](#system-architecture)
3. [Features & Functionality](#features--functionality)
4. [Technical Stack](#technical-stack)
5. [Project Structure](#project-structure)
6. [API Integration](#api-integration)
7. [State Management](#state-management)
8. [Database Models](#database-models)
9. [Security Implementation](#security-implementation)
10. [Installation & Setup](#installation--setup)
11. [Build & Deployment](#build--deployment)
12. [Maintenance & Support](#maintenance--support)
13. [Known Issues](#known-issues)

---

## Application Overview

### Purpose
The Mobile Stock Opname application is an enterprise-grade Flutter mobile application designed for comprehensive asset management and inventory tracking. It enables organizations to conduct systematic stock opname (physical inventory counting) and manage asset-related workflows efficiently.

### Target Users
- **Asset Managers**: Monitor and analyze asset data through dashboards
- **Field Workers**: Conduct physical asset verification using mobile devices
- **Employees**: Submit various asset-related requests
- **System Administrators**: Manage user accounts and system configurations

### Key Business Benefits
- **Real-time Asset Tracking**: Live updates on asset status and location
- **Mobile-First Approach**: Optimized for field operations and on-site verification
- **Workflow Automation**: Streamlined request approval processes
- **Compliance Support**: Systematic asset tracking for audit requirements
- **Data Visualization**: Comprehensive reporting and analytics

---

## System Architecture

### Architecture Pattern
The application follows **Clean Architecture** principles with clear separation of concerns:

```
├── Presentation Layer (UI)
│   ├── Screens (StatefulWidget)
│   ├── Widgets (Reusable Components)
│   └── BLoC (State Management)
├── Domain Layer
│   ├── Repositories (Abstract)
│   ├── Use Cases (Business Logic)
│   └── Entities (Domain Models)
└── Data Layer
    ├── API Services (HTTP Client)
    ├── Repository Implementations
    └── Data Models (JSON Serialization)
```

### State Management
- **Primary**: BLoC (Business Logic Component) Pattern
- **Secondary**: Provider for navigation and shared state
- **Event-Driven**: Clear separation of UI events and business logic

### Navigation
- **Custom Router**: Centralized route management in `router.dart`
- **Bottom Navigation**: 4-tab structure (Dashboard, Opname, Requests, Profile)
- **Deep Linking**: Support for direct navigation to specific screens

---

## Features & Functionality

### 1. Authentication & Security
- **Login System**: Username/password authentication
- **Two-Factor Authentication**: OTP verification via email
- **Session Management**: Token-based authentication with auto-logout
- **Password Management**: Secure password change functionality

### 2. Dashboard & Analytics
- **Data Visualization**: Interactive charts (bar, pie, line, speed widgets)
- **Custom Calendar**: Asset-related scheduling and activity tracking
- **News Feed**: Company announcements and system updates
- **Real-time Metrics**: Live asset performance indicators

### 3. Asset Opname (Core Feature)
- **Scheduled Opname**: View and manage stock counting schedules
- **Asset Detail View**: Comprehensive asset information display
- **Form Management**: Record asset conditions and updates
- **Barcode/QR Scanning**: Quick asset identification using camera
- **Asset Reservation**: Reserve assets for opname processes

### 4. Request Management
- **Request Types**: Register, Sell, Disposal, Maintenance, Mutation, Other
- **Document Handling**: File upload and preview capabilities
- **Approval Workflow**: Multi-step approval process with status tracking
- **Request History**: Complete audit trail of all requests

### 5. Supporting Features
- **Profile Management**: User settings and preferences
- **Notification System**: Push notifications for important updates
- **Document Preview**: Support for PDF and image file viewing
- **Offline Capability**: Limited offline functionality for critical operations

---

## Technical Stack

### Core Framework
- **Flutter**: 3.24.0 (Managed via FVM)
- **Dart**: 3.5.0+ (Programming language)
- **FVM**: Flutter Version Management for consistent Flutter versions across team

### Key Dependencies

#### State Management
```yaml
flutter_bloc: ^8.1.1          # BLoC pattern implementation
provider: ^6.0.4              # Additional state management
equatable: ^2.0.5             # Value equality for BLoC states
```

#### UI/UX Libraries
```yaml
google_fonts: ^6.2.1          # Typography
fl_chart: ^0.69.2             # Data visualization
syncfusion_flutter_charts: ^20.4.48  # Advanced charts
shimmer: ^3.0.0               # Loading animations
auto_size_text: ^3.0.0        # Responsive text
```

#### Hardware Integration
```yaml
mobile_scanner: ^6.0.2        # Barcode/QR code scanning
image_picker: ^1.1.2          # Camera and gallery access
```

#### File & Document Management
```yaml
file_picker: ^8.1.7           # File selection
pdf: ^3.8.4                   # PDF generation
flutter_pdfview: ^1.3.4       # PDF viewing
open_file: ^3.2.1             # File opening
```

#### Network & Storage
```yaml
http: ^1.2.2                  # HTTP client
shared_preferences: ^2.0.15   # Local storage
url_launcher: ^6.1.10         # External links
```

#### Utilities
```yaml
intl: ^0.19.0                 # Internationalization
path: ^1.7.0                  # Path manipulation
path_provider: ^2.0.4         # Path provider
```

---

## Project Structure

```
lib/
├── features/                 # Feature-based modules
│   ├── login/               # Authentication
│   ├── dashboard/           # Analytics & overview
│   ├── asset_opname/        # Stock opname functionality
│   ├── asset_opname_detail/ # Asset detail views
│   ├── asset_opname_list/   # Asset listing
│   ├── additional_request/  # Request management
│   ├── profile/             # User management
│   └── ...
├── main.dart                # Application entry point
├── router.dart              # Navigation configuration
└── utility/                 # Shared utilities
    ├── alert_dialog_util.dart
    ├── general_util.dart
    ├── shared_pref_util.dart
    └── string_router_util.dart
```

### Feature Module Structure
Each feature follows a consistent pattern:
```
feature_name/
├── bloc/                    # State management
│   ├── feature_bloc/
│   │   ├── bloc.dart
│   │   ├── feature_bloc.dart
│   │   ├── feature_event.dart
│   │   └── feature_state.dart
├── data/                    # Data models
│   ├── request_model.dart
│   ├── response_model.dart
│   └── argument_model.dart
├── domain/                  # Business logic
│   ├── api/
│   │   └── feature_api.dart
│   └── repo/
│       └── feature_repo.dart
└── feature_screen.dart      # UI implementation
```

---

## API Integration

### Base Configuration
- **Protocol**: HTTPS
- **Authentication**: Bearer Token
- **Content-Type**: application/json
- **Timeout**: 30 seconds

### API Configuration
**⚠️ IMPORTANT FOR PRODUCTION DEPLOYMENT:**

To change the API base URL for production, update the following file:
```
📁 File Location: lib/utility/url_util.dart
📝 Line 4: static String baseUrl = 'http://xxx.xxx.xxx.xxx/';
```

**Current Configuration:**
```dart
// lib/utility/url_util.dart
class UrlUtil {
  static String baseUrl = 'http://xxx.xxx.xxx.xxx/'; // ← Change this for production
  
  static Map<String, String> headerType() =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};
  
  static Map<String, String> headerTypeWithToken(String token, String userId) =>
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Userid': userId
      };
  
  // All API endpoints are built using this baseUrl
  static String urlLogin() => 'Token_SOMobile/api/Authenticate/requestValidate';
  
  String getUrlLogin() {
    return baseUrl + urlLogin(); // Complete URL construction
  }
}
```

**Steps to Update for Production:**
1. Open `lib/utility/url_util.dart`
2. Update line 4: `static String baseUrl = 'https://your-production-api.com/';`
3. Ensure the URL ends with a forward slash `/`
4. Test all API endpoints with the new base URL
5. Rebuild the application for production deployment

### Repository Pattern
```dart
// Repository implementation
class FeatureRepo {
  final FeatureApi _api = FeatureApi();
  
  Future<Either<Exception, ResponseModel>> getData() async {
    try {
      final result = await _api.getData();
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
```

---

## State Management

### BLoC Pattern Implementation
```dart
// Event
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();
}

class LoadDataEvent extends FeatureEvent {
  @override
  List<Object?> get props => [];
}

// State
abstract class FeatureState extends Equatable {
  const FeatureState();
}

class FeatureInitial extends FeatureState {
  @override
  List<Object?> get props => [];
}

class FeatureLoading extends FeatureState {
  @override
  List<Object?> get props => [];
}

class FeatureLoaded extends FeatureState {
  final List<DataModel> data;
  
  const FeatureLoaded({required this.data});
  
  @override
  List<Object?> get props => [data];
}

// BLoC
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepo _repo;
  
  FeatureBloc({required FeatureRepo repo}) 
    : _repo = repo,
      super(FeatureInitial()) {
    on<LoadDataEvent>(_onLoadData);
  }
  
  Future<void> _onLoadData(
    LoadDataEvent event,
    Emitter<FeatureState> emit,
  ) async {
    emit(FeatureLoading());
    
    final result = await _repo.getData();
    
    result.fold(
      (failure) => emit(FeatureError(failure.toString())),
      (success) => emit(FeatureLoaded(data: success.data)),
    );
  }
}
```

---

## Database Models

### Asset Model Structure
```dart
class AssetModel {
  final String assetCode;
  final String barcode;
  final String description;
  final String condition;
  final String status;
  final String category;
  final String location;
  final double purchasePrice;
  final double currentValue;
  final String picName;
  final DateTime lastUpdate;
  
  // JSON serialization methods
  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    assetCode: json['asset_code'] ?? '',
    barcode: json['barcode'] ?? '',
    description: json['description'] ?? '',
    condition: json['condition'] ?? '',
    status: json['status'] ?? '',
    category: json['category'] ?? '',
    location: json['location'] ?? '',
    purchasePrice: (json['purchase_price'] ?? 0).toDouble(),
    currentValue: (json['current_value'] ?? 0).toDouble(),
    picName: json['pic_name'] ?? '',
    lastUpdate: DateTime.parse(json['last_update']),
  );
  
  Map<String, dynamic> toJson() => {
    'asset_code': assetCode,
    'barcode': barcode,
    'description': description,
    'condition': condition,
    'status': status,
    'category': category,
    'location': location,
    'purchase_price': purchasePrice,
    'current_value': currentValue,
    'pic_name': picName,
    'last_update': lastUpdate.toIso8601String(),
  };
}
```

### Request Model Structure
```dart
class RequestModel {
  final String requestId;
  final String assetCode;
  final String requestType;
  final String status;
  final String requesterName;
  final String approverName;
  final DateTime requestDate;
  final String notes;
  final List<AttachmentModel> attachments;
  
  // Implementation details...
}
```

---

## Security Implementation

### Authentication Flow
1. **Login**: Username/password validation
2. **OTP Verification**: Email-based two-factor authentication
3. **Token Management**: JWT token storage and refresh
4. **Session Timeout**: Automatic logout after inactivity

### Data Protection
- **Token Storage**: Secure storage using SharedPreferences
- **API Security**: HTTPS communication with certificate pinning
- **Input Validation**: Client-side validation for all forms
- **Error Handling**: Secure error messages without sensitive data exposure

### Permission Management
- **Camera Access**: Required for barcode scanning
- **Storage Access**: Required for file uploads and downloads
- **Network Access**: Required for API communication

---

## Installation & Setup

### Prerequisites
- **FVM (Flutter Version Management)**: For consistent Flutter version management
- **Flutter SDK**: 3.24.0 (via FVM)
- **Dart SDK**: 3.5.0+ (included with Flutter)
- **Android Studio / VS Code**: IDE
- **Android SDK**: For Android builds
- **Xcode**: For iOS builds (macOS only)

### Development Setup
1. **Install FVM (if not already installed)**
   ```bash
   dart pub global activate fvm
   ```

2. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd mobile_so
   ```

3. **Install Flutter Version via FVM**
   ```bash
   fvm install 3.24.0
   fvm use 3.24.0
   ```

4. **Install Dependencies**
   ```bash
   fvm flutter pub get
   ```

5. **Configure Environment**
   ```bash
   # Add API endpoints and keys to environment configuration
   cp .env.example .env
   # Edit .env with actual values
   ```

6. **Run Application**
   ```bash
   fvm flutter run
   ```

### IDE Configuration
- **VS Code**: Install Flutter and Dart extensions
  - Configure FVM integration in VS Code settings
  - Set Flutter SDK path to FVM managed version
- **Android Studio**: Install Flutter and Dart plugins
  - Configure Flutter SDK path to use FVM managed version
- **Debug Configuration**: Set up launch configurations for different environments

---

## Build & Deployment

### Android Build
1. **Debug Build**
   ```bash
   fvm flutter build apk --debug
   ```

2. **Release Build**
   ```bash
   fvm flutter build apk --release
   ```

3. **App Bundle (Play Store)**
   ```bash
   fvm flutter build appbundle --release
   ```

### iOS Build
1. **Debug Build**
   ```bash
   fvm flutter build ios --debug
   ```

2. **Release Build**
   ```bash
   fvm flutter build ios --release
   ```

### Build Configuration
- **Version Management**: Update `pubspec.yaml` version before builds
- **Signing**: Configure signing certificates for release builds
- **Obfuscation**: Enable code obfuscation for release builds
- **Asset Optimization**: Optimize images and assets for production

### Deployment Checklist
- [ ] Update version number in `pubspec.yaml`
- [ ] Test on multiple devices and screen sizes
- [ ] Verify API endpoints for production environment
- [ ] Test offline functionality
- [ ] Validate push notification setup
- [ ] Review security configurations
- [ ] Generate signed builds
- [ ] Test installation on clean devices

---

## Maintenance & Support

#### Build Issues
- **Gradle Build Failed**: Clear cache and rebuild
  ```bash
  fvm flutter clean
  fvm flutter pub get
  fvm flutter build apk
  ```

- **iOS Build Issues**: Update pods and clean build
  ```bash
  cd ios
  pod install
  cd ..
  fvm flutter clean
  fvm flutter build ios
  ```

#### Runtime Issues
- **BLoC State Issues**: Check event dispatching and state transitions
- **Navigation Issues**: Verify route configurations and arguments
- **API Connection**: Check network connectivity and endpoint availability
---

## Known Issues

### Current Limitations
1. **Offline Functionality**: Limited offline capabilities for certain features
2. **File Size Limits**: Large file uploads may cause performance issues
3. **iOS Specific**: Some chart animations may lag on older iOS devices
4. **Android Specific**: Camera permissions require manual approval on some devices

### Future Enhancements
1. **Enhanced Offline Support**: Implement local database synchronization
2. **Performance Optimizations**: Optimize image loading and caching
3. **Additional Chart Types**: Expand visualization options
4. **Multi-language Support**: Implement internationalization
5. **Advanced Filtering**: Enhanced search and filter capabilities

### Bug Tracking
- **Issue Tracking**: [Link to issue tracking system]
- **Bug Reports**: [Contact/Process for bug reporting]
- **Feature Requests**: [Process for feature requests]

---

## Technical Support

### Development Environment
- **FVM**: Flutter Version Management
- **Flutter Version**: 3.24.0 (managed via FVM)
- **Dart Version**: 3.5.0+ (included with Flutter)
- **Minimum Android Version**: API 21 (Android 5.0)
- **Minimum iOS Version**: iOS 11.0

### Performance Specifications
- **App Size**: ~50MB (varies by platform)
- **Memory Usage**: ~100MB average
- **Battery Impact**: Low to moderate (depends on camera usage)
- **Network Usage**: Moderate (depends on data synchronization frequency)
