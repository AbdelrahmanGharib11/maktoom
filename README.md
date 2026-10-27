# Maktom (مكتوم) - Your Feelings. Safe. Anonymous. Heard.

Maktom is a premium mental wellness platform designed to provide a "Safe Sanctuary" for individuals seeking professional support and community connection without the fear of judgment. The platform prioritizes privacy through anonymous aliases and avatars.

## 🌿 Project Philosophy
- **Privacy First**: Total anonymity by default.
- **Safe Sanctuary Aesthetic**: A calming, botanical design system using soft greens, earthy tones, and premium typography.
- **Accessibility**: Support for English and Arabic (RTL) with localized content.

## 🏗️ Architecture: Clean & Feature-First
The project follows **Clean Architecture** principles combined with a **Feature-First** structure to ensure scalability and maintainability. It utilizes the **MVVM (Model-View-ViewModel)** pattern for state management.

### Directory Structure
```text
lib/
├── core/                   # Shared core logic and design system
│   ├── di/                 # Dependency Injection modules (Injectable)
│   ├── error/              # Custom failures and exception handling
│   ├── network/            # Dio configuration and Auth Interceptors
│   ├── services/           # Global services (Router, LocaleCubit, AuthListenable)
│   ├── theme/              # Design tokens (Colors, Typography, Theme)
│   ├── utils/              # Extensions and Helpers (ResponsiveHelper, l10n)
│   └── widgets/            # Reusable UI components (Buttons, TextFields)
├── features/               # Independent feature modules
│   ├── auth/               # Authentication (Login, Register, OTP) - [Cubit]
│   ├── circles/            # Anonymous community spaces
│   ├── crisis_protocol/    # Emergency support resources
│   ├── home/               # Personalized dashboard and mood tracking
│   ├── journal/            # Private daily reflections
│   ├── onboarding/         # Splash and welcome experiences
│   ├── profile/            # Anonymous user settings
│   ├── sessions/           # In-session experience and timers
│   └── therapists/         # Expert directory and booking flow - [Cubit]
├── l10n/                   # Localization files (ARB)
├── injection_container.dart # Entry point for Dependency Injection
└── main.dart               # App entry point
```

## 🚀 Key Features Implemented
- **Cubit-based MVVM State Management**: Migration from Riverpod to BLoC/Cubit for predictable and testable state transitions.
- **Modern High-Fidelity UI**: Fully responsive layouts using `ResponsiveHelper` for consistent scaling across devices.
- **Dependency Injection**: Centralized service locator using `GetIt` and `Injectable` for automated dependency management.
- **Automated Authentication**: Secure token management via `Dio` interceptors and `FlutterSecureStorage`.
- **Dual Localization**: Complete English and Arabic support with real-time RTL/LTR switching.
- **Dynamic Navigation**: Centralized routing via `GoRouter` with auth-guarded redirects.
- **Design System**: A robust theme engine using `Outfit` (EN) and `Cairo` (AR) fonts with a curated botanical palette.

## 🛠️ Tech Stack
- **Framework**: Flutter (3.x+)
- **State Management**: [flutter_bloc (Cubit)](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable)
- **Networking**: [Dio](https://pub.dev/packages/dio) with Auth Interceptors
- **Local Storage**: [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) & Hive
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Responsiveness**: Custom `ResponsiveHelper` extension on `BuildContext`.

## 📦 Getting Started
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run Code Generation** (Injectable & JSON Serializable):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## 📝 Recent Migration Highlights (Riverpod to Cubit)
- **Removed Riverpod**: Completely removed `flutter_riverpod` and all provider files.
- **Implemented Cubits**: Created `AuthCubit`, `TherapistsCubit`, and `LocaleCubit`.
- **DI Integration**: Registered all repositories and cubits using `@lazySingleton` and `@injectable`.
- **Auth Guard**: Implemented `AuthListenable` to bridge Cubit state with GoRouter for real-time navigation updates.
- **Cleanup**: Resolved all broken imports and compilation errors resulting from the architecture shift.

---
*Built with ❤️ for mental wellness and privacy.*
