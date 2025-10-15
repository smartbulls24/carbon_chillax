# Project Blueprint

## Overview

This document outlines the plan for creating a Flutter application with a comprehensive authentication flow using Firebase. The application will feature a splash screen, an onboarding experience for new users, and a robust authentication system with email/password and Google Sign-In options.

## Features

### 1. **Splash Screen**
- A simple and elegant splash screen will be displayed when the application starts.

### 2. **Onboarding Experience**
- A 3-step onboarding process will guide new users through the app's main features.
- Users will have the option to skip the onboarding process at any time.

### 3. **Authentication**
- **Email & Password:**
  - Users can sign up and sign in using their email and password.
  - A "Forgot Password" feature will allow users to reset their password.
- **Google Sign-In:**
  - Seamless one-tap sign-in and sign-up with a Google account.
- **Authentication State Persistence:**
  - The app will remember the user's login status, so they don't have to log in every time they open the app.

### 4. **Home Screen**
- A basic home screen will be accessible after a successful login.
- It will include a "Sign Out" button to log the user out.

### 5. **Theming**
- The application will feature a clean and modern light theme.

## Technical Implementation Plan

### Step 1: **Project Setup & Dependencies**
- Add the following dependencies to `pubspec.yaml`:
  - `firebase_core`
  - `firebase_auth`
  - `google_sign_in`
  - `provider`
  - `shared_preferences`
  - `smooth_page_indicator`

### Step 2: **Firebase & Android Configuration**
- Update `android/build.gradle` and `android/app/build.gradle`.
- Add `INTERNET` permission to `android/app/src/main/AndroidManifest.xml`.
- Generate SHA-1 and SHA-256 keys and add them to the Firebase project.

### Step 3: **File Structure**
- Create a structured directory layout for screens, widgets, services, and assets.

### Step 4: **UI Development**
- **Splash Screen:** Create a visually appealing splash screen.
- **Onboarding:** Implement a `PageView` with a `PageController`.
- **Authentication Screens:** Design and develop the login, registration, and forgot password screens.
- **Home Screen:** Create a simple home screen with a sign-out option.

### Step 5: **Logic & State Management**
- **Authentication Service:** Create a dedicated service to handle all Firebase authentication logic.
- **State Management:** Use the `provider` package to manage the authentication state and theme.
- **Routing:** Implement a wrapper to navigate users to the appropriate screen based on their authentication status.
