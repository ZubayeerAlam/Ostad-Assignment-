# gas_station_finder

A new Flutter project.

## Google Maps API key setup

The API key is **not** stored in this repo. Use your own key from Google Cloud Console
(enable Places API + Maps SDK for Android/iOS, and add API restrictions to the key).

1. Android: add to `android/local.properties`
   ```
   MAPS_API_KEY=your_key_here
   ```
2. iOS: create `ios/Flutter/Secrets.xcconfig`
   ```
   MAPS_API_KEY=your_key_here
   ```
3. Run the app with the key for the Places API calls:
   ```
   flutter run --dart-define=MAPS_API_KEY=your_key_here
   ```

Both files are in `.gitignore`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
