# Project Blueprint

## Overview

This document outlines the structure and implementation details of the Flutter application. The application now uses Firebase for authentication and features a modern, intuitive user interface.

## Style, Design, and Features

### Authentication
- **Firebase Authentication:** The app uses Firebase for email/password and Google Sign-In.
- **UI:** The login and registration screens have been updated with a modern design, featuring the app logo, custom fonts, and a clean layout.
- **Navigation:** The app now correctly navigates between the login/registration screens and the home screen based on the user's authentication state.
- **Error Handling:** The authentication forms include validation to ensure that users enter valid information.

### Theming
- **Color Scheme:** The app uses a green-based color scheme.
- **Typography:** The app uses Google Fonts to provide a consistent and modern look and feel.
- **Dark/Light Mode:** The app supports both light and dark themes.

## Project Structure

```
lib/
├── main.dart
├── services/
│   └── auth_service.dart
├── screens/
│   ├── auth/
│   │   ├── auth_wrapper.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── home_screen.dart
└── firebase_options.dart
```

## Current Plan

1.  **Fix UI and Authentication:** Update the application to use the new, more modern login and registration screens, and fix the authentication flow to use Firebase.
2.  **Update `main.dart`:** Initialize Firebase and set up a multi-provider for the `AuthService` and the user stream.
3.  **Update `AuthService`:** Modify the `AuthService` to initialize `FirebaseAuth` and `GoogleSignIn` internally.
4.  **Update `AuthWrapper`:** Update the `AuthWrapper` to correctly consume the user stream.
5.  **Remove Old UI:** Remove the old login and register screens to avoid confusion.
6.  **Update `blueprint.md`:** Update the `blueprint.md` file to reflect the changes made.
