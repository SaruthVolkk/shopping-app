# Shopping App

A Flutter shopping application built with Bloc state management, Dio for HTTP requests, and a host of other modern Flutter packages.

## Getting Started

Before running the app, make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started) installed and properly set up on your machine. Note: This project requires Flutter version 3.22.3.

### Prerequisites

- Flutter SDK (version 3.22.3)
- A code editor (e.g., VS Code or Android Studio)
- An emulator or physical device for testing

### Installation

1. Clone the repository:  
   git clone https://github.com/your-username/shopping-app.git
2. Move into the project directory:  
   cd shopping-app
3. Run the app:  
   flutter run

## Project Structure

The project is organized to separate core functionalities and resources:

```
shopping-app/
├── android/            # Android-specific configuration and files
├── ios/                # iOS-specific configuration and files
├── lib/                # Main application code
│   ├── screens/        # UI screens (e.g., home, product details)
│   ├── models/         # Data models for the app
│   ├── widgets/        # Custom widgets and UI components
│   └── main.dart       # Entry point of the Flutter application
├── assets/             # Static resources like images, icons, and fonts
├── test/              # Test cases to ensure app functionality
└── README.md           # This file
```

This structure promotes modular development, easier maintenance, and better scalability as the project grows.
