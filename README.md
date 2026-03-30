# Kids Learning Hub

A fun and interactive Flutter educational app designed for children aged **3–8 years**. It teaches English language basics and foundational Math concepts through colorful, audio-enriched, page-by-page lessons — all fully offline.

---

## Table of Contents

- [Features](#features)
- [Subjects & Curriculum](#subjects--curriculum)
  - [English (15 Lessons)](#english-15-lessons)
  - [Math (15 Lessons)](#math-15-lessons)
- [App Flow](#app-flow)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
  - [Project Structure](#project-structure)
  - [State Management](#state-management)
  - [Services](#services)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Run the App](#run-the-app)
  - [Build for Release](#build-for-release)
- [Adding Content](#adding-content)
  - [Adding Lesson Images](#adding-lesson-images)
  - [Adding Audio Files](#adding-audio-files)
- [Configuration](#configuration)
- [Platform Support](#platform-support)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

---

## Features

| Feature | Description |
|---|---|
| **Two Subjects** | English Language & Mathematics |
| **30 Total Lessons** | 15 per subject, sequentially unlocked |
| **Page-by-Page Learning** | Each lesson has multiple illustrated pages |
| **Text-to-Speech (TTS)** | Tap to hear correct pronunciation for every page |
| **Background Music** | Looping background music with volume control and toggle |
| **Progress Tracking** | Lesson progress persists locally across app restarts |
| **Sequential Unlocking** | Complete a lesson to unlock the next one |
| **Offline First** | Works entirely without internet |
| **Portrait Mode** | Fixed portrait orientation optimized for kids |
| **Child-Safe UI** | Large buttons, bright colors, simple navigation |

---

## Subjects & Curriculum

### English (15 Lessons)

| # | Lesson | Content |
|---|---|---|
| 1 | **Alphabets A–Z** | All 26 letters with images (A for Apple, B for Ball…) |
| 2 | **Vowels** | A, E, I, O, U with examples (Ant, Egg, Igloo, Octopus, Umbrella) |
| 3 | **Capital & Small Letters** | Aa, Bb, Cc… uppercase and lowercase pairs |
| 4 | **Simple 3-Letter Words** | CAT, DOG, BAT, HAT, RAT |
| 5 | **Phonics Sounds** | Letter sound pronunciation (e.g., /æ/ in Apple) |
| 6 | **Animal Names** | Cat, Dog, Lion, Elephant, Monkey |
| 7 | **Fruit Names** | Apple, Banana, Orange, Mango, Grapes |
| 8 | **Vegetable Names** | Carrot, Tomato, Potato |
| 9 | **Color Names** | Red, Blue, Yellow, Green |
| 10 | **Body Parts** | Head, Eyes, Nose, Mouth, Hands |
| 11 | **Common Objects** | Book, Pencil, Chair, Table, Ball |
| 12 | **Days of the Week** | Monday through Sunday |
| 13 | **Months of the Year** | January through December |
| 14 | **Family Members** | Mother, Father, Brother, Sister, Grandmother |
| 15 | **Action Words (Verbs)** | Run, Jump, Eat, Sleep, Play |

### Math (15 Lessons)

| # | Lesson | Content |
|---|---|---|
| 1 | **Numbers 1–10** | Each number with matching objects (1 apple, 2 balls…) |
| 2 | **Numbers 11–20** | Eleven through twenty |
| 3 | **Counting Objects (1–10)** | Count apples, cars, balloons |
| 4 | **Counting More Objects (11–20)** | Count stars, balls in larger groups |
| 5 | **Basic Shapes** | Circle, Square, Triangle |
| 6 | **More Shapes** | Rectangle, Oval, Star |
| 7 | **Big and Small** | Size comparison with objects |
| 8 | **Tall and Short** | Height comparison with trees |
| 9 | **Simple Addition (1–5)** | 1+1=2, 2+1=3, 2+2=4, 3+1=4, 2+3=5 |
| 10 | **Simple Addition (6–10)** | 3+3=6, 4+3=7, 5+3=8 |
| 11 | **Simple Subtraction (1–5)** | 2-1=1, 3-1=2, 4-2=2, 5-2=3 |
| 12 | **Simple Subtraction (6–10)** | 6-3=3, 8-4=4, 10-5=5 |
| 13 | **Number Patterns** | Counting up (1,2,3…) and counting down (10,9,8…) |
| 14 | **Skip Counting** | Count by 2s, 5s, and 10s |
| 15 | **Comparing Numbers** | Greater than (>), Less than (<), Equal to (=) |

---

## App Flow

```
Splash Screen (3s animated)
        |
    Home Screen
   /            \
English         Math
   |              |
Lessons List (15 lessons, sequential lock)
        |
Lesson Detail (PageView with Previous / Next navigation)
        | (on last page)
Lesson Completed -> Next lesson unlocked
```

**Lesson states on the list screen:**
- **Locked** — greyed out with a lock icon; shows "Complete previous lesson to unlock"
- **Not Started** — shows arrow icon
- **In Progress** — shows clock icon (orange)
- **Completed** — shows green checkmark

---

## Screenshots

> Add your screenshots to a `screenshots/` folder and update the paths below.

| Splash | Home | Lessons List |
|---|---|---|
| *(add screenshot)* | *(add screenshot)* | *(add screenshot)* |

| Lesson Page | Audio Playing | Lesson Complete |
|---|---|---|
| *(add screenshot)* | *(add screenshot)* | *(add screenshot)* |

---

## Architecture

### Project Structure

```
lib/
├── config/
│   └── app_config.dart           # App-wide configuration & feature flags
├── data/
│   ├── english_lessons_data.dart # All 15 English lessons content
│   ├── math_lessons_data.dart    # All 15 Math lessons content
│   └── lesson_repository.dart   # Repository abstraction layer
├── models/
│   ├── achievement.dart          # Achievement model & types
│   ├── category.dart             # Category model (English / Math)
│   ├── lesson.dart               # Lesson model with lock/complete state
│   ├── lesson_page.dart          # Individual lesson page model
│   ├── lesson_progress.dart      # Per-lesson progress tracking
│   ├── user_profile.dart         # User profile with streaks
│   └── user_progress.dart        # Overall progress with daily activity
├── providers/
│   ├── app_state_provider.dart   # Music, sound effects, language, theme
│   ├── lesson_provider.dart      # Lesson loading, locking, unlocking
│   └── progress_provider.dart   # Progress save/load via SharedPreferences
├── screens/
│   ├── splash_screen.dart        # Animated splash (fade + scale)
│   ├── home_screen.dart          # Subject selection + music controls
│   ├── lessons_list_screen.dart  # Scrollable list with lock indicators
│   └── lesson_detail_screen.dart # PageView lesson player
├── services/
│   ├── audio_service.dart        # Singleton: background music + TTS
│   ├── navigation_service.dart   # Global navigator key
│   └── storage_service.dart     # SharedPreferences wrapper
├── utils/
│   ├── constants.dart            # Colors, gradients, dimensions, strings
│   ├── helpers.dart              # Utility functions
│   ├── routes.dart               # Named route generation
│   └── theme.dart               # Light & dark Material 3 themes
├── widgets/
│   ├── audio_player_button.dart  # FAB for TTS / audio playback
│   ├── custom_button.dart        # Reusable subject button
│   ├── lesson_card.dart          # Card with lock/progress indicators
│   ├── lesson_page_widget.dart   # Full-page lesson content display
│   └── page_indicator.dart       # Dot indicator for lesson pages
└── main.dart                     # Entry point, provider setup, service init
```

### State Management

The app uses the **Provider** package with three `ChangeNotifier` providers:

| Provider | Responsibility |
|---|---|
| `LessonProvider` | Load lessons by category, manage sequential lock/unlock logic |
| `ProgressProvider` | Persist and restore lesson completion state via SharedPreferences |
| `AppStateProvider` | Music toggle, sound effects, language selection, theme mode |

### Services

| Service | Pattern | Responsibility |
|---|---|---|
| `AudioService` | Singleton | Background music (loop), TTS pronunciation, volume control |
| `StorageService` | Static | Typed SharedPreferences wrapper (String, Int, JSON…) |
| `NavigationService` | Static | Global `NavigatorKey` for navigation outside widget tree |

---

## Tech Stack

| Package | Version | Purpose |
|---|---|---|
| `flutter` | SDK | UI framework |
| `provider` | ^6.1.1 | State management |
| `shared_preferences` | ^2.2.2 | Local progress persistence |
| `audioplayers` | ^5.2.1 | Background music playback |
| `flutter_tts` | ^4.0.2 | Text-to-speech pronunciation |
| `google_fonts` | ^6.1.0 | Poppins font family |
| `flutter_svg` | ^2.0.9 | SVG asset support |
| `path_provider` | ^2.1.1 | File system paths |
| `intl` | ^0.18.1 | Date/number formatting |
| `cupertino_icons` | ^1.0.6 | iOS-style icons |

**Dart SDK:** `>=3.3.4 <4.0.0`

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.3.4)
- Android Studio or VS Code with Flutter extension
- Android device/emulator (API 21+) or iOS device/simulator (iOS 12+)

Verify your setup:
```bash
flutter doctor
```

### Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/child_learning_app.git
cd child_learning_app

# Install dependencies
flutter pub get
```

### Run the App

```bash
# Run on connected device/emulator
flutter run

# Run on a specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### Build for Release

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle (Play Store):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## Adding Content

### Adding Lesson Images

Place images under the correct path in `assets/images/`:

```
assets/images/
├── splash/
│   └── logo.png
├── icons/                          # Category & lesson icons
├── backgrounds/                    # Home screen background & illustration
└── lessons/
    ├── english/
    │   ├── alphabets/              # a_apple.png, b_ball.png, c_cat.png ...
    │   ├── vowels/                 # a_ant.png, e_egg.png, i_igloo.png ...
    │   ├── capital_small/          # Aa.png, Bb.png, Cc.png ...
    │   ├── words/                  # cat.png, dog.png, bat.png ...
    │   ├── animals/                # cat.png, dog.png, lion.png ...
    │   ├── fruits/                 # apple.png, banana.png ...
    │   ├── vegetables/             # carrot.png, tomato.png ...
    │   ├── colors/                 # red.png, blue.png, yellow.png ...
    │   ├── body_parts/             # head.png, eyes.png, nose.png ...
    │   └── objects/                # book.png, pencil.png, calendar.png ...
    └── math/
        ├── numbers/                # one_apple.png, two_balls.png ...
        ├── counting/               # three_apples.png, five_cars.png ...
        ├── shapes/                 # circle.png, square.png, triangle.png ...
        ├── comparison/             # big_ball.png, tall_tree.png ...
        ├── addition/               # one_plus_one.png, two_plus_one.png ...
        ├── subtraction/            # two_minus_one.png ...
        └── patterns/               # pattern_123.png, skip_2.png ...
```

Assets are already declared in `pubspec.yaml` — just drop files in the right folder.

### Adding Audio Files

Place audio files (`.mp3`) under `assets/audio/`:

```
assets/audio/
├── background_music.mp3
├── background_music1.mp3
├── background_music2.mp3           # Currently playing on launch
├── english/
│   ├── a.mp3, b.mp3 ... z.mp3     # Alphabet letter sounds
│   ├── vowel_a.mp3, vowel_e.mp3 ...
│   ├── word_cat.mp3, word_dog.mp3 ...
│   ├── animal_cat.mp3, animal_dog.mp3 ...
│   ├── fruit_apple.mp3, fruit_banana.mp3 ...
│   ├── color_red.mp3, color_blue.mp3 ...
│   ├── body_head.mp3, body_eyes.mp3 ...
│   ├── day_monday.mp3 ... day_sunday.mp3
│   ├── month_january.mp3 ... month_december.mp3
│   ├── family_mother.mp3 ... family_grandmother.mp3
│   └── action_run.mp3, action_jump.mp3 ...
└── math/
    ├── one.mp3, two.mp3 ... twenty.mp3
    ├── shape_circle.mp3, shape_square.mp3 ...
    ├── add_1_1.mp3, add_2_1.mp3 ...
    ├── sub_2_1.mp3, sub_3_1.mp3 ...
    ├── comp_big.mp3, comp_tall.mp3 ...
    ├── greater_than.mp3, less_than.mp3, equal_to.mp3
    └── skip_2.mp3, skip_5.mp3, skip_10.mp3
```

> **Note:** If an audio file is missing, the app automatically falls back to the device's **Text-to-Speech** engine to pronounce the lesson content, so the app is fully functional without any audio assets.

---

## Configuration

All key settings are in `lib/config/app_config.dart`:

```dart
class AppConfig {
  static const String appName = 'Kids Learning Hub';
  static const String appVersion = '1.0.0';

  // Target age range
  static const int minUserAge = 3;
  static const int maxUserAge = 8;

  // Feature flags
  static const bool enableAudio = true;
  static const bool enableAnimations = true;
  static const bool enableAnalytics = false;       // Toggle to enable analytics
  static const bool enableCrashReporting = false;  // Toggle to enable crash reporting

  // Splash screen duration
  static const Duration splashDuration = Duration(seconds: 3);

  // Max lessons per category
  static const int maxLessonsPerCategory = 15;
}
```

---

## Platform Support

| Platform | Status | Notes |
|---|---|---|
| Android | Supported | Primary target (API 21+) |
| iOS | Supported | iOS 12+ |
| Web | Partial | TTS and audio may vary by browser |
| macOS | Partial | Desktop layout not optimized |
| Windows | Partial | Desktop layout not optimized |
| Linux | Partial | Desktop layout not optimized |

The app enforces **portrait-only** orientation, optimized for phones and small tablets.

---

## Roadmap

- [ ] Add all lesson images and audio assets
- [ ] Complete Months of the Year (April–December pages)
- [ ] Quiz / interactive page type (`PageType.quiz` already in model)
- [ ] Video content support (`PageType.video` already in model)
- [ ] Achievements & badges system (models already defined)
- [ ] Multiple child profiles with separate progress
- [ ] Urdu language support (`AppStateProvider.setLanguage` already wired)
- [ ] Dark mode (theme defined, toggle available in `AppStateProvider`)
- [ ] Progress statistics & activity chart screen
- [ ] Parental controls / PIN lock settings
- [ ] Animated mascot / character guide

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a Pull Request

Please keep child-safety and age-appropriateness (ages 3–8) in mind for all contributions.

---

## License

This project is open source. Add your preferred license (e.g., MIT, Apache 2.0).

```
MIT License — see LICENSE file for details
```

---

*Built with Flutter — Learning Made Fun for Every Child*
