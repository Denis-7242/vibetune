# 🎵 VibeTune

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**A stylish, modern music player built with Flutter**

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [Contributing](#-contributing)

</div>

---

## ✨ Features

### 🎵 **Core Music Features**
- 🎼 **Load Real Audio Files** - Scans and displays all music from your device
- ▶️ **Full Playback Control** - Play, pause, next, previous, and seek
- 🎨 **Album Art Display** - Beautiful artwork rendering with fallback gradients
- 📱 **Now Playing Screen** - Dedicated full-screen player interface
- 🎚️ **Animated Equalizer** - Live visual feedback during playback
- ⏱️ **Progress Tracking** - Real-time progress bar with seek functionality

### 🎨 **UI/UX Excellence**
- 🌓 **Light/Dark Themes** - Smooth theme switching with persistence
- 🎭 **Hero Animations** - Elegant transitions between screens
- 🌈 **Gradient Backgrounds** - Modern, eye-catching color schemes
- 🔤 **Google Fonts** - Clean Poppins typography throughout
- 💫 **Smooth Animations** - Fade, scale, and rotation effects
- 📐 **Rounded Design** - Modern card-based UI with soft shadows

### 🏗️ **Technical Features**
- 📦 **Clean Architecture** - Organized folder structure
- 🔄 **State Management** - Provider pattern for reactive UI
- 💾 **Persistent Storage** - Theme preferences saved locally
- 🔐 **Permission Handling** - Android 13+ compatible
- 🎯 **Singleton Service** - Centralized audio management
- 📱 **Responsive Design** - Adapts to different screen sizes

---

## 📸 Screenshots

### Light Theme
```
┌─────────────────────────────┐
│   VibeTune                  │
│   Your Music Library     🌙 │
│                             │
│  ┌────────────────────────┐ │
│  │ 🎵 Song Title          │ │
│  │    Artist Name    3:45 │ │
│  └────────────────────────┘ │
│                             │
│  ┌────────────────────────┐ │
│  │ 🎵 Another Song        │ │
│  │    Band Name      4:20 │ │
│  └────────────────────────┘ │
└─────────────────────────────┘
```

### Dark Theme
```
┌─────────────────────────────┐
│   VibeTune                  │
│   Your Music Library     ☀️ │
│                             │
│  ┌────────────────────────┐ │
│  │ 🎨 Album Art           │ │
│  │                        │ │
│  │    Song Playing        │ │
│  │    Artist Name         │ │
│  │                        │ │
│  │    ──────●─────        │ │
│  │   2:30        4:15     │ │
│  │                        │ │
│  │   ⏮️  ⏯️  ⏭️          │ │
│  └────────────────────────┘ │
└─────────────────────────────┘
```

---

## 🚀 Installation

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Android device or emulator

### Step 1: Clone the Repository
```bash
git clone https://github.com/Denis-7242/vibetune.git
cd vibetune
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Run the App
```bash
# For Android
flutter run

# For specific device
flutter run -d <device_id>
```

---

## 📱 Usage

### First Launch
1. **Grant Permissions** - The app will request storage/audio permissions
2. **Wait for Scan** - VibeTune will automatically scan your music library
3. **Start Playing** - Tap any song to begin playback

### Controls
- **Tap Song** - Opens Now Playing screen with full controls
- **Play/Pause** - Toggle playback state
- **Next/Previous** - Navigate between songs
- **Seek Bar** - Drag to jump to any position in the song
- **Theme Toggle** - Switch between light and dark modes (top-right)

### Permissions Required
- **READ_EXTERNAL_STORAGE** - Access music files on Android 12 and below
- **READ_MEDIA_AUDIO** - Access music files on Android 13+

---

## 🏗️ Architecture

### Folder Structure
```
lib/
├── main.dart                      # App entry point
├── models/
│   └── song_model.dart           # Song data model
├── services/
│   └── audio_player_service.dart # Audio playback singleton
├── providers/
│   ├── theme_provider.dart       # Theme state management
│   └── player_provider.dart      # Player state management
├── screens/
│   ├── home_screen.dart          # Main song list screen
│   └── now_playing_screen.dart   # Full player screen
└── widgets/
    ├── song_tile.dart            # Song list item widget
    ├── player_controls.dart      # Playback controls
    └── theme_toggle.dart         # Theme switch button
```

### Key Technologies

| Package | Purpose | Version |
|---------|---------|---------|
| `just_audio` | Audio playback engine | ^0.9.38 |
| `on_audio_query` | Device music scanning | ^2.9.0 |
| `provider` | State management | ^6.1.2 |
| `google_fonts` | Typography (Poppins) | ^6.2.1 |
| `animations` | Page transitions | ^2.0.8 |
| `shared_preferences` | Local storage | ^2.2.2 |
| `permission_handler` | Permission management | ^11.3.1 |

### Design Patterns
- **Singleton Pattern** - Audio service instance
- **Provider Pattern** - State management
- **Repository Pattern** - Data fetching and caching
- **Clean Architecture** - Separation of concerns

---

## 🎨 Theming

### Light Theme Colors
```dart
Primary: #7C3AED (Vibrant Purple)
Secondary: #34D399 (Mint Green)
Background: #F5F5F7 (Light Gray)
Surface: #FFFFFF (White)
```

### Dark Theme Colors
```dart
Primary: #8B5CF6 (Soft Purple)
Secondary: #14B8A6 (Teal)
Background: #0F172A (Deep Navy)
Surface: #1E293B (Slate)
```

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Title**: 32px, Bold
- **Subtitle**: 14-16px, Regular
- **Body**: 13-15px, Medium

---

## 🔧 Configuration

### Android Setup
Ensure your `AndroidManifest.xml` includes:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
```

### iOS Setup (Future)
Add to `Info.plist`:
```xml
<key>NSAppleMusicUsageDescription</key>
<string>VibeTune needs access to your music library</string>
```

---

## 🐛 Troubleshooting

### No Songs Appearing
- Check storage permissions are granted
- Ensure music files are in standard locations (Music, Downloads)
- Supported formats: MP3, M4A, WAV, FLAC

### Playback Issues
- Verify audio files are not corrupted
- Check device volume settings
- Restart the app

### Permission Denied
- Go to Settings → Apps → VibeTune → Permissions
- Enable "Music and audio" or "Files and media"

---

## 🚧 Roadmap

### Planned Features
- [ ] Playlist creation and management
- [ ] Favorites/Liked songs
- [ ] Search functionality
- [ ] Sort and filter options
- [ ] Shuffle and repeat modes
- [ ] Sleep timer
- [ ] Lyrics display
- [ ] Audio effects (equalizer, bass boost)
- [ ] Background playback with notifications
- [ ] Lock screen controls
- [ ] Android Auto support
- [ ] iOS support

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the Repository**
2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit Your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Contribution Guidelines
- Follow Flutter style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 VibeTune

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👨‍💻 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/Denis-7242)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- `just_audio` package maintainers
- `on_audio_query` contributors
- Google Fonts for Poppins typography
- All open-source contributors

---

## 📞 Support

Having issues? We're here to help!

- 📧 Email: dexdenis3@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/Denis-7242/vibetune/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/Denis-7242/vibetune/discussions)

---

## ⭐ Show Your Support

Give a ⭐️ if this project helped you!

---

<div align="center">

**Made with ❤️ by Denis and Flutter**

[Back to Top](#-vibetune)

</div>