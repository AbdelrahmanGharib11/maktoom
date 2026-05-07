# Maktom (مكتوم) - Your Feelings. Safe. Anonymous. Heard.

Maktom is a premium mental wellness platform designed to provide a "Safe Sanctuary" for individuals seeking professional support and community connection without the fear of judgment. The platform prioritizes privacy through anonymous aliases and avatars.

## 🌿 Project Philosophy
- **Privacy First**: Total anonymity by default.
- **Safe Sanctuary Aesthetic**: A calming, botanical design system using soft greens, earthy tones, and premium typography.
- **Accessibility**: Support for English and Arabic (RTL) with localized content.

## 🏗️ Architecture: Clean & Feature-First
The project follows **Clean Architecture** principles combined with a **Feature-First** structure to ensure scalability and maintainability.

### Directory Structure
```text
lib/
├── core/                   # Shared core logic and design system
│   ├── services/           # Global services (Router, LocaleProvider)
│   ├── theme/              # Design tokens (Colors, Typography, Theme)
│   ├── utils/              # Extensions and Helpers (ResponsiveHelper, l10n)
│   └── widgets/            # Reusable UI components (Buttons, MoodPicker)
├── features/               # Independent feature modules
│   ├── circles/            # Anonymous community spaces
│   ├── crisis_protocol/    # Emergency support resources
│   ├── home/               # Personalized dashboard and mood tracking
│   ├── journal/            # Private encrypted daily reflections
│   ├── onboarding/         # Splash and welcome experiences
│   ├── profile/            # Anonymous user settings
│   ├── sessions/           # In-session experience and timers
│   └── therapists/         # Verified expert directory and booking
├── l10n/                   # Localization files (ARB)
├── injection_container.dart # Dependency Injection setup
└── main.dart               # App entry point
```

## 🚀 Key Features Implemented
- **Modern High-Fidelity UI**: Fully responsive layouts using `ResponsiveHelper` for consistent scaling across devices.
- **Dual Localization**: Complete English and Arabic support with real-time RTL/LTR switching.
- **Dynamic Navigation**: Centralized routing via `GoRouter` with a synchronized universal bottom navigation system.
- **Design System**: A robust theme engine using `Outfit` (EN) and `Cairo` (AR) fonts with a curated `AppColors` palette.
- **Encrypted Journaling**: A premium reflection system with mood streaks and modular entry cards.
- **Therapist Ecosystem**: Comprehensive expert directory with specialized booking flows and professional resource libraries.

## 🛠️ Tech Stack
- **Framework**: Flutter (3.x+)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Localization**: Flutter Localizations (ARB)
- **State Management**: [ListenableBuilder] & [Provider] (Architecture ready for BLoC/Cubit)
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
3. **Run the app**:
   ```bash
   flutter run
   ```

## 📝 Recent Improvements
- Optimized asset loading for all high-fidelity images.
- Standardized header patterns across all features with language toggles.
- Fixed dependency injection conflicts and navigation bottlenecks.
- Implemented a secure "In-Session" UI prototype.

---
*Built with ❤️ for mental wellness and privacy.*
