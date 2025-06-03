# MuLite - Android Music Player

MuLite is a modern, lightweight music player application developed for Android as part of a qualification project at the University of Economics and Law "KROK". Built using the **Flutter** framework and **Dart** programming language, MuLite offers a seamless and intuitive user experience for playing local audio files with a clean, minimalistic interface.

## Features
- **Offline Playback**: Play local audio files without requiring an internet connection.
- **Intuitive UI/UX**: Designed in **Figma** with a focus on simplicity, featuring a modern interface with light/dark theme support and adaptive navigation.
- **Mini-Player**: Persistent mini-player for controlling playback across all screens.
- **Playlist Management**: Organize and play music from curated playlists with smooth transitions.
- **Customizable Settings**: Change app language and theme for a personalized experience.
- **MVVM Architecture**: Utilizes the Model-View-ViewModel pattern combined with the Repository pattern for scalable and maintainable code.

## Tech Stack
- **Framework**: Flutter (Dart)
- **Design**: Figma for UI/UX prototyping
- **Libraries**: just_audio, audio_service, provider, flutter_localization, google_fonts, font_awesome_flutter, shared_preferences
- **IDE**: Visual Studio Code with Android Studio for emulator support

## Project Structure
- **Start Screen**: Welcomes users with animated logo and text, offering login/registration options.
- **Main Screen**: Displays quick picks and trending tracks with a grid and horizontal list view.
- **Player Screen**: Full-featured audio controls including play/pause, skip, repeat, and seek.
- **Settings Screen**: Allows theme and language customization.
- **Playlist Screen**: Organizes tracks by genre with smooth navigation to the player.

## Future Enhancements
- Integration with cloud storage for online music streaming.
- Support for local device music libraries.
- Expanded settings for additional customization.
- Enhanced UI with advanced animations and visual effects.

## Installation
1. Clone the repository: `git clone https://github.com/yourusername/mulite.git`
2. Navigate to the project directory: `cd mulite`
3. Install dependencies: `flutter pub get`
4. Run the app on an Android emulator or device: `flutter run`

## Requirements
- Android 8.0 or higher
- Flutter SDK
- Android Studio (for emulator setup)

## Documentation
The project includes a comprehensive 97-page report detailing the development process, including:
- Analysis of existing music players (YouTube Music, Spotify, VLC, Musicolet).
- MVVM architecture design with Repository pattern.
- UI/UX design process in Figma with low-fidelity wireframes.
- Implementation details using Flutter and Dart.
- Testing results on virtual and physical Android devices.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
Developed as part of the qualification work for the "Computer Science" specialty at the University of Economics and Law "KROK". Special thanks to the project supervisor, Viktor Kirichenko, for guidance and support.

---

Feel free to contribute or provide feedback to enhance MuLite's functionality!
