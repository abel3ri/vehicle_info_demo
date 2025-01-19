# Vehicle Info Demo

A simple Flutter demo app for managing and displaying vehicle information. This project demonstrates key Flutter features, including state management, UI design, and basic integration with Firestore

## Features

- Show and Edit vehicle information.
- View a list of vehicles with relevant details.
- User-friendly and responsive design.

## Getting Started

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install)).
- Compatible IDE (e.g., [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)).

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abel3ri/vehicle_info_demo.git
   cd vehicle_info_demo
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Folder Structure

```
vehicle_info_demo
lib/
├── app/              # Core application components
│   ├── data/         # Data layer
│   │   ├── models/   # Data models
│   │   ├── services/ # API and backend services
│   └── modules/      # Feature modules (UI, logic)
│       ├── routes/   # App routes
│       └── core/     # Shared resources
│           ├── controllers/ # Logic and state management
│           ├── services/    # Core services
│           └── widgets/     # Shared widgets
└── main.dart         # Entry point of the application
└── firebase_options.dart         # Firebase setup
```

## Screenshots

<img src="https://github.com/user-attachments/assets/cd47f293-4e7a-4af5-bf00-744df037d84b" alt="Screenshot 1" width="250">
<img src="https://github.com/user-attachments/assets/12c8ae68-058b-4827-8a89-cec0d652a97a" alt="Screenshot 2" width="250">
<img src="https://github.com/user-attachments/assets/cf533601-bb25-4aee-8827-a2043e2251c1" alt="Screenshot 3" width="250">

## Technologies Used

- **Flutter**: For building cross-platform mobile apps.
- **Dart**: The programming language used in Flutter.
- **Getx**: For efficient state manegment.
- **getx_pattern**: For scalable and clean architecture.
- **Google Maps**: For displaying car location.
- **Firestore**: For persistent data.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with clear descriptions.
4. Push to your fork and create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, feel free to reach out:

- GitHub: [@abel3ri](https://github.com/abel3ri)
- Email: [abelmerete22@gmail.com](mailto:abelmerete22@gmail.com)
