# Crazy Notifier

Crazy Notifier is a Flutter-based mobile application that provides users with customizable notification management. The app integrates with Firebase for backend services and user authentication.

## Features

- User Authentication (Google and Email/Password)
- Personalized Greeting
- Notification Management
- Customizable Notification Types (News and Event)
- Adjustable Notification Frequency
- Push Notifications via Firebase Cloud Messaging (FCM)

## Project Structure

```
lib/
├── config/
│   └── theme.dart
├── models/
│   └── user_model.dart
├── screens/
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── notification_history_screen.dart
│   └── notification_preferences_screen.dart
├── services/
│   ├── auth_service.dart
│   └── notification_service.dart
├── utils/
│   └── constants.dart
├── widgets/
│   ├── animated_background.dart
│   ├── fancy_button.dart
│   └── firebase_options.dart
└── main.dart
```

### Key Components:

- **config**: Contains app-wide configuration files, including theming.
- **models**: Defines data structures, such as the user model.
- **screens**: Houses the main UI screens of the app.
- **services**: Manages Firebase authentication and notification handling.
- **utils**: Stores utility functions and constants.
- **widgets**: Contains reusable UI components.


## Project Architecture

This project follows a modular and organized structure to ensure maintainability and scalability. Here’s a breakdown of the directory structure:

### Directory Structure

- **`lib/`**: Contains all the Dart code for the application.

  - **`config/`**: Configuration files.
    - `theme.dart`: App theme configuration.

  - **`models/`**: Data models used in the app.
    - `user_model.dart`: Represents user-related data.

  - **`screens/`**: UI screens for different views in the app.
    - `home_screen.dart`: Main screen of the app.
    - `login_screen.dart`: Authentication screen.
    - `notification_history_screen.dart`: Displays notification history.
    - `notification_preferences_screen.dart`: Manages notification preferences.

  - **`services/`**: Business logic and external service interactions.
    - `auth_service.dart`: Handles authentication processes.
    - `notification_service.dart`: Manages notifications.

  - **`utils/`**: Utility functions and constants.
    - `constants.dart`: Contains application-wide constants.

  - **`widgets/`**: Reusable UI components.
    - `animated_background.dart`: Custom animated background widget.
    - `fancy_button.dart`: Custom button widget.
    - `firebase_options.dart`: Firebase configuration settings.

  - **`main.dart`**: Entry point of the application and root widget.

### Summary

This architecture separates concerns into distinct directories:
- **Models** for data representation.
- **Services** for business logic and external interactions.
- **Screens** for different views.
- **Widgets** for reusable UI components.
- **Config** for app-wide configuration.
- **Utils** for constants and utility functions.


## Getting Started

1. Clone the repository
2. Ensure you have Flutter (SDK version ^3.5.2) installed
3. Run `flutter pub get` to install dependencies
4. Set up a Firebase project and add configuration files
5. Run the app using `flutter run`

## Dependencies

Major dependencies include:
- Flutter SDK: ^3.5.2
- firebase_core: ^3.4.1
- cloud_firestore: ^5.4.1
- firebase_messaging: ^15.1.1
- firebase_auth: ^5.2.1
- shared_preferences: ^2.3.2
- google_sign_in: ^6.1.0
- flutter_local_notifications: ^17.2.2
- provider: ^6.1.2
- intl: ^0.19.0

For a full list, see `pubspec.yaml`.

## Configuration

### Firebase Setup

1. Create a new Firebase project
2. Add Android and/or iOS app to your Firebase project
3. Download and add configuration files
4. Enable Authentication and set up Google Sign-In
5. Set up Cloud Firestore database

### Notification Preferences

Users can customize notification settings for News and Event notifications, and set notification frequency.

## App Screens

1. **Login Screen** (`login_screen.dart`): Handles user authentication.
2. **Home Screen** (`home_screen.dart`): Main dashboard with personalized greeting.
3. **Notification Preferences Screen** (`notification_preferences_screen.dart`): Allows users to customize their notification settings.
4. **Notification History Screen** (`notification_history_screen.dart`): Displays a log of past notifications.

## Services

- **Auth Service** (`auth_service.dart`): Manages Firebase Authentication.
- **Notification Service** (`notification_service.dart`): Handles FCM integration and local notifications.

## Custom Widgets

- **Animated Background** (`animated_background.dart`): Provides dynamic background effects.
- **Fancy Button** (`fancy_button.dart`): Custom-styled button for consistent UI.

## Backend

- Firebase Authentication for user management
- Cloud Firestore for data storage
- Firebase Cloud Messaging for push notifications

## Future Plans

- Multi-language support



## Contact

[rohiththirunagari515@gmail.com]
