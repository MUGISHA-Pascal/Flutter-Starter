# Flutter Starter

A starter Flutter project featuring user authentication and a simple blog system. This project demonstrates best practices in Flutter app architecture, state management, and integration with modern backend services.

## Features

- **User Authentication**: Sign up, login, and session management using Supabase.
- **Blog System**:
  - Create, list, and view blog posts
  - Each blog includes a title, content, image, topics, author, and date
  - Select from predefined topics: Technology, Business, Programming, Entertainment
- **State Management**: Uses Bloc for scalable and testable state management.
- **Local Storage**: Utilizes Hive for efficient local data storage.
- **Modern UI**: Clean, responsive design with reusable widgets.

## Project Structure

- `lib/features/auth`: Authentication logic (data, domain, presentation)
- `lib/features/blog`: Blog logic (data, domain, presentation)
- `lib/core`: Shared utilities, constants, themes, and widgets (e.g., Loader)

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd flutter_starter
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Configure Supabase:**
   - Add your Supabase URL and anon key to `lib/core/secrets/app_secrets.dart`.
4. **Run the app:**
   ```bash
   flutter run
   ```

## Dependencies

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [supabase_flutter](https://pub.dev/packages/supabase_flutter)
- [hive](https://pub.dev/packages/hive)
- [get_it](https://pub.dev/packages/get_it)
- [image_picker](https://pub.dev/packages/image_picker)
- [fpdart](https://pub.dev/packages/fpdart)
- [internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus)

See `pubspec.yaml` for the full list.

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Bloc documentation](https://bloclibrary.dev/#/)
- [Supabase documentation](https://supabase.com/docs)

---

This project is intended as a starting point for building robust Flutter applications with authentication and content features. Contributions and suggestions are welcome!
