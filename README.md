# 🎮 TicTacToe Betclic

A modern and elegant **Tic Tac Toe** game built with **Flutter**, using **Riverpod** for state management and **Firebase** for crash reporting.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue?logo=flutter)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey)

---

## ✨ Features

- 🎨 **Beautiful animated UI** with smooth gradients and shadows
- 🧠 **Reactive state management** using Riverpod
- ⚡ **Fast and responsive gameplay**
- 🧩 **Draw, win and reset logic** handled automatically
- 🧰 **Modular architecture** with entities, state notifiers, and widgets
- ☁️ **Firebase Crashlytics** integration for error tracking
- 🔒 **Secure local storage** with `flutter_secure_storage`

---

## 🧱 Project Structure

```
lib/
├── src/
│   ├── core/
│   │   ├── rooting/
│   │   ├── utils/
│   │   └── theme/
│   ├── data/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   ├── ai/
│   │   ├── entities/
│   │   └── states/
│   ├── presentation/
│   │   ├── pages/
│   │   ├── widgets/
│   ├── services/
│   │   ├── firebase/
│   │   ├── game/
│   │   └── secure_storage/
│   └── app.dart
├── firebase_options.dart
└── main.dart
```

---

## 🧩 Technologies Used

| Category | Package | Description |
|-----------|----------|-------------|
| **State Management** | [`hooks_riverpod`](https://pub.dev/packages/hooks_riverpod) | Simplifies reactive state updates |
| **Navigation** | [`go_router`](https://pub.dev/packages/go_router) | Declarative routing |
| **Serialization** | [`json_serializable`](https://pub.dev/packages/json_serializable) | Generates model serialization code |
| **Code Generation** | [`freezed`](https://pub.dev/packages/freezed) | Data classes and unions |
| **Styling** | [`flex_color_scheme`](https://pub.dev/packages/flex_color_scheme) | Consistent app theming |
| **Crash Reporting** | [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics) | Reports runtime errors |
| **Secure Storage** | [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Encrypted key-value storage |
| **Testing** | [`mocktail`](https://pub.dev/packages/mocktail) | Mocking for unit tests |
| **UI Tests** | [`golden_toolkit`](https://pub.dev/packages/golden_toolkit) | Golden tests for UI snapshots |

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

- Flutter SDK `>=3.9.2`
- Dart SDK compatible with the above
- Firebase project configured (if using Crashlytics)

### 2️⃣ Install dependencies

```bash
flutter pub get
```

### 3️⃣ Run the app

```bash
flutter run
```

### 4️⃣ Generate code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
fluttergen -c pubspec.yaml
```

---

## 🧪 Running Tests

```bash
flutter test
```

You can also run golden tests for visual regression checks:

```bash
flutter test --tags=golden
```

---

## 🧑‍💻 Author

**tictactoebetclic** is developed as a clean Flutter example showcasing Riverpod and Flutter Hooks integration.

---

## 📄 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.
